use work.pkg.all;

entity ent1 is
end ent1;

architecture rtl of ent1 is
begin
    process
    begin
        report "Entity1 calling c_print(1)." severity note;
        c_printInt(1);
        wait;        
    end process ;
end rtl ; -- rtl

