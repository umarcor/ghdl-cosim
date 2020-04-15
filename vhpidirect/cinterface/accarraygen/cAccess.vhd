package cAccess is
	generic (
		N : integer := 2
	);

	procedure showN;

	type int_arr is array(0 to N-1) of integer;
	type int_arr_ptr is access int_arr; -- represented C-side with int*
	
	impure function c_intArr_ptr return int_arr_ptr;
	attribute foreign of c_intArr_ptr : function is "VHPIDIRECT getIntArr_ptr";

	type int_arr_ptr_pro is protected
		impure function getRight return integer;
		impure function get(index: positive) return integer;
		procedure set(index: positive; val: integer);
	end protected int_arr_ptr_pro;

	shared variable c_intArr : int_arr_ptr_pro;
end package cAccess;

package body cAccess is

	procedure showN is
	begin
		report "cAccess Generic: " & integer'image(N);
	end showN;

	type int_arr_ptr_pro is protected body
		variable hidden_c_ptr : int_arr_ptr := c_intArr_ptr;
		impure function getRight return integer is
		begin
			return hidden_c_ptr'right;
		end function;

		impure function get(index: positive) return integer is
		begin
			return hidden_c_ptr(index);
		end function get;

		procedure set(index: positive; val: integer) is
		begin
			hidden_c_ptr(index) := val;
		end procedure set;
	end protected body int_arr_ptr_pro;

	
	impure function c_intArr_ptr return int_arr_ptr is
	begin
		assert false report "c_intArr_ptr VHPI" severity failure;
	end c_intArr_ptr;
end package body cAccess;
