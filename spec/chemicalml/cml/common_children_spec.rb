# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chemicalml::Cml::Base::CommonChildren do
  before do
    Chemicalml::Cml::Schema3::Configuration.ensure_registered!
  end

  let(:host_class) do
    Class.new(Lutaml::Model::Serializable) do
      include Chemicalml::Cml::Base::CommonChildren
      extend Chemicalml::Cml::Schema3::Context

      attribute :id, :string

      xml do
        namespace Chemicalml::Cml::Namespace
        root 'host'
        map_attribute 'id', to: :id
      end
    end
  end

  it 'declares metadata_lists as a collection' do
    inst = host_class.new(metadata_lists: [
                            Chemicalml::Cml::Schema3::MetadataList.new,
                            Chemicalml::Cml::Schema3::MetadataList.new
                          ])
    expect(inst.metadata_lists.size).to eq(2)
  end

  it 'declares labels as a collection' do
    inst = host_class.new(labels: [
                            Chemicalml::Cml::Schema3::Label.new(value: 'primary')
                          ])
    expect(inst.labels.size).to eq(1)
  end

  it 'declares names as a collection' do
    inst = host_class.new(names: [
                            Chemicalml::Cml::Schema3::Name.new(content: 'ethanol')
                          ])
    expect(inst.names.size).to eq(1)
  end

  it 'declares descriptions as a collection' do
    inst = host_class.new(descriptions: [
                            Chemicalml::Cml::Schema3::Description.new
                          ])
    expect(inst.descriptions.size).to eq(1)
  end

  it 'round-trips the children through XML' do
    inst = host_class.new(
      id: 'h1',
      names: [Chemicalml::Cml::Schema3::Name.new(content: 'a-name')]
    )
    xml = inst.to_xml
    expect(xml).to include('<name>a-name</name>')
  end
end
