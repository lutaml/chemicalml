# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'XSD attribute gap closure (TODO 62)' do
  let(:mod_class) { Chemicalml::Cml::Schema3::Module }

  examples = {
    Bond: [:atom_refs, 'atomRefs', 'a1 a2 a3'],
    CellParameter: [:type, 'type', 'length'],
    Module: [:file_id, 'fileId', 'cml-test-1'],
    Module2: [:version, 'version', '1.2.3'],
    Module3: [:role, 'role', 'job'],
    Module4: [:serial, 'serial', '5'],
    Eigen: [:orientation, 'orientation', 'row'],
    Isotope: [:spin, 'spin', '0.5'],
    Molecule: [:formula, 'formula', 'C 2 H 6 O'],
    PeakStructure: [:type, 'type', 'doublet'],
    Potential: [:form, 'form', 'morse'],
    Reaction: [:reaction_format, 'format', 'cml'],
    Reaction2: [:reaction_role, 'role', 'reactant'],
    ReactionScheme: [:reaction_type, 'type', 'consecutive'],
    Spectrum: [:type, 'type', 'ir'],
    Substance: [:id, 'id', 's1'],
    SubstanceList: [:type, 'type', 'solvent'],
    UnitList: [:type, 'type', 'si'],
    Band: [:kpoint, 'kpoint', '0.0 0.0 0.5'],
    Alternative: [:type, 'type', 'synonym'],
    RelatedEntry: [:type, 'type', 'related'],
    DictionaryEntry: [:pattern, 'pattern', '[A-Z]+'],
    DictionaryEntry2: [:fraction_digits, 'fractionDigits', '3'],
    DictionaryEntry3: [:white_space, 'whiteSpace', 'collapse']
  }

  examples.each do |label, (attr, wire, value)|
    it "#{label} round-trips :#{attr} (wire=#{wire})" do
      klass = case label
              when :Bond              then Chemicalml::Cml::Schema3::Bond
              when :CellParameter     then Chemicalml::Cml::Schema3::CellParameter
              when :Module, :Module2,
                   :Module3, :Module4 then mod_class
              when :Eigen             then Chemicalml::Cml::Schema3::Eigen
              when :Isotope           then Chemicalml::Cml::Schema3::Isotope
              when :Molecule          then Chemicalml::Cml::Schema3::Molecule
              when :PeakStructure     then Chemicalml::Cml::Schema3::PeakStructure
              when :Potential         then Chemicalml::Cml::Schema3::Potential
              when :Reaction, :Reaction2 then Chemicalml::Cml::Schema3::Reaction
              when :ReactionScheme    then Chemicalml::Cml::Schema3::ReactionScheme
              when :Spectrum          then Chemicalml::Cml::Schema3::Spectrum
              when :Substance         then Chemicalml::Cml::Schema3::Substance
              when :SubstanceList     then Chemicalml::Cml::Schema3::SubstanceList
              when :UnitList          then Chemicalml::Cml::Schema3::UnitList
              when :Band              then Chemicalml::Cml::Schema3::Band
              when :Alternative       then Chemicalml::Cml::Schema24::Alternative
              when :RelatedEntry      then Chemicalml::Cml::Schema24::RelatedEntry
              when :DictionaryEntry,
                   :DictionaryEntry2,
                   :DictionaryEntry3 then Chemicalml::Cml::Schema3::DictionaryEntry
              end
      instance = klass.new(attr => value)
      xml = instance.to_xml
      expect(xml).to include("#{wire}=\"#{value}\"")
    end
  end
end
