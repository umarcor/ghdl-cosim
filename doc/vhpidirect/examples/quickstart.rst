.. program:: ghdl
.. _COSIM:VHPIDIRECT:Examples:quickstart:

Quick Start
###########

.. _COSIM:VHPIDIRECT:Examples:quickstart:random:

:cosimtree:`random <vhpidirect/quickstart/random>`
**************************************************

By default, GHDL includes the standard C library in the generated simulation models. Hence, resources from ``stdlib`` can be used without any modification to the build procedure.

This example shows how to import and use ``rand`` to generate and print 10 integer numbers. The VHDL code is equivalent to the following C snippet. However, note that this C source is NOT required, because ``stdlib`` is already built in.

.. code-block:: C

    #include <stdlib.h>
    #include <stdio.h>

    int main (void) {
      int i;
      for (i = 0; i < 10; i++)
        printf ("%d\n", rand ());
      return 0;
    }

.. _COSIM:VHPIDIRECT:Examples:quickstart:math:

:cosimtree:`math <vhpidirect/quickstart/math>`
**********************************************

By the same token, it is possible to include functions from system library by just providing the corresponding linker flag.

In this example, function ``sin`` from the ``math`` library is used to compute 10 values. As in the previous example, no additional C sources are required, because the ``math`` library is already compiled and installed in the system.

.. _COSIM:VHPIDIRECT:Examples:quickstart:customc:

:cosimtree:`customc <vhpidirect/quickstart/customc>`
****************************************************

When the required functionality is not available in pre-built libraries, custom C sources and/or objects can be added to the elaboration and/or linking.

This example shows how to bind custom C functions in VHDL as either procedures or functions. Four cases are included: ``custom_procedure``, ``custom_procedure_withargs``, ``custom_function`` and ``custom_function_withargs``. In all cases, the parameters are defined as integers, in order to keep it simple. See :ref:`COSIM:VHPIDIRECT:Declarations` for further details.

Since either C sources or pre-compiled ``.o`` objects can be added, in C/C++ projects of moderate complexity, it might be desirable to merge all the C sources in a single object before elaborating the design.

:cosimtree:`package <vhpidirect/quickstart/package>`
****************************************************

If the auxillary VHPIDIRECT subprograms need to be accessed in more than one entity, it is possible to package the subprograms. This also makes it very easy to reuse the VHPIDIRECT declarations in different projects.

In this example 2 different entities use a C defined ``c_printInt(val: integer)`` subprogram to print two different numbers. Subprogram declaration requirements are detailed under the :ref:`COSIM:VHPIDIRECT:Declarations` section.

.. _COSIM:VHPIDIRECT:Examples:quickstart:logicvectors:

:cosimtree:`logicvectors <vhpidirect/quickstart/logicvectors>`
**************************************************************

Commonly signals in VHDL are of a logic type or a vector thereof (``std_logic`` and ``std_logic_vector``), coming from the ``ieee.std_logic_1164.*`` package.
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

Because the number of enumeration values is less than 256, logic values are transported in 8 bit words (a ``char`` type in C) (as mentioned in :ref:`Restrictions_on_foreign_declarations`).
Logic vectors, of a bounded size, are easily created in C and passed to VHDL as ``char[]``. VHDL receives pointers as ``access`` types, in this case an access of a subtype of std_logic_vector.

In this example two declarations make handling logic values in C a bit easier:

- Providing logic values in C as their enumeration numbers is simplified with the use of a matching enumeration, ``HDL_LOGIC_STATES``. 
- Printing out a logic value's associated character is also simplified with the ``const char HDL_LOGIC_CHAR[]`` declaration.

This example builds on the matrices example (:ref:`COSIM:VHPIDIRECT:Examples:quickstart:matrices:`). Foreign subprograms are declared that enable receiving the size of two different logic vectors as well as the vectors themselves from C. There is only one subprogram to get the size of both C arrays, and it takes in an integer to determine which array's size gets returned. 

.. HINT::
  The ``getLogicVecSize`` in VHDL is declared as receiving a ``boolean`` argument. In C the function is declared to receive an ``integer`` argument. The VHDL booleans ``true`` and ``false`` have integer values, ``1`` and ``0`` respectively. So this mismatch causes no real issues.


The two vectors are populated with logic values in different ways:

- LogicVectorA's indices are manually filled with enumeration values from HDL_LOGIC_STATES.

  - .. code-block:: C

        logic_vec_A[0] = HDL_U;

- LogicVectorB's indices are filled with an integer value.

  - .. code-block:: C

        for(int i = 0; i < SIZE_LOGIC_VEC_B; i++){
          logic_vec_B[i] = 8-i;
        }

.. ATTENTION::
  The integer values that are given to ``char`` variables in C, must be limited to [0, 8]. This ensures that they represent one of the 9 enumerated logic values.
