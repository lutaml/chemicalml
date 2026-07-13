<!-- Source: http://www.xml-cml.org/dictionary/compchem/ -->
<!-- Authors: Peter Murray-Rust, Weerapong Phadungsukanan, Jens Thomas -->
<!-- License: CC-BY-3.0 (http://creativecommons.org/licenses/by/3.0/) -->

# CompChem Dictionary

Toplevel dictionary for computational chemistry.

Concepts in this dictionary are general throughout computational
chemistry and are used extensively in the CompChem convention to
describe the structure of computational chemistry.

Author: Weerapong Phadungsukanan.

## Entries

### calculation

A calculation module for a computational job.

A calculation module represents the concept of the model calculation,
optimisation or iteration processes for a computational job. Almost any
computational procedure is a calculation, and calculations can be nested
to any level. As an example, an SCF calculation consists of an initial
guess calculation, and a number of iterative calculations, the output of
the final iteration constituting the results. An SCF geometry optimisation
process consists of multiple calculation steps, each of which consists of
an SCF calculation, followed by a gradient calculation.

A calculation must contain an initialization module, which defines the
inputs to the calculation (and therefore the calculation), and a
finalization module, which holds all outputs. The calculation module may
contain many other modules describing the process of the calculation, but
that may not necessarily be desirable as results.

### environment

Module holding concepts relating to the environment that the job used or
required.

The computing environment concept refers to a hardware platform, software
application, the operating system and any hardware and software
configurations used in order to run the job or computational task. The
environment includes metadata such as machine id, username, starting and
finishing date time, tools, compilers, IP, etc.

This information is not related to input and output of the model but is
supplementary to the software application to run properly and may vary
from machine to machine. Therefore, the computing environment is OPTIONAL
in the CompChem convention.

### finalization

A finalization module for a computational job or calculation.

Represents the concept of the model results for a computational job or
calculation. This will usually be the output properties of the final
calculation carried out by the job. The finalization module should contain
a propertyList with scalar, array and matrix quantities, but may also
contain more complex objects such as molecules or orbitals as cml:lists.

### initialization

An initialization module for a computational job or calculation.

Represents the concept of the model parameters and inputs. The module
defines the calculation, so that it should be possible to reproduce the
calculation based solely on the data in this module. The initialization
module should contain a parameterList with scalar, array and matrix
quantities, and the starting molecule, but may also contain more complex
objects as cml:lists, such as the basis set.

### job

A job or computational task.

The job concept represents a computational job performed by quantum
chemistry software, e.g. geometry optimisation job, frequency analysis
job. The job can be considered as the unit of work that would be
submitted to a computational resource. In almost all respects a job is
identical to a calculation, in that it has an initialization module,
which holds the inputs for the calculation(s) to be run, and a
finalization module, which holds all outputs. In addition, a job may
contain an environment module.

### jobList

A list of computational jobs.

A quantum chemistry calculation is often comprised of a series of
subtasks, e.g. coarse optimisation -> fine optimisation -> NMR Spectrum
Analysis. The joblist concept captures these series of successive
subtasks and links the information from one subtask to the next.

### compileDate

The date that the executable was compiled.

### runDate

The date that the job commenced.

### executable

The path to the executable program.

### hostName

The name of the host that the program was run on.

### inputFile

A cml module for a single literal representation of an input file.

### inputFileList

A cml module containing a list of input files.

### inputFileName

A representation of the name of a single input file.

### numProc

The number of processors used to run the job.

### program

The program being run. Known values:

- `nwchem` — The Northwest Computational Chemistry Package (NWChem)
- `gaussian` — The Gaussian electronic structure code

### programVersion

Specifies the version of the code that was used to run the calculation.

### method

The type of computational method. Example values: `SCF`, `DFT`, `MP2`.

### task

The task being carried out. Example values: `energy`, `frequency`,
`geometry_optimization`, `gradient`, `initial_guess`, `iteration`, `step`.

### id

A CML id. Usable throughout cml documents. Need not be unique.

### index

An index. An integer used as an index.

### iterationIndex

The serial number of an iteration.

### parameter

(TODO)

### property

(TODO)

### title

An arbitrary title.

### UUID

A Universally Unique IDentifier as per RFC 4122.

### cpuTime

Elapsed CPU time.

### wallTime

Elapsed wallclock time.

### charge

The total charge on the system in elementary charge units.

### atomType

the type of the element (the atomic symbol).

### numAtoms

The number of atoms. Normally the count of atoms in a molecule.

### numElectrons

The total number of electrons in a system.

### numAlphaElectrons

The total number of alpha spin electrons.

### numBetaElectrons

The total number of beta spin electrons.

### numClosedShells

The number of closed shells.

### numOpenShells

The number of open shells.

### pointGroup

The molecular point group in Schoenflies notation.

### spinMultiplicity

The spin multiplicity = (alpha electrons) - (beta electrons) + 1.

### wavefunctionType

The type of wavefunction. Acceptable values: `closed`, `open`,
`restricted open`.

### basisSet

A cml list container for all information related to the basis set.

The basis set is the set of functions from which the electron orbitals
are constructed.

### basisSetLabel

The name of the basis set. Should be one of the names used within the
EMSL Basis Set Exchange.

### basisSetType

The type of the basis set. Valid values: `orbital`, `dftorb`, `dftxfit`,
`dftcfit`, `periodic`, `ecporb`, `spinorb`, `polarization`, `diffuse`,
`tight`, `rydberg`.

### basisSetHarmonicType

The type of the angular functions. Valid values: `cartesian`, `spherical`.

### basisSetContractionType

How the gaussian functions are contracted. Valid values: `segmented`,
`general`, `uncontracted`.

### basisSetDescription

A description of the basis set.

### basisSetContractions

The cml:list container for the contractions relating to a particular
atom type.

### basisSetShell

The label for the contraction shell. Valid values: `S`, `P`, `SP`, `D`,
`F`, `G`, `H`, `I`, `K`, `L`, `M`.

### basisSetContraction

The cml:list container for an individual contraction.

### basisSetExponent

A cml:array holding the list of exponents for an individual contraction.

### basisSetRExponent

A cml:array holding the list of R exponents for an individual ECP
contraction.

### basisSetCoefficient

A cml:array holding the list of coefficients for an individual contraction.

### numElectronsReplaced

The number of electrons replaced by an Effective Core Potential (ECP).

### orbital

A cml list container for all information related to an Orbital.

### dftFunctional

A cml list container for all information related to a DFT Functional.

### dftFunctionalLabel

The name of the DFT functional used, if a standard functional was used.

### coulombEnergy

The Coulomb component of the electronic energy in a Density Functional
Calculation.

### correlationEnergy

The Correlation Energy.

### e1Energy

The one-electron energy. The one-electron kinetic energy component of
the Hamiltonian operator.

### e2Energy

The two-electron energy.

### nuclearRepulsionEnergy

The potential energy arising from Coulombic nuclei-nuclei repulsions.

### scfEnergy

The Hartree-Fock Self-Consistent Field component of the energy.

### totalEnergy

The total energy for a system of electrons and nuclei. Formed from the
sum of the nuclear, one- and two-electron energies.

### xcEnergy

The Exchange correlation energy.
