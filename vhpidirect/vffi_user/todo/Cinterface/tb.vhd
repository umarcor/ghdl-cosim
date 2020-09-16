use std.textio.line;

entity tb is
end;

architecture arch of tb is

  type int_vec_t is array(natural range <>) of integer;

begin
  process

    function getString return string is
    begin report "VHPIDIRECT getString" severity failure; end;
    attribute foreign of getString : function is "VHPIDIRECT getString";

    function getIntVec return int_vec_t is
    begin report "VHPIDIRECT getIntVec" severity failure; end;
    attribute foreign of getIntVec : function is "VHPIDIRECT getIntVec";

    constant g_str: string := getString;
--    constant g_int_vec: int_vec_t := getIntVec;

    procedure printLine(variable l: line) is
    begin report l.all severity note; end;

    variable l: line := new string'("HI!");

  begin

    report "g_str'length: " & integer'image(g_str'length) severity note;
    if g_str'length = 5 then
      report "g_str: " & g_str severity note;
    end if;
--    report "string: " & getString severity note;

--    report "g_int_vec'length: " & integer'image(g_int_vec'length) severity note;

    printLine(l);

    wait;
  end process;
end;
