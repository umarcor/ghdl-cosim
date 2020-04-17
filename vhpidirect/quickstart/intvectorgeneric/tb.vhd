entity tb is
	generic(
		arraySize : integer := 1
	);
end entity tb;

architecture RTL of tb is
begin
	process
		type int_arr is array(0 to arraySize-1) of integer;
		type int_arr_ptr is access int_arr; -- represented C-side with int*

		impure function c_intArr_ptr return int_arr_ptr is
		begin
			assert false report "c_intArr_ptr VHPI" severity failure;
		end;
		attribute foreign of c_intArr_ptr : function is "VHPIDIRECT getIntArr_ptr";

		variable c_intArr : int_arr_ptr := c_intArr_ptr;
	begin
		report "ArraySize Interface Generic: " & integer'image(arraySize);

		for i in 0 to arraySize-1 loop
			report "c_intArr[" & integer'image(i) & "] = " &  integer'image(c_intArr(i)) & ". Set to: " & integer'image(-2*c_intArr(i));
			c_intArr(i) := -2*c_intArr(i);
		end loop;

		wait;
	end process;

end architecture RTL;
