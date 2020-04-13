library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.cAccess.all;

entity tb is
end entity tb;

architecture RTL of tb is

begin
	
	process
	begin		
		report "Array length: " & integer'image(c_intArr.all'length);

		for i in 0 to c_intArr.all'right loop
			report "c_intArr[" & integer'image(i) &"] = " &  integer'image(c_intArr.all(i)) & ". Set to: " & integer'image(-2*c_intArr.all(i));
			c_intArr.all(i) := -2*c_intArr.all(i);
		end loop;
		
		c_freeIntArray;
		wait;
	end process;

end architecture RTL;
