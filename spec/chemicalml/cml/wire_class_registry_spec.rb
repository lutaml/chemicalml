# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Cml::WireClassRegistry do
  describe ".for" do
    it "returns Schema3 class for schema3 + role" do
      result = described_class.for(:schema3, Chemicalml::Cml::Role::Molecule)
      expect(result).to be(Chemicalml::Cml::Schema3::Molecule)
    end

    it "returns Schema24 class for schema24 + role" do
      result = described_class.for(:schema24, Chemicalml::Cml::Role::Molecule)
      expect(result).to be(Chemicalml::Cml::Schema24::Molecule)
    end

    it "returns different classes for the same role across schemas" do
      s3 = described_class.for(:schema3, Chemicalml::Cml::Role::Atom)
      s24 = described_class.for(:schema24, Chemicalml::Cml::Role::Atom)
      expect(s3).not_to be(s24)
    end

    it "raises ArgumentError for unknown schema" do
      expect { described_class.for(:bogus, Chemicalml::Cml::Role::Atom) }
        .to raise_error(ArgumentError, /unknown schema/)
    end

    it "raises ArgumentError when schema lacks the element (Schema24 has no AnyCml)" do
      expect { described_class.for(:schema24, Chemicalml::Cml::Role::AnyCml) }
        .to raise_error(ArgumentError, /does not define AnyCml/)
    end

    it "resolves Schema24 Module (module is in both XSDs)" do
      expect(described_class.for(:schema24, Chemicalml::Cml::Role::Module))
        .to be(Chemicalml::Cml::Schema24::Module)
    end

    it "accepts string role names too" do
      expect(described_class.for(:schema3, "Atom"))
        .to be(Chemicalml::Cml::Schema3::Atom)
    end
  end
end
