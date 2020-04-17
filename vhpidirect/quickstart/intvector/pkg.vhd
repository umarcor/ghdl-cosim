package pkg is
	function c_intArrSize return integer; -- represented C-side with int*
	attribute foreign of c_intArrSize : function is "VHPIDIRECT getIntArrSize"; -- getIntArrSize is the C-side function name

	type int_arr is array(0 to c_intArrSize-1) of integer;
	type int_arr_ptr is access int_arr; -- represented C-side with int*
	
	
	function c_intArr_ptr return int_arr_ptr;
	attribute foreign of c_intArr_ptr : function is "VHPIDIRECT getIntArr_ptr";

	shared variable c_intArr : int_arr_ptr := c_intArr_ptr;
end package pkg;

package body pkg is

	function c_intArrSize return integer is
	begin
		assert false report "c_intArrSize VHPI" severity failure;
	end c_intArrSize;

	function c_intArr_ptr return int_arr_ptr is
	begin
		assert false report "c_intArr_ptr VHPI" severity failure;
	end c_intArr_ptr;
end package body pkg;
