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

    function getLine return line is
    begin report "VHPIDIRECT getLine" severity failure; end;
    attribute foreign of getLine : function is "VHPIDIRECT getLine";

    constant g_str: string := getString;
    constant g_int_vec: int_vec_t := getIntVec;

    variable g_line: line := getLine;

  begin

    report "g_str'length: " & integer'image(g_str'length) severity note;
    if g_str'length /= 0 then
      report "g_str: " & g_str severity note;
    end if;
    report "string: " & getString severity note;

    report "g_int_vec'length: " & integer'image(g_int_vec'length) severity note;
    for x in g_int_vec'range loop
      report integer'image(x) & ": " & integer'image(g_int_vec(x)) severity note;
      assert g_int_vec(x) = 11*(x+1) severity warning;
    end loop;

    report "g_line: " & g_line.all severity note;
    report "getLine: " & getLine.all severity note;
    assert getLine.all = "HELLO WORLD" severity failure;

    wait;
  end process;
end;
