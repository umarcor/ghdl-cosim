.. program:: ghdl
.. _COSIM:VHPIDIRECT:Examples:cinterface:

C interface
###########

.. IMPORTANT::
  This header is a compilation of some functions that are deemed helpful when cosimulating GHDL with C.
	It is by no means a requirement of such cosimulation. Rather it aims to provide a framework to
	kickstart any complex cosimulations with C.

.. _COSIM:VHPIDIRECT:Examples:cinterface:intro:

:cosimtree:`C Interface Introduction <vhpidirect/quickstart/cinterface/intro>`
******************************************************************************

The primary complex task that the ``ghdl.h`` file intends on making easy is the sharing of unbounded arrays
between VHDL and C. The data type that is defined for a VHDL unbounded array is ``ghdl_NaturalDimArr_t``.
Unbounded arrays (of any primitive type) are passed to C from VHDL as a pointer to this type.

Provided is the ``ghdlToArray(ghdl_NaturalDimArr_t* ptr, void** vec, int* len, int num)`` function, which
enables handling a VHDL unbounded array within C.

The converse operations (taking a C array to an unbounded array in VHDL) are handled by the provided
``ghdlFromPointer`` and ``ghdlFromArray`` functions.

getFlatArrayIndex
testCinterface
freePointers
getLogicVec
getULogicMat

:cosimtree:`demo <vhpidirect/cinterface/demo>`
**********************************************

This example is a reference and a test suite for the helper C headers provided in :cosimtree:`vhpidirect`. These headers are a reference of GHDL's ABI, and can be imported to easily convert non-trivial data types between C and VHDL. However, the ABI is not settled, so it might change without prior notice.
