# 49 — Add more chemistry Model classes

## Why

Several chemically-meaningful CML elements still lack canonical Model
classes, forcing callers to use wire classes directly and breaking the
"all adapters speak canonical" invariant.

## New Model classes

- `Model::Torsion` — `<torsion>` (4-atom dihedral)
- `Model::Angle` — `<angle>` (3-atom angle)
- `Model::Length` — `<length>` (2-atom distance)
- `Model::Action` / `Model::ActionList` — `<action>` / `<actionList>`
- `Model::Map` — `<map>` (atom mapping across reaction)
- `Model::Fragment` / `Model::FragmentList` — substructure references
- `Model::ReactionStepList` — list of `<reactionStep>`
- `Model::ReactiveCentre` — `<reactiveCentre>`
- `Model::TransitionState` — `<transitionState>`
- `Model::PeakGroup` — `<peakGroup>`
- `Model::SpectrumList` — `<spectrumList>`
- `Model::SpectrumData` — `<spectrumData>`
- `Model::Region` — `<region>`

## Wire translator mappings

For each new Model class, add `*_to_canonical` / `*_from_canonical`
helpers. Most are simple (id/title/dictRef/convention).

## Acceptance

- Each new Model class has instantiation + value_attributes specs.
- Translator mappings round-trip.
- Full suite green.
