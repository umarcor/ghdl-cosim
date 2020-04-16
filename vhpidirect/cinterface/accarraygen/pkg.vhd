package pkg is
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
		impure function get(index: integer) return integer;
		procedure set(index: integer; val: integer);
	end protected;

	shared variable c_intArr : int_arr_ptr_pro;
end package pkg;

package body pkg is

	procedure showN is
	begin
		report "pkg Generic: " & integer'image(N);
	end;

	type int_arr_ptr_pro is protected body
		variable hidden_c_ptr : int_arr_ptr := c_intArr_ptr;
		impure function getRight return integer is
		begin
			return hidden_c_ptr'right;
		end;

		impure function get(index: integer) return integer is
		begin
			return hidden_c_ptr(index);
		end;

		procedure set(index: integer; val: integer) is
		begin
			hidden_c_ptr(index) := val;
		end;
	end protected body;
	
	impure function c_intArr_ptr return int_arr_ptr is
	begin
		assert false report "c_intArr_ptr VHPI" severity failure;
	end;
end package body pkg;