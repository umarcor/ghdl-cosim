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

:cosimtree:`logicvectors <vhpidirect/quickstart/logicvectors>`
**************************************************************

Commonly signals in VHDL are of a logic type or a vector thereof (``std_logic`` and ``std_logic_vector``), coming from the ``ieee.std_logic_1164.*`` package.
Because logic values are more than high and low (``1`` and ``0``), the VHDL values of logic types (``std_logic`` and ``std_ulogic``) are enumrations:

0. 'U' 
1. 'X' 
2. '0' 
3. '1' 
4. 'Z' 
5. 'W' 
6. 'L' 
7. 'H' 
8. '-' 

Because number of enumeration values is less than 256, logic values are transported in 8 bit words (a ``char`` type in C).
Logic vectors, of a bounded size, are easily created in C and passed to VHDL as ``char[]``. VHDL receives pointers as ``access`` types, in this case an access of a subtype of std_logic_vector.

Providing logic values in C as their enumeration numbers is simplified with the use of a matching enumeration, provided as ``HDL_LOGIC_STATES``. Printing out a logic value's associated character is also simplified with the provided ``const char HDL_LOGIC_CHAR[]``.

This example declares foreign subprograms that enable receiving the size of two different logic vectors as well as the vectors themselves from C. The two vectors are populated with logic values in different ways:

- LogicVectorA's indices are manually filled with enumeration values from HDL_LOGIC_STATES.

  - .. code-block:: C

        logic_vec_A[0] = HDL_U;

- LogicVectorB's indices are filled with an integer value. **The integer values must be limited to [0, 8]**.

  - .. code-block:: C

        for(int i = 0; i < SIZE_LOGIC_VEC_B; i++){
          logic_vec_B[i] = 8-i;
        }
