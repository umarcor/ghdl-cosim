use std.textio.line;

library ieee;
use ieee.std_logic_1164.all;

entity tb is
end;

architecture arch of tb is
begin
  process

    function getLogicVecSize return integer is
    begin assert false report "VHPIDIRECT getLogicVecSize" severity failure; end;
    attribute foreign of getLogicVecSize : function is "VHPIDIRECT getLogicVecSize";

    constant g_logic_vec_size: integer := getLogicVecSize;
    subtype logic_vec_t is std_logic_vector(0 to g_logic_vec_size-1);
    type logic_vec_ptr_t is access logic_vec_t;

    function getLogicVec return logic_vec_ptr_t is
    begin assert false report "VHPIDIRECT getLogicVec" severity failure; end;
    attribute foreign of getLogicVec : function is "VHPIDIRECT getLogicVec";

    variable g_logic_vec: logic_vec_ptr_t := getLogicVec;
    
    constant logicArray: std_logic_vector(0 to 8) := ('U', 'X', '0', '1', 'Z', 'W', 'L', 'H', '-');
  begin

    report "g_logic_vec'length: " & integer'image(g_logic_vec'length) severity note;

    for x in g_logic_vec'range loop
      report "Asserting Vec [" & integer'image(x) & "]: " & std_logic'image(g_logic_vec.all(x)) severity note;
      assert g_logic_vec.all(x) = logicArray(x) severity failure;
    end loop;

    wait;
  end process;
end;
