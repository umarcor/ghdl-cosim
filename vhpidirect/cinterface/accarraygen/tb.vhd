entity tb is
	generic(
		arraySize : integer := 1
	);
end entity tb;

architecture RTL of tb is
	package tbCaccess is new work.cAccess
	generic map (
		N => arraySize
	);
begin
	process
		use tbCaccess.all;
	begin		
		report "ArraySize Generic: " & integer'image(arraySize);
		tbCaccess.showN;
		report "Array length: " & integer'image(c_intArr.all'length);

		for i in 0 to c_intArr.all'right loop
			report "c_intArr[" & integer'image(i) &"] = " &  integer'image(c_intArr.all(i)) & ". Set to: " & integer'image(-2*c_intArr.all(i));
			c_intArr.all(i) := -2*c_intArr.all(i);
		end loop;
		
		c_freeIntArray;
		wait;
	end process;

end architecture RTL;
