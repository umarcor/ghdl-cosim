library ieee;
context ieee.ieee_std_context;

entity tb is
end;

architecture arch of tb is
begin
  process

    constant blen : natural := 16;
    subtype svec_t is std_logic_vector(0 to blen*8-1);

    type ivec_t is array (0 to blen/4-1) of integer;

    procedure cryptData (
      din  : ivec_t;
      key  : ivec_t;
      dout : ivec_t;
      blen : integer
    ) is
    begin assert false report "VHPIDIRECT encrypt" severity failure; end;
    attribute foreign of cryptData : procedure is "VHPIDIRECT encrypt";

    variable vin  : svec_t := x"3925841D02DC09FBDC118597196A0B32";
    variable vkey : svec_t := x"2B7E151628AED2A6ABF7158809CF4F3C";
    variable vout : svec_t;

    variable cin, ckey, cout: ivec_t;

  begin

    report "Hello crypto!" severity note;

    for x in ivec_t'range loop
      cin(x) := to_integer(signed(vin(32*x to 32*(x+1)-1)));
      ckey(x) := to_integer(signed(vkey(32*x to 32*(x+1)-1)));
    end loop;

    cryptData(cin, ckey, cout, vin'length/8);

    for x in ivec_t'range loop
      vout(32*x to 32*(x+1)-1) := std_logic_vector(to_signed(cout(x), 32));
    end loop;

    report "vout : " & to_hstring(vout) severity note;
    assert to_hstring(vout) = "7DFDFF39CC79C14315BAF5EF727CC0CF" severity failure;

    wait;
  end process;
end;
