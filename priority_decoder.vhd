library IEEE;
    use IEEE.std_logic_1164.all;


entity priority_decoder is
    port(input: in std_logic_vector(2 downto 0);
        output: out std_logic_Vector(7 downto 1));
end entity;


architecture arc_priority_decoder of priority_decoder is
begin
    output <= "1000000" when input = "111" else
              "0100000" when input = "110" else
              "0010000" when input = "101" else
              "0001000" when input = "100" else
              "0000100" when input = "011" else
              "0000010" when input = "010" else
              "0000001" when input = "001" else
              "0000000";
end architecture;

------------------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_priority_decoder is
end entity;


architecture arc_tb_priority_decoder of tb_priority_decoder is
    component priority_decoder is
        port(input: in std_logic_vector(2 downto 0);
            output: out std_logic_Vector(7 downto 1));
    end component;
    
    signal output_tb: std_logic_vector(7 downto 1);
    signal input_tb: std_logic_vector(2 downto 0) := "000";
begin
    decoder: priority_decoder port map(input => input_tb, output => output_tb);
    
    input_tb(0) <= not input_tb(0) after 10ns;
    input_tb(1) <= not input_tb(1) after 20ns;
    input_tb(2) <= not input_tb(2) after 40ns;
end architecture;