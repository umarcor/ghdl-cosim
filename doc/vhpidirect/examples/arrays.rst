.. program:: ghdl
.. _COSIM:VHPIDIRECT:Examples:arrays:

Arrays
######

.. _COSIM:VHPIDIRECT:Examples:arrays:logicvectors:

:cosimtree:`logicvector <vhpidirect/arrays/logicvector>`
**************************************************************

Commonly signals in VHDL are of a logic type or a vector thereof (``std_logic`` and ``std_logic_vector``), coming from IEEE's ``std_logic_1164`` package.
These types can hold values other than high and low (``1`` and ``0``) and are enumerated as:

0. 'U' 
1. 'X' 
2. '0' 
3. '1' 
4. 'Z' 
5. 'W' 
6. 'L' 
7. 'H' 
8. '-' 

As mentioned in :ref:`Restrictions_on_foreign_declarations`:
	- Because the number of enumeration values is less than 256, logic values are transported in 8 bit words (a ``char`` type in C).

		- In this example two declarations make handling logic values in C a bit easier:

			- Providing logic values in C as their enumeration numbers is simplified with the use of a matching enumeration, ``HDL_LOGIC_STATES``. 
			- Printing out a logic value's associated character is also simplified with the ``const char HDL_LOGIC_CHAR[]`` declaration.
			
	- Logic vectors, of a bounded size, can be easily created in C as a ``char[]`` and passed to VHDL to be read as an ``access`` type in VHDL, in this case an access of a subtype of std_logic_vector.


This example builds on the integer vector example (:ref:`COSIM:VHPIDIRECT:Examples:arrays:intvector`), by instead passing an array of logic values. Foreign subprograms are declared that enable receiving the size of two different logic vectors as well as the vectors themselves from C. There is only one subprogram to get the size of both C arrays, and it takes in an integer to determine which array's size gets returned. 

.. HINT::
  The ``getLogicVecSize`` in VHDL is declared as receiving a ``boolean`` argument. In C the function is declared to receive an ``char`` argument. The VHDL booleans ``false`` and ``true`` are enumerations, and have integer values, ``0`` and ``1`` respectively. As with the logic values, the boolean enumerations use fewer than 8 bits, so the single byte in C's ``char`` variable receives the VHDL enumeration correctly.

For illustrative purposes, the two vectors are populated with logic values in different ways:

- LogicVectorA's indices are manually filled with enumeration values from HDL_LOGIC_STATES.

  - .. code-block:: C

        logic_vec_A[0] = HDL_U;

- LogicVectorB's indices are filled with an integer value.

  - .. code-block:: C

        for(int i = 0; i < SIZE_LOGIC_VEC_B; i++){
          logic_vec_B[i] = 8-i;
        }

.. ATTENTION::
  The integer values that are given to ``char`` variables in C which are intended to be read as VHDL logic values, must be limited to [0, 8]. This ensures that they represent one of the 9 enumerated logic values.