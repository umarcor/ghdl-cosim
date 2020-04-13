library ieee;
use ieee.std_logic_1164.all;

package cAccess is

	type int_ptr is access integer; -- represented C-side with int
	function c_intArrSize return integer; -- represented C-side with int*
		attribute foreign of c_intArrSize :
		function is "VHPIDIRECT getIntArrSize"; -- getIntArrSize is the C-side function name

	shared variable c_sizeInt : integer := c_intArrSize;

	type int_arr is array(0 to c_sizeInt-1) of integer;
	type int_arr_ptr is access int_arr; -- represented C-side with int*
	
	
	function c_intArr_ptr return int_arr_ptr;
		attribute foreign of c_intArr_ptr :
		function is "VHPIDIRECT getIntArr_ptr";
	
	procedure c_freeIntArray;
		attribute foreign of c_freeIntArray :
		procedure is "VHPIDIRECT freeIntArray";

	shared variable c_intArr : int_arr_ptr := c_intArr_ptr;
end package cAccess;

package body cAccess is

	function c_intArrSize return integer is
	begin
		assert false report "c_intArrSize VHPI" severity failure;
	end c_intArrSize;

	function c_intArr_ptr return int_arr_ptr is
	begin
		assert false report "c_intArr_ptr VHPI" severity failure;
	end c_intArr_ptr;

	procedure c_freeIntArray is
	begin
		assert false report "c_freeIntArray VHPI" severity failure;
	end c_freeIntArray;
end package body cAccess;
