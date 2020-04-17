use work.pkg.all;

entity ent is
end ent;

architecture rtl_A of ent is
begin
	process
	begin
		report "Entity1: c_Var is " & integer'image(c_Var.all);
		report "Entity1: setting c_Var to 1." severity note;
		c_Var.all := 1;
		c_printVar;
		wait;
	end process;
end rtl_A;

architecture rtl_B of ent is
begin
	process
	begin
		report "Entity2: c_Var is " & integer'image(c_Var.all);
		report "Entity2: setting c_Var to 2." severity note;
		c_Var.all := 2;
		c_printVar;
		wait;
	end process;
end rtl_B;
