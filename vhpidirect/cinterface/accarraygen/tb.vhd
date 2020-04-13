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
		variable int : integer;
	begin		
		report "ArraySize Generic: " & integer'image(arraySize);
		tbCaccess.showN;
		report "Array length: " & integer'image(c_intArr.all'length);

		for i in 0 to (c_intArr.getArray)'right loop
			int := c_intArr.get(i);
			report "c_intArr[" & integer'image(i) &"] = " &  integer'image(int) & ". Set to: " & integer'image(-2*int);
			c_intArr.set(i, -2*int);
		end loop;
		
		c_freeIntArray;
		wait;
	end process;

end architecture RTL;
