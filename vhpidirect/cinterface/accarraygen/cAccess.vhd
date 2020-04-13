package cAccess is
	generic (
		N : integer := 2
	);

	procedure showN;

	type int_arr is array(0 to N-1) of integer;
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

	procedure showN is
	begin
		report "cAccess N: " & integer'image(N);
	end procedure showN;

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
