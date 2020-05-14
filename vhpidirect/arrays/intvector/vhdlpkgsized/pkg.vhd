package pkg is
	generic (
		N : integer := 2
	);

	procedure showN;

	type int_arr is array(0 to N-1) of integer;
	type int_arr_ptr is access int_arr; -- represented C-side with int*

	impure function c_allocAndInitIntArr(size: integer) return int_arr_ptr;
	attribute foreign of c_allocAndInitIntArr : function is "VHPIDIRECT allocAndInitIntArr";

	procedure c_freePointer(variable ptr: int_arr_ptr);
	attribute foreign of c_freePointer : procedure is "VHPIDIRECT freePointer";

	type int_arr_ptr_pro is protected
		impure function get(index: integer) return integer;
		procedure set(index: integer; val: integer);
		procedure free;
	end protected;

	shared variable c_intArr : int_arr_ptr_pro;
end package pkg;

package body pkg is

	procedure showN is
	begin
		report "pkg Generic: " & integer'image(N);
	end;

	type int_arr_ptr_pro is protected body
		variable hidden_c_ptr : int_arr_ptr := c_allocAndInitIntArr(N);

		impure function get(index: integer) return integer is
		begin
			return hidden_c_ptr(index);
		end function;

		procedure set(index: integer; val: integer) is
		begin
			hidden_c_ptr(index) := val;
		end procedure;

		procedure free is
		begin
			c_freePointer(hidden_c_ptr);
		end procedure;
	end protected body;

	impure function c_allocAndInitIntArr(size: integer) return int_arr_ptr is
	begin
		report "c_allocAndInitIntArr VHPI" severity failure;
	end function;

	procedure c_freePointer(variable ptr: int_arr_ptr) is
	begin
		report "c_freePointer VHPI" severity failure;
	end procedure;

end package body pkg;
