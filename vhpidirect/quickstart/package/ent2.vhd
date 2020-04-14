use work.pkg.all;

entity ent2 is
end ent2;

architecture rtl of ent2 is
begin
    process
    begin
        report "Entity2 calling c_print(2)." severity note;
        c_printInt(2);
        wait;
    end process ;
end rtl ; -- rtl

