.. program:: ghdl
.. _COSIM:VHPIDIRECT:Examples:arrays:

Arrays
#######

:cosimtree:`A Bounded Array Sized in VHDL <vhpidirect/arrays/intvectorgeneric>`
*******************************************************************************

Interface generics are the generics of the toplevel VHDL entity, and their values can be set via GHDL's runtime option :option:`-g` (see :ref:`simulation_options`). In this example an interface generic is used as an argument for the call of the VHPIDIRECT subprogram ``c_intArr_ptr(arraySize: integer)``. This subprogram is linked to the foreign C function ``getIntArr_ptr(int arraySize)`` which uses the argument to allocate an ``int*`` enough space to contain ``arraySize`` integers, populating each index thereafter. The subprogram returns the array's pointer and each index is printed out in VHDL.

.. NOTE::
	The C function is actually extended to handle a second call. If the ``int*`` has been used before its memory is freed, and if the new arraySize is greater than 0, the pointer is allocated enough memory again. In this way, a VHDL subprogram call of ``c_intArr_ptr(0);`` frees the previously allocated memory.