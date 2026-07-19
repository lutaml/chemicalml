# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Schema24 child element gap closure (TODO 72)' do
  before do
    Chemicalml::Cml::Schema3::Configuration.ensure_registered!
    Chemicalml::Cml::Schema24::Configuration.ensure_registered!
  end

  it 'reactiveCentre supports atomSet, bondSet, atomTypeList, bondTypeList' do
    rc = Chemicalml::Cml::Schema3::ReactiveCentre.new(
      id: 'rc1',
      atom_sets: [Chemicalml::Cml::Schema3::AtomSet.new],
      bond_sets: [Chemicalml::Cml::Schema3::BondSet.new],
      atom_type_lists: [Chemicalml::Cml::Schema3::AtomTypeList.new],
      bond_type_lists: [Chemicalml::Cml::Schema3::BondTypeList.new]
    )
    xml = rc.to_xml
    expect(xml).to include('<atomSet')
    expect(xml).to include('<bondSet')
    expect(xml).to include('<atomTypeList')
    expect(xml).to include('<bondTypeList')
  end

  it 'sample supports molecule, substance, substanceList' do
    sample = Chemicalml::Cml::Schema3::Sample.new(
      id: 's1',
      molecule: Chemicalml::Cml::Schema3::Molecule.new(id: 'm1'),
      substance: Chemicalml::Cml::Schema3::Substance.new,
      substance_lists: [Chemicalml::Cml::Schema3::SubstanceList.new]
    )
    xml = sample.to_xml
    expect(xml).to include('<molecule')
    expect(xml).to include('<substance')
    expect(xml).to include('<substanceList')
  end

  it 'spectator supports molecule and object children' do
    sp = Chemicalml::Cml::Schema3::Spectator.new(
      id: 'sp1',
      molecule: Chemicalml::Cml::Schema3::Molecule.new(id: 'm1'),
      objects: [Chemicalml::Cml::Schema3::Object.new]
    )
    xml = sp.to_xml
    expect(xml).to include('<molecule')
    expect(xml).to include('<object')
  end

  it 'transitionState supports molecule and propertyList' do
    ts = Chemicalml::Cml::Schema3::TransitionState.new(
      id: 'ts1',
      molecule: Chemicalml::Cml::Schema3::Molecule.new(id: 'm1'),
      property_lists: [Chemicalml::Cml::Schema3::PropertyList.new]
    )
    xml = ts.to_xml
    expect(xml).to include('<molecule')
    expect(xml).to include('<propertyList')
  end

  it 'substance supports amount and property' do
    sub = Chemicalml::Cml::Schema3::Substance.new(
      id: 'sub1',
      amounts: [Chemicalml::Cml::Schema3::Amount.new],
      properties: [Chemicalml::Cml::Schema3::Property.new]
    )
    xml = sub.to_xml
    expect(xml).to include('<amount')
    expect(xml).to include('<property')
  end

  it 'lattice supports matrix, scalar, symmetry' do
    l = Chemicalml::Cml::Schema3::Lattice.new(
      id: 'l1',
      matrices: [Chemicalml::Cml::Schema3::Matrix.new],
      scalars: [Chemicalml::Cml::Schema3::Scalar.new(content: '1.0')],
      symmetries: [Chemicalml::Cml::Schema3::Symmetry.new]
    )
    xml = l.to_xml
    expect(xml).to include('<matrix')
    expect(xml).to include('<scalar')
    expect(xml).to include('<symmetry')
  end

  it 'table supports arrayList and tableRowList' do
    t = Chemicalml::Cml::Schema3::Table.new(
      id: 't1',
      array_lists: [Chemicalml::Cml::Schema3::ArrayList.new],
      table_row_lists: [Chemicalml::Cml::Schema3::TableRowList.new]
    )
    xml = t.to_xml
    expect(xml).to include('<arrayList')
    expect(xml).to include('<tableRowList')
  end

  it 'trow supports tcell children' do
    trow = Chemicalml::Cml::Schema24::Trow.new(
      id: 'r1',
      tcells: [Chemicalml::Cml::Schema24::Tcell.new, Chemicalml::Cml::Schema24::Tcell.new]
    )
    xml = trow.to_xml
    expect(xml.scan('<tcell').size).to eq(2)
  end

  it 'zMatrix supports angle, length, torsion' do
    zm = Chemicalml::Cml::Schema3::ZMatrix.new(
      id: 'zm1',
      angles: [Chemicalml::Cml::Schema3::Angle.new],
      lengths: [Chemicalml::Cml::Schema3::Length.new],
      torsions: [Chemicalml::Cml::Schema3::Torsion.new]
    )
    xml = zm.to_xml
    expect(xml).to include('<angle')
    expect(xml).to include('<length')
    expect(xml).to include('<torsion')
  end

  it 'symmetry supports matrix and transform3' do
    s = Chemicalml::Cml::Schema3::Symmetry.new(
      id: 'sym1',
      matrices: [Chemicalml::Cml::Schema3::Matrix.new],
      transform3s: [Chemicalml::Cml::Schema3::Transform3.new]
    )
    xml = s.to_xml
    expect(xml).to include('<matrix')
    expect(xml).to include('<transform3')
  end

  it 'map supports link children' do
    m = Chemicalml::Cml::Schema3::Map.new(
      id: 'map1',
      links: [Chemicalml::Cml::Schema3::Link.new, Chemicalml::Cml::Schema3::Link.new]
    )
    xml = m.to_xml
    expect(xml.scan('<link').size).to eq(2)
  end

  it 'eigen supports array and matrix' do
    e = Chemicalml::Cml::Schema3::Eigen.new(
      id: 'e1',
      arrays: [Chemicalml::Cml::Schema3::Array.new],
      matrices: [Chemicalml::Cml::Schema3::Matrix.new]
    )
    xml = e.to_xml
    expect(xml).to include('<array')
    expect(xml).to include('<matrix')
  end

  it 'xaxis and yaxis support array children' do
    x = Chemicalml::Cml::Schema3::Xaxis.new(arrays: [Chemicalml::Cml::Schema3::Array.new])
    y = Chemicalml::Cml::Schema3::Yaxis.new(arrays: [Chemicalml::Cml::Schema3::Array.new])
    expect(x.to_xml).to include('<array')
    expect(y.to_xml).to include('<array')
  end

  it 'self-references work for recursive containers' do
    inner = Chemicalml::Cml::Schema3::MoleculeList.new(id: 'inner')
    outer = Chemicalml::Cml::Schema3::MoleculeList.new(
      id: 'outer',
      molecule_lists: [inner]
    )
    xml = outer.to_xml
    expect(xml.scan('<moleculeList').size).to eq(2)
  end
end
