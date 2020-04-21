package pkg is
	generic (
		N : integer := 2
	);

	procedure showN;

	type int_arr is array(0 to N-1) of integer;
	type int_arr_ptr is access int_arr; -- represented C-side with int*

	impure function c_intArr_ptr(size: integer) return int_arr_ptr;
	attribute foreign of c_intArr_ptr : function is "VHPIDIRECT getIntArr_ptr";

	procedure c_freeArr;
	attribute foreign of c_freeArr : procedure is "VHPIDIRECT freeArr";

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
		variable hidden_c_ptr : int_arr_ptr := c_intArr_ptr(N);
		impure function getRight return integer is
		begin
			return hidden_c_ptr'right;
		end function;

		impure function get(index: integer) return integer is
		begin
			return hidden_c_ptr(index);
		end function;

		procedure set(index: integer; val: integer) is
		begin
			hidden_c_ptr(index) := val;
		end procedure;
	end protected body;

	impure function c_intArr_ptr(size: integer) return int_arr_ptr is
	begin
		assert false report "c_intArr_ptr VHPI" severity failure;
	end function;

	procedure c_freeArr is
	begin
		assert false report "c_freeArr VHPI" severity failure;
	end procedure;

end package body pkg;
