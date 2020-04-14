use work.pkg.all;

entity ent1 is
end ent1;

architecture rtl of ent1 is
begin
    process
    begin
        report "Entity1 setting c_Var to 1." severity note;
        c_Var.all := 1;
        c_printVar;
        wait;        
    end process ;
end rtl ; -- rtl

