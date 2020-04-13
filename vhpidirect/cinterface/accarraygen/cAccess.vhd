package cAccess is
	generic (
		N : integer := 2
	);

	procedure showN;

	type int_arr is array(0 to N-1) of integer;
	type int_arr_ptr is access int_arr; -- represented C-side with int*
	
	type int_arr_ptr_pro is protected
		impure function get(index: positive) return integer;
		impure function getArray return int_arr_ptr;
		procedure set(index: positive; val: integer);

		impure function c_intArr_ptr return int_arr_ptr;
			attribute foreign of c_intArr_ptr :
			function is "VHPIDIRECT getIntArr_ptr";
	end protected int_arr_ptr_pro;

	procedure c_freeIntArray;
		attribute foreign of c_freeIntArray :
		procedure is "VHPIDIRECT freeIntArray";

	shared variable c_intArr : int_arr_ptr_pro;
end package cAccess;

package body cAccess is

	type int_arr_ptr_pro is protected body
		variable hidden_c_ptr : int_arr_ptr := c_intArr_ptr;
		
		impure function c_intArr_ptr return int_arr_ptr is
		begin
			assert false report "c_intArr_ptr VHPI" severity failure;
		end c_intArr_ptr;

		impure function getArray return int_arr_ptr is
		begin
			return hidden_c_ptr.all;
		end;

		impure function get(index: positive) return integer is
		begin
			return hidden_c_ptr.all(index);
		end function get;

		procedure set(index: positive; val: integer) is
		begin
			hidden_c_ptr.all(index) := val;
		end procedure set;
	end protected body int_arr_ptr_pro;

	procedure c_freeIntArray is
	begin
		assert false report "c_freeIntArray VHPI" severity failure;
	end c_freeIntArray;
end package body cAccess;
