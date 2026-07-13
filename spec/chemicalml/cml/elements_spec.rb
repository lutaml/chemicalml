# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Cml::Formula do
  it "round-trips concise + inline forms" do
    f = described_class.new(concise: "C 1 H 4 O 0", inline: "H_{3}C-OH")
    re = described_class.from_xml(f.to_xml)
    expect(re.concise).to eq("C 1 H 4 O 0")
    expect(re.inline).to eq("H_{3}C-OH")
  end
end

RSpec.describe Chemicalml::Cml::Scalar do
  it "round-trips value + dataType + units" do
    s = described_class.new(content: "298.15",
                            data_type: "xsd:double",
                            units: "si:K")
    re = described_class.from_xml(s.to_xml)
    expect(re.content).to eq("298.15")
    expect(re.data_type).to eq("xsd:double")
    expect(re.units).to eq("si:K")
  end
end

RSpec.describe Chemicalml::Cml::Array do
  it "round-trips space-separated values + size" do
    a = described_class.new(content: "1.0 2.0 3.0",
                            data_type: "xsd:double",
                            size: "3")
    re = described_class.from_xml(a.to_xml)
    expect(re.content).to eq("1.0 2.0 3.0")
    expect(re.size).to eq("3")
  end
end

RSpec.describe Chemicalml::Cml::Matrix do
  it "round-trips rows + columns" do
    m = described_class.new(content: "1 0 0 0 1 0 0 0 1",
                            data_type: "xsd:double",
                            rows: "3",
                            columns: "3")
    re = described_class.from_xml(m.to_xml)
    expect(re.rows).to eq("3")
    expect(re.columns).to eq("3")
  end
end

RSpec.describe Chemicalml::Cml::Property do
  it "wraps a scalar value and carries a dictRef" do
    p = described_class.new(
      dict_ref: "compchem:totalEnergy",
      title: "total energy",
      scalar: Chemicalml::Cml::Scalar.new(
        content: "-38.887",
        data_type: "xsd:double",
        units: "nonsi:hartree"
      )
    )
    re = described_class.from_xml(p.to_xml)
    expect(re.dict_ref).to eq("compchem:totalEnergy")
    expect(re.scalar.content).to eq("-38.887")
  end
end

RSpec.describe Chemicalml::Cml::Parameter do
  it "carries a scalar input" do
    p = described_class.new(
      dict_ref: "compchem:method",
      scalar: Chemicalml::Cml::Scalar.new(content: "dft",
                                          data_type: "xsd:string")
    )
    re = described_class.from_xml(p.to_xml)
    expect(re.scalar.content).to eq("dft")
  end
end

RSpec.describe Chemicalml::Cml::Module do
  it "parses a minimal compchem module" do
    xml = <<~XML
      <module xmlns="http://www.xml-cml.org/schema"
              convention="convention:compchem">
        <module dictRef="compchem:jobList" id="jl-1">
          <module dictRef="compchem:job" id="job-1">
            <module dictRef="compchem:initialization"/>
          </module>
        </module>
      </module>
    XML

    m = described_class.from_xml(xml)
    expect(m.convention).to eq("convention:compchem")
    expect(m.modules.size).to eq(1)
    expect(m.modules.first.dict_ref).to eq("compchem:jobList")
  end

  it "round-trips nested modules" do
    m = described_class.new(
      dict_ref: "compchem:jobList",
      id: "jl-1",
      modules: [
        described_class.new(dict_ref: "compchem:job", id: "j-1")
      ]
    )
    re = described_class.from_xml(m.to_xml)
    expect(re.modules.first.id).to eq("j-1")
    expect(re.modules.first.dict_ref).to eq("compchem:job")
  end
end

RSpec.describe Chemicalml::Cml::Label do
  it "round-trips value + dictRef" do
    l = described_class.new(value: "cc-pvdz", dict_ref: "compchem:basisSetLabel")
    re = described_class.from_xml(l.to_xml)
    expect(re.value).to eq("cc-pvdz")
    expect(re.dict_ref).to eq("compchem:basisSetLabel")
  end
end

RSpec.describe Chemicalml::Cml::Metadata do
  it "round-trips name + content" do
    m = described_class.new(name: "dc:creator", content: "joe")
    re = described_class.from_xml(m.to_xml)
    expect(re.name).to eq("dc:creator")
    expect(re.content).to eq("joe")
  end
end

RSpec.describe Chemicalml::Cml::AtomParity do
  it "round-trips atomRefs4 + value" do
    p = described_class.new(atom_refs4: "a1 a2 a3 a4", content: "1")
    re = described_class.from_xml(p.to_xml)
    expect(re.atom_refs4).to eq("a1 a2 a3 a4")
    expect(re.content).to eq("1")
  end
end

RSpec.describe Chemicalml::Cml::BondStereo do
  it "round-trips a cis bondStereo with atomRefs4" do
    s = described_class.new(atom_refs4: "a1 a2 a3 a4", content: "C")
    re = described_class.from_xml(s.to_xml)
    expect(re.atom_refs4).to eq("a1 a2 a3 a4")
    expect(re.content).to eq("C")
  end
end

RSpec.describe Chemicalml::Cml::Dictionary do
  it "round-trips a minimal dictionary with one entry" do
    d = described_class.new(
      title: "example",
      namespace: "http://example.org/dict/",
      dictionary_prefix: "ex",
      entries: [
        Chemicalml::Cml::DictionaryEntry.new(
          id: "foo",
          term: "Foo",
          data_type: "xsd:string",
          unit_type: "unitType:none",
          definition: "A foo is a foo."
        )
      ]
    )
    re = described_class.from_xml(d.to_xml)
    expect(re.title).to eq("example")
    expect(re.namespace).to eq("http://example.org/dict/")
    expect(re.dictionary_prefix).to eq("ex")
    expect(re.entries.first.id).to eq("foo")
    expect(re.entries.first.term).to eq("Foo")
  end
end

RSpec.describe Chemicalml::Cml::Unit do
  it "round-trips an SI unit definition" do
    u = described_class.new(
      id: "s", title: "second", symbol: "s",
      parent_si: "siUnits:s", multiplier_to_si: "1",
      constant_to_si: "0", unit_type: "unitType:time",
      definition: "The SI base unit of time."
    )
    re = described_class.from_xml(u.to_xml)
    expect(re.id).to eq("s")
    expect(re.parent_si).to eq("siUnits:s")
    expect(re.unit_type).to eq("unitType:time")
  end
end
