use std.textio.line;

library ieee;
use ieee.std_logic_1164.all;

entity tb is
end;

architecture arch of tb is

  type bool_vec_t is array(natural range <>) of boolean;
  type logic_vec_t is array(natural range <>) of std_logic;
  type ulogic_mat_t is array(natural range <>, natural range <>) of std_ulogic;

begin
  process

    procedure testCinterface(
      v_1D_logic   : logic_vec_t;
      v_1D_ulogic   : ulogic_mat_t
    ) is
    begin assert false report "VHPIDIRECT testCinterface" severity failure; end;
    attribute foreign of testCinterface : procedure is "VHPIDIRECT testCinterface";

    function getLogicVec return logic_vec_t is
    begin assert false report "VHPIDIRECT getLogicVec" severity failure; end;
    attribute foreign of getLogicVec : function is "VHPIDIRECT getLogicVec";

    function getULogicMat return ulogic_mat_t is
    begin assert false report "VHPIDIRECT getULogicMat" severity failure; end;
    attribute foreign of getULogicMat : function is "VHPIDIRECT getULogicMat";


    procedure freeCPointers is
    begin assert false report "VHPIDIRECT freeCPointers" severity failure; end;
    attribute foreign of freeCPointers : procedure is "VHPIDIRECT freePointers";

    constant g_logic_vec: logic_vec_t := getLogicVec;
    constant g_ulogic_mat: ulogic_mat_t := getULogicMat;
    
    constant logicArray: std_logic_vector(0 to 8) := ('U', 'X', '0', '1', 'Z', 'W', 'L', 'H', '-');

    variable spareInt: integer;
  begin

    testCinterface(
      v_1D_logic   => ('1', 'H', 'X'),
      v_1D_ulogic  =>  (('1', 'H', 'X'), ('1', 'H', 'X'))
    );

    report "g_logic_vec'length: " & integer'image(g_logic_vec'length) severity note;

    for x in g_logic_vec'range loop
      report "Asserting Vec [" & integer'image(x) & "]: " & std_logic'image(g_logic_vec(x)) severity note;
      assert g_logic_vec(x) = logicArray(x) severity failure;
    end loop;

    spareInt := 0;
    report "g_ulogic_mat'length: " & integer'image(g_ulogic_mat'length) severity note;
    for i in g_ulogic_mat'range(1) loop
      for j in g_ulogic_mat'range(2) loop
        report "Asserting Mat [" & integer'image(i) & "," & integer'image(j) & "]: " & std_logic'image(g_ulogic_mat(i, j)) severity note;
        assert g_ulogic_mat(i, j) = logicArray(spareInt) severity failure;
        spareInt := spareInt + 1;
      end loop ;
    end loop ;

    freeCPointers;
    wait;
  end process;
end;
