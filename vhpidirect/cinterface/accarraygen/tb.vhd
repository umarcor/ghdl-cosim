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
		shown;

		for i in 0 to arraySize-1 loop
			int := c_intArr.get(i);
			report "c_intArr[" & integer'image(i) &"] = " &  integer'image(int) & ". Set to: " & integer'image(-2*int);
			c_intArr.set(i, -2*int);
		end loop;
		
		wait;
	end process;

end architecture RTL;
