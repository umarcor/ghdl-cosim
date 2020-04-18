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

:cosimtree:`A Bounded Array Sized in VHDL <vhpidirect/arrays/intvectorgeneric>`
*******************************************************************************

Interface generics are the generics of the toplevel VHDL entity, and their values can be set via GHDL's runtime option :option:`-g` (see :ref:`simulation_options`). In this example an interface generic is used as an argument for the call of the VHPIDIRECT subprogram ``c_intArr_ptr(arraySize: integer)``. This subprogram is linked to the foreign C function ``getIntArr_ptr(int arraySize)`` which uses the argument to allocate an ``int*`` enough space to contain ``arraySize`` integers, populating each index thereafter. The subprogram returns the array's pointer and each index is printed out in VHDL.

.. NOTE::
	The C function is actually extended to handle a second call. If the ``int*`` has been used before its memory is freed, and if the new arraySize is greater than 0, the pointer is allocated enough memory again. In this way, a VHDL subprogram call of ``c_intArr_ptr(0);`` frees the previously allocated memory.
