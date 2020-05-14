entity tb is
	generic(
		arraySize : integer := 1
	);

	package tbPkg is new work.pkg
	generic map (
		N => arraySize
	);
	use tbPkg.all;
end entity tb;

architecture RTL of tb is
begin
	process
		variable int : integer;
	begin
		report "ArraySize Generic: " & integer'image(arraySize);
		showN;

		for i in 0 to arraySize-1 loop
			int := c_intArr.get(i);
			c_intArr.set(i, -2*int);
			report "c_intArr[" & integer'image(i) &"] = " &  integer'image(int) & ". Set to: " & integer'image(c_intArr.get(i));
		end loop;

		c_freeArr;
		wait;
	end process;

end architecture RTL;
