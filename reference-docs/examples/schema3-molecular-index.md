<!-- Source: http://www.xml-cml.org/examples/schema3/molecular/ -->
<!-- License: CC-BY-3.0 (http://creativecommons.org/licenses/by/3.0/) -->

# Schema 3 Molecular Examples

The following examples are all valid under the molecular convention. The
files have been used to unit-test the validation service and should
therefore give a fairly full example of each element.

## Example index

- atom with non cml content
- atoms in formula do not need id
- bond order other should have dictRef
- bondStereo atomRefs2 must match parent bonds 1, 2
- bondStereo atomRefs4 must contain parent bonds 1–8
- bondStereo other should have dictRef
- formula must have atomArray or concise or inline 1–7
- minimal molecule 1–4
- minimal molecule with foreign sibling
- minimal molecule with non cml content 1–3
- molecular convention molecule with non molecular sibling 1, 2
- molecular convention not as root element
- molecular molecule within non molecular
- must be at least one molecule in molecular convention 1, 2
- property must have dictRef and title
- repeated atom ids in different molecules
- scalar must have units and datatype and be child of property
