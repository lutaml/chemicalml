# frozen_string_literal: true

require 'set'

module Chemicalml
  module Cml
    # Canonical Ruby source of truth for every XSD simpleType that
    # restricts to an enumeration. Generated from
    # `reference-docs/schemas/schema3/schema.xsd`. Constants are
    # frozen Sets — adding a new value means changing the XSD, then
    # regenerating this file.
    #
    # Naming: XSD `fooType` → Ruby `FOO_VALUES`. The `Type` suffix is
    # stripped before uppercasing. Constants ending in `_VALUES` are
    # Sets of allowed string values for the corresponding attribute.
    module Enums
      ACTIONORDER_VALUES = Set.new(%w[sequential parallel]).freeze
      # All 120 element type codes from XSD elementTypeType, including
      # the special "Du" (dummy) and "R" (undefined/group placeholder).
      # Use this to validate atom.elementType values.
      ELEMENT_TYPE_VALUES = Set.new(%w[Ac Al Ag Am Ar As At Au B Ba Bh Bi Be Bk Br C Ca Cd Ce Cf Cl Cm Co Cr Cs Cu Db Dy Er Es Eu F Fe Fm Fr Ga Gd Ge H He Hf Hg Ho Hs I In Ir K Kr La Li Lr Lu Md Mg Mn Mo Mt N Na Nb Nd Ne Ni No Np O Os P Pa Pb Pd Pm Po Pr Pt Pu Ra Rb Re Rf Rh Rn Ru S Sb Sc Se Sg Si Sm Sn Sr Ta Tb Tc Te Th Ti Tl Tm U Uun Uuu Uub Uut Uuq Uup Uuh Uus Uuo V W Xe Y Yb Zn Zr Du R]).freeze
      ANGLEUNITS_VALUES = Set.new(%w[degrees radians]).freeze
      CELLPARAMETER_VALUES = Set.new(%w[length angle]).freeze
      CHIRALITY_VALUES = Set.new(%w[enantiomer racemate unknown other]).freeze
      DIMENSION_VALUES = Set.new(%w[mass length time current amount luminosity temperature dimensionless angle]).freeze
      EIGENORIENTATION_VALUES = Set.new(%w[columnVectors rowVectors other]).freeze
      ERRORBASIS_VALUES = Set.new(%w[observedRange observedStandardDeviation observedStandardError estimatedStandardDeviation estimatedStandardError other]).freeze
      FORMAT_VALUES = Set.new(%w[1D 2Dsymm 2Dasymm other]).freeze
      FT_VALUES = Set.new(%w[raw transformed none other]).freeze
      INHERIT_VALUES = Set.new(%w[merge replace delete]).freeze
      LATTICE_VALUES = Set.new(%w[primitive full aCentred other]).freeze
      LINKTYPE_VALUES = Set.new(%w[extended locator arc]).freeze
      LM_VALUES = Set.new(%w[s p px py pz d dxy dyz dxz dx2y2 dz2 f g]).freeze
      MATRIX_VALUES = Set.new(%w[rectangular square squareSymmetric squareSymmetricLT squareSymmetricUT squareAntisymmetric squareAntisymmetricLT squareAntisymmetricUT diagonal upperTriangular upperTriangularUT lowerTriangular lowerTriangularLT unit unitary rowEigenvectors rotation22 rotationTranslation32 homogeneous33 rotation33 rotationTranslation43 homogeneous44 other]).freeze
      MEASUREMENT_VALUES = Set.new(%w[transmittance absorbance other]).freeze
      ORDER_VALUES = Set.new(%w[S 1 D 2 T 3 A unknown other]).freeze
      PEAKMULTIPLICITY_VALUES = Set.new(%w[singlet doublet triplet quartet quintet sextuplet multiplet other]).freeze
      PEAKSHAPE_VALUES = Set.new(%w[sharp broad shoulder other]).freeze
      PEAKSTRUCTURETYPE_VALUES = Set.new(%w[coupling splitting other]).freeze
      REACTIONFORMAT_VALUES = Set.new(%w[reactantProduct cmlSnap other]).freeze
      REACTIONROLE_VALUES = Set.new(%w[complete overall rateDeterminingStep step steps other]).freeze
      REACTIONSTEPLISTTYPE_VALUES = Set.new(%w[unknown consecutive choice simultaneous other]).freeze
      REACTIONTYPE_VALUES = Set.new(%w[chainReaction initiation termination reversible other]).freeze
      SCHEME_VALUES = Set.new(%w[unknown sequence choice and other]).freeze
      SHAPE_VALUES = Set.new(%w[rectangular triangularDecreasing. triangularIncreasing. irregular other]).freeze
      SPACE_VALUES = Set.new(%w[real k-space Fourier reciprocal other]).freeze
      SPECTRUMTYPE_VALUES = Set.new(%w[infrared massSpectrum NMR UV/VIS other]).freeze
      STATE_VALUES = Set.new(%w[aqueous gas glass liquid nematic smectic solid solidSolution solution other]).freeze
      STEREO_VALUES = Set.new(%w[C T W H undefined other]).freeze
      SUBSTANCELISTTYPE_VALUES = Set.new(%w[solution mixture other]).freeze
      TABLETYPE_VALUES = Set.new(%w[rowBased arrayBased contentBased other]).freeze
    end
  end
end
