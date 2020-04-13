use work.cAccess.all;

entity tb is
end tb;

architecture arch of tb is
	component ent1
	end component ent1;
	component ent2
	end component ent2;
begin

  entA : component ent1;
  entB : component ent2;

  process
  begin
    report "Testbench setting c_Var to -1." severity note;
    c_Var.all := -1;        
    c_printVar;
    wait;
  end process;

end;
