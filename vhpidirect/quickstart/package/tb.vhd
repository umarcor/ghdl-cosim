use work.pkg.all;

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
    report "Testbench." severity note;
    wait;
  end process;

end;
