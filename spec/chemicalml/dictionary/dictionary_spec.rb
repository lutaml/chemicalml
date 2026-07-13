# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Dictionary::Entry do
  it "requires a valid id (RFC-style)" do
    expect { described_class.new(id: "1bad", term: "x", definition: "y") }
      .to raise_error(ArgumentError, /invalid entry id/)
    expect { described_class.new(id: "good-id_1", term: "x", definition: "y") }
      .not_to raise_error
  end

  it "exposes every declared field" do
    e = described_class.new(
      id: "foo", term: "Foo", definition: "A foo.",
      description: "more", data_type: "xsd:string",
      unit_type: "unitType:none", units: "unit:none"
    )
    expect(e.id).to eq("foo")
    expect(e.term).to eq("Foo")
    expect(e.data_type).to eq("xsd:string")
  end

  it "is frozen" do
    expect(described_class.new(id: "foo", term: "Foo", definition: "x")).to be_frozen
  end

  it "compares by id + content" do
    a = described_class.new(id: "foo", term: "Foo", definition: "x")
    b = described_class.new(id: "foo", term: "Foo", definition: "x")
    c = described_class.new(id: "foo", term: "Foo", definition: "y")
    expect(a).to eq(b)
    expect(a).not_to eq(c)
  end
end

RSpec.describe Chemicalml::Dictionary::Enum do
  it "defaults to an open set" do
    e = described_class.new
    expect(e).to be_open
    expect(e.allows?("anything")).to be(true)
  end

  it "closed set rejects values outside the list" do
    e = described_class.new(kind: :closed, values: %w[a b c])
    expect(e).to be_closed
    expect(e.allows?("a")).to be(true)
    expect(e.allows?("z")).to be(false)
  end

  it "rejects unknown kinds" do
    expect { described_class.new(kind: :bogus) }
      .to raise_error(ArgumentError, /unknown enum kind/)
  end
end

RSpec.describe Chemicalml::Dictionary::Link do
  it "exposes rel + href + title" do
    l = described_class.new(rel: "seeAlso", href: "http://x.org", title: "x")
    expect(l.rel).to eq("seeAlso")
    expect(l.href).to eq("http://x.org")
    expect(l.title).to eq("x")
  end

  it "omits nil title from its hash form" do
    h = described_class.new(rel: "seeAlso", href: "http://x.org").to_h
    expect(h).not_to have_key(:title)
  end
end

RSpec.describe Chemicalml::Dictionary::Model do
  let(:entry) do
    Chemicalml::Dictionary::Entry.new(
      id: "foo", term: "Foo",
      definition: "A foo.",
      data_type: "xsd:string",
      unit_type: "unitType:none",
      units: "unit:none"
    )
  end

  let(:dict) do
    described_class.new(
      namespace: "http://example.org/dict/",
      prefix: "ex",
      title: "example",
      entries: [entry]
    )
  end

  it "looks up an entry by QName" do
    expect(dict.lookup("ex:foo")).to eq(entry)
  end

  it "returns nil on miss" do
    expect(dict.lookup("ex:nope")).to be_nil
  end

  it "lookup! raises on miss" do
    expect { dict.lookup!("ex:nope") }.to raise_error(KeyError)
  end

  it "exposes entry_ids" do
    expect(dict.entry_ids).to eq(%w[foo])
  end
end

RSpec.describe Chemicalml::Dictionary::Registry do
  after { described_class.reset! }

  it "lists built-in dictionaries" do
    expect(described_class.builtin_names)
      .to include(:compchem, :unit_si, :unit_non_si, :unit_type)
  end

  it "does not include the underscore-prefixed index file" do
    expect(described_class.builtin_names).not_to include(:_index)
  end

  it "loads compchem with the documented shape" do
    d = described_class.load_builtin(:compchem)
    expect(d.namespace).to eq("http://www.xml-cml.org/dictionary/compchem/")
    expect(d.prefix).to eq("compchem")
    expect(d.entries.length).to be > 30
  end

  it "resolves a QName through the registry" do
    e = described_class.lookup("compchem:totalEnergy")
    expect(e).not_to be_nil
    expect(e.id).to eq("totalEnergy")
    expect(e.units).to eq("unit:hartree")
  end

  it "caches loaded dictionaries" do
    a = described_class.load_builtin(:compchem)
    b = described_class.load_builtin(:compchem)
    expect(a).to be(b)
  end

  it "raises KeyError for unknown built-in name" do
    expect { described_class.load_builtin(:nope) }
      .to raise_error(KeyError, /no built-in dictionary/)
  end
end

RSpec.describe Chemicalml::Dictionary::Loader do
  it "builds a Model from a hash" do
    m = described_class.from_hash(
      "namespace" => "http://example.org/",
      "prefix" => "ex",
      "title" => "example",
      "entries" => [
        { "id" => "foo", "term" => "Foo", "definition" => "A foo.",
          "enum" => { "kind" => "closed", "values" => %w[a b] } }
      ]
    )
    expect(m.namespace).to eq("http://example.org/")
    expect(m.entries.first.enum).to be_closed
    expect(m.entries.first.enum.allows?("a")).to be(true)
    expect(m.entries.first.enum.allows?("z")).to be(false)
  end
end

RSpec.describe Chemicalml do
  it "loads dictionaries through the top-level shortcut" do
    d = Chemicalml::Dictionary.load(:compchem)
    expect(d.prefix).to eq("compchem")
  end
end
