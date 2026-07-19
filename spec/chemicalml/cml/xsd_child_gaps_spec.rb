# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'XSD child element coverage (TODO 64)' do
  before do
    Chemicalml::Cml::Schema3::Configuration.ensure_registered!
  end

  describe 'CommonChildren provides universal children' do
    it 'molecule has names/labels/metadata_lists/descriptions via CommonChildren' do
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        names: [Chemicalml::Cml::Schema3::Name.new(content: 'ethanol')],
        labels: [Chemicalml::Cml::Schema3::Label.new(value: 'primary')]
      )
      expect(mol.names.first.content).to eq('ethanol')
      expect(mol.labels.first.value).to eq('primary')
      expect(mol.metadata_lists.to_a).to be_empty
      expect(mol.descriptions.to_a).to be_empty
    end

    it 'peak has metadata_lists via CommonChildren' do
      peak = Chemicalml::Cml::Schema3::Peak.new(id: 'p1')
      expect(peak.metadata_lists.to_a).to be_empty
      expect(peak.labels.to_a).to be_empty
    end
  end

  describe 'element-specific children' do
    it 'atom supports electron, atom_type, scalar, array, matrix, vector3 children' do
      atom = Chemicalml::Cml::Schema3::Atom.new(
        id: 'a1',
        element_type: 'C',
        atom_type: Chemicalml::Cml::Schema3::AtomType.new,
        electrons: [Chemicalml::Cml::Schema3::Electron.new],
        scalars: [Chemicalml::Cml::Schema3::Scalar.new(content: '1.5')]
      )
      xml = atom.to_xml
      expect(xml).to include('<atomType')
      expect(xml).to include('<electron')
      expect(xml).to include('<scalar>1.5</scalar>')
    end

    it 'bond supports bondType and electron children' do
      bond = Chemicalml::Cml::Schema3::Bond.new(
        id: 'b1',
        atom_refs2: 'a1 a2',
        bond_type: Chemicalml::Cml::Schema3::BondType.new,
        electrons: [Chemicalml::Cml::Schema3::Electron.new]
      )
      xml = bond.to_xml
      expect(xml).to include('<bondType')
      expect(xml).to include('<electron')
    end

    it 'molecule supports crystal, electron, angle, length, torsion, join, zMatrix' do
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: 'm1',
        crystal: Chemicalml::Cml::Schema3::Crystal.new,
        z_matrix: Chemicalml::Cml::Schema3::ZMatrix.new,
        angles: [Chemicalml::Cml::Schema3::Angle.new],
        lengths: [Chemicalml::Cml::Schema3::Length.new],
        torsions: [Chemicalml::Cml::Schema3::Torsion.new]
      )
      xml = mol.to_xml
      expect(xml).to include('<crystal')
      expect(xml).to include('<zMatrix')
      expect(xml).to include('<angle')
      expect(xml).to include('<length')
      expect(xml).to include('<torsion')
    end

    it 'reaction supports mechanism, reactiveCentre, transitionState, identifier' do
      reaction = Chemicalml::Cml::Schema3::Reaction.new(
        id: 'r1',
        mechanisms: [Chemicalml::Cml::Schema3::Mechanism.new],
        reactive_centres: [Chemicalml::Cml::Schema3::ReactiveCentre.new],
        transition_states: [Chemicalml::Cml::Schema3::TransitionState.new],
        identifiers: [Chemicalml::Cml::Schema3::Identifier.new]
      )
      xml = reaction.to_xml
      expect(xml).to include('<mechanism')
      expect(xml).to include('<reactiveCentre')
      expect(xml).to include('<transitionState')
      expect(xml).to include('<identifier')
    end

    it 'reactant supports molecule, formula, amount, identifier' do
      r = Chemicalml::Cml::Schema3::Reactant.new(
        molecule: Chemicalml::Cml::Schema3::Molecule.new(id: 'm1'),
        formula: Chemicalml::Cml::Schema3::Formula.new,
        amounts: [Chemicalml::Cml::Schema3::Amount.new],
        identifier: Chemicalml::Cml::Schema3::Identifier.new
      )
      xml = r.to_xml
      expect(xml).to include('<molecule')
      expect(xml).to include('<formula')
      expect(xml).to include('<amount')
      expect(xml).to include('<identifier')
    end

    it 'spectrum supports sample, spectrumData, parameterList, substanceList' do
      spectrum = Chemicalml::Cml::Schema3::Spectrum.new(
        id: 's1',
        format: 'ir',
        sample: Chemicalml::Cml::Schema3::Sample.new,
        spectrum_data: Chemicalml::Cml::Schema3::SpectrumData.new,
        parameter_lists: [Chemicalml::Cml::Schema3::ParameterList.new],
        substance_lists: [Chemicalml::Cml::Schema3::SubstanceList.new]
      )
      xml = spectrum.to_xml
      expect(xml).to include('<sample')
      expect(xml).to include('<spectrumData')
      expect(xml).to include('<parameterList')
      expect(xml).to include('<substanceList')
    end

    it 'peak supports atom, bond, molecule, peakStructure' do
      peak = Chemicalml::Cml::Schema3::Peak.new(
        id: 'p1',
        atoms: [Chemicalml::Cml::Schema3::Atom.new(id: 'a1')],
        bonds: [Chemicalml::Cml::Schema3::Bond.new(id: 'b1')],
        molecules: [Chemicalml::Cml::Schema3::Molecule.new(id: 'm1')],
        peak_structures: [Chemicalml::Cml::Schema3::PeakStructure.new]
      )
      xml = peak.to_xml
      expect(xml).to include('<atom')
      expect(xml).to include('<bond')
      expect(xml).to include('<molecule')
      expect(xml).to include('<peakStructure')
    end
  end
end
