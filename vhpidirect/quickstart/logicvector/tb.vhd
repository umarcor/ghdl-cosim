library ieee;
use ieee.std_logic_1164.all;

entity tb is
end;

architecture arch of tb is
begin
  process

    function getLogicVecASize return integer is
    begin assert false report "VHPIDIRECT getLogicVecASize" severity failure; end;
    attribute foreign of getLogicVecASize : function is "VHPIDIRECT getLogicVecASize";
    function getLogicVecBSize return integer is
    begin assert false report "VHPIDIRECT getLogicVecBSize" severity failure; end;
    attribute foreign of getLogicVecBSize : function is "VHPIDIRECT getLogicVecBSize";
    function getLogicVecCSize return integer is
    begin assert false report "VHPIDIRECT getLogicVecCSize" severity failure; end;
    attribute foreign of getLogicVecCSize : function is "VHPIDIRECT getLogicVecCSize";

    subtype logic_vec_a_t is std_logic_vector(0 to getLogicVecASize-1);
    type logic_vec_a_ptr_t is access logic_vec_a_t;
    
    subtype logic_vec_b_t is std_ulogic_vector(0 to getLogicVecBSize-1);
    type logic_vec_b_ptr_t is access logic_vec_b_t;

    type logic_vec_c_t is array(0 to getLogicVecCSize-1, 0 to getLogicVecCSize-1) of std_logic;
    type logic_vec_c_ptr_t is access logic_vec_c_t;

    function getLogicVecA return logic_vec_a_ptr_t is
    begin assert false report "VHPIDIRECT getLogicVecA" severity failure; end;
    attribute foreign of getLogicVecA : function is "VHPIDIRECT getLogicVecA";

    function getLogicVecB return logic_vec_b_ptr_t is
    begin assert false report "VHPIDIRECT getLogicVecB" severity failure; end;
    attribute foreign of getLogicVecB : function is "VHPIDIRECT getLogicVecB";

    function getLogicVecC return logic_vec_c_ptr_t is
    begin assert false report "VHPIDIRECT getLogicVecC" severity failure; end;
    attribute foreign of getLogicVecC : function is "VHPIDIRECT getULogicMat";

    variable g_logic_vec_a: logic_vec_a_ptr_t := getLogicVecA;
    variable g_logic_vec_b: logic_vec_b_ptr_t := getLogicVecB;
    variable g_logic_vec_c: logic_vec_c_ptr_t := getLogicVecC;
    
    constant logicArray: std_logic_vector(0 to 8) := ('U', 'X', '0', '1', 'Z', 'W', 'L', 'H', '-');
    variable spareInt: integer;
  begin

    report "g_logic_vec_a'length: " & integer'image(g_logic_vec_a'length) severity note;

    for x in g_logic_vec_a'range loop
      report "Asserting VecA [" & integer'image(x) & "]: " & std_logic'image(g_logic_vec_a(x)) severity note;
      assert g_logic_vec_a(x) = logicArray(x) severity failure;
    end loop;

    for x in g_logic_vec_b'range loop
      report "Asserting VecB [" & integer'image(x) & "]: " & std_logic'image(g_logic_vec_b(x)) severity note;
      assert g_logic_vec_b(x) = logicArray(8-x) severity failure;
    end loop;
 
    spareInt := 0;
    for x in g_logic_vec_c'range(1) loop
      for y in g_logic_vec_c'range(2) loop
        report "Asserting Mat [" & integer'image(x) & "][" & integer'image(y) & "]: " & std_logic'image(g_logic_vec_c(x,y)) severity note;
        assert g_logic_vec_c(x,y) = logicArray(spareInt) severity failure;
        spareInt := spareInt +1;
      end loop;
    end loop;

    wait;
  end process;
end;
