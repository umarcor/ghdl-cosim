use std.textio.line;

entity tb is
end;

architecture arch of tb is

begin
  process

    function getString return string is
    begin report "VHPIDIRECT getString" severity failure; end;
    attribute foreign of getString : function is "VHPIDIRECT getString";

  begin

    report "string: " & getString severity note;

    wait;
  end process;
end;