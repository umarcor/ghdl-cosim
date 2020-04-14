use work.pkg.all;

entity ent2 is
end ent2;

architecture rtl of ent2 is
begin
    process
    begin
        report "Entity2 setting c_Var to 2." severity note;
        c_Var.all := 2;        
        c_printVar;
        wait;
    end process ;
end rtl ; -- rtl

