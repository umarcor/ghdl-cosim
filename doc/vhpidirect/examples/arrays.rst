.. program:: ghdl
.. _COSIM:VHPIDIRECT:Examples:arrays:

Arrays
#######

:cosimtree:`A Bounded Array Sized in C <vhpidirect/arrays/intvector>`
*********************************************************************

Integer arrays fully defined in C can be passed to VHDL by first passing their size, so that an appropriate array 
type can be created to hold the array's pointer. After that, a VHDL subprogram can be defined to return the array access.

:cosimtree:`A Bounded Array Sized in C: First defined in main() <vhpidirect/arrays/intvector/maindefined>`
----------------------------------------------------------------------------------------------------------

If the integer array must be created or filled by some more advanced process before VHDL can request the array's pointer, it is
possible to execute the GHDL simulation within a custom ``int main()`` entrypoint (see :ref:`COSIM:VHPIDIRECT:Examples:wrapping:basic`).
In this example the custom entrypoint prompts the user for the size of the array and then handles the variables appropriately before
going on to execute the GHDL simulation.