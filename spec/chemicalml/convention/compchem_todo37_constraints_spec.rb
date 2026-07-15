# frozen_string_literal: true

require "spec_helper"

RSpec.describe "compchem convention TODO-37 constraints" do
  let(:mod_class) { Chemicalml::Cml::Schema3::Module }

  def compchem_doc(inner_modules:)
    mod_class.new(
      id: "root",
      convention: "convention:compchem",
      modules: inner_modules
    )
  end

  def job(id: "j1", modules: [])
    mod_class.new(id: id, dict_ref: "compchem:job", modules: modules)
  end

  def job_list(id: "jl1", modules: [])
    mod_class.new(id: id, dict_ref: "compchem:jobList", modules: modules)
  end

  def initialization(id: "init1")
    mod_class.new(id: id, dict_ref: "compchem:initialization")
  end

  def calc(id: "calc1")
    mod_class.new(id: id, dict_ref: "compchem:calculation")
  end

  def finalization(id: "fin1")
    mod_class.new(id: id, dict_ref: "compchem:finalization")
  end

  def environment(id: "env1")
    mod_class.new(id: id, dict_ref: "compchem:environment")
  end

  def validate(node)
    Chemicalml::Convention::Compchem.validate(node)
  end

  describe "JobListModuleMustHaveId / JobModuleMustHaveId" do
    it "flags a jobList without id" do
      bad_root = mod_class.new(
        convention: "convention:compchem",
        modules: [mod_class.new(dict_ref: "compchem:jobList",
                                modules: [job(modules: [initialization])])]
      )
      violations = validate(bad_root)
      expect(violations.map(&:message))
        .to include(match(/jobList module must have an id/))
    end

    it "flags a job without id" do
      bad_root = mod_class.new(
        convention: "convention:compchem",
        modules: [job_list(id: "jl1",
                           modules: [mod_class.new(dict_ref: "compchem:job",
                                                   modules: [initialization])])]
      )
      violations = validate(bad_root)
      expect(violations.map(&:message))
        .to include(match(/job module must have an id/))
    end
  end

  describe "JobModuleAtMostOneFinalization" do
    it "flags a job with two finalizations" do
      doc = compchem_doc(
        inner_modules: [job_list(modules: [
          job(modules: [initialization, finalization(id: "f1"), finalization(id: "f2")])
        ])]
      )
      violations = validate(doc)
      expect(violations.map(&:message))
        .to include(match(/job module must contain at most one finalization/))
    end
  end

  describe "JobModuleAtMostOneEnvironment" do
    it "flags a job with two environments" do
      doc = compchem_doc(
        inner_modules: [job_list(modules: [
          job(modules: [initialization,
                        environment(id: "e1"), environment(id: "e2")])
        ])]
      )
      violations = validate(doc)
      expect(violations.map(&:message))
        .to include(match(/job module must contain at most one environment/))
    end
  end

  describe "CalculationRequiresFinalization" do
    it "flags a calculation without finalization" do
      doc = compchem_doc(
        inner_modules: [job_list(modules: [
          job(modules: [initialization, calc])
        ])]
      )
      violations = validate(doc)
      expect(violations.map(&:message))
        .to include(match(/calculation but no finalization/))
    end

    it "passes when calculation has finalization" do
      doc = compchem_doc(
        inner_modules: [job_list(modules: [
          job(modules: [initialization, calc, finalization])
        ])]
      )
      violations = validate(doc)
      expect(violations.map(&:message))
        .not_to include(match(/calculation but no finalization/))
    end
  end

  describe "InitializationAtMostOneMolecule" do
    it "flags initialization with two molecules" do
      m1 = Chemicalml::Cml::Schema3::Molecule.new(id: "m1")
      m2 = Chemicalml::Cml::Schema3::Molecule.new(id: "m2")
      bad_init = mod_class.new(
        id: "init1", dict_ref: "compchem:initialization",
        molecules: [m1, m2]
      )
      doc = compchem_doc(inner_modules: [job_list(modules: [job(modules: [bad_init])])])
      violations = validate(doc)
      expect(violations.map(&:message))
        .to include(match(/initialization module must not contain more than one molecule/))
    end
  end

  describe "InitializationMustNotContainProperty" do
    it "flags initialization with propertyList" do
      pl = Chemicalml::Cml::Schema3::PropertyList.new
      bad_init = mod_class.new(
        id: "init1", dict_ref: "compchem:initialization",
        property_lists: [pl]
      )
      doc = compchem_doc(inner_modules: [job_list(modules: [job(modules: [bad_init])])])
      violations = validate(doc)
      expect(violations.map(&:message))
        .to include(match(/initialization module must not contain propertyList/))
    end
  end

  describe "ScalarUnits" do
    it "flags numeric scalar without units" do
      scalar = Chemicalml::Cml::Schema3::Scalar.new(
        data_type: "xsd:double", content: "1.0"
      )
      doc = compchem_doc(
        inner_modules: [job_list(modules: [
          job(modules: [
            mod_class.new(
              id: "init1", dict_ref: "compchem:initialization",
              parameter_lists: [
                Chemicalml::Cml::Schema3::ParameterList.new(
                  parameters: [Chemicalml::Cml::Schema3::Parameter.new(scalar: scalar)]
                )
              ]
            )
          ])
        ])]
      )
      violations = validate(doc)
      expect(violations.map(&:message))
        .to include(match(/scalar with dataType.*must have units/))
    end

    it "flags string scalar with units" do
      scalar = Chemicalml::Cml::Schema3::Scalar.new(
        data_type: "xsd:string", content: "hello", units: "kg"
      )
      doc = compchem_doc(
        inner_modules: [job_list(modules: [
          job(modules: [
            mod_class.new(
              id: "init1", dict_ref: "compchem:initialization",
              parameter_lists: [
                Chemicalml::Cml::Schema3::ParameterList.new(
                  parameters: [Chemicalml::Cml::Schema3::Parameter.new(scalar: scalar)]
                )
              ]
            )
          ])
        ])]
      )
      violations = validate(doc)
      expect(violations.map(&:message))
        .to include(match(/scalar with dataType 'xsd:string' must not have units/))
    end
  end

  describe "ArrayRules" do
    it "flags array missing size" do
      array = Chemicalml::Cml::Schema3::Array.new(
        data_type: "xsd:double", content: "1.0 2.0", units: "kg"
      )
      violations = validate(array)
      expect(violations.map(&:message))
        .to include(match(/array must have a size attribute/))
    end

    it "flags array with wrong dataType" do
      array = Chemicalml::Cml::Schema3::Array.new(
        data_type: "xsd:string", size: "2", content: "a b", units: "kg"
      )
      violations = validate(array)
      expect(violations.map(&:message))
        .to include(match(/array dataType must be xsd:integer or xsd:double/))
    end
  end

  describe "MatrixRules" do
    it "flags matrix missing rows" do
      matrix = Chemicalml::Cml::Schema3::Matrix.new(
        columns: "2", data_type: "xsd:double", content: "1 2 3 4", units: "kg"
      )
      violations = validate(matrix)
      expect(violations.map(&:message))
        .to include(match(/matrix must have a rows attribute/))
    end
  end

  it "registers 18 compchem constraints" do
    expect(Chemicalml::Convention::Compchem.constraint_count).to eq(18)
  end
end
