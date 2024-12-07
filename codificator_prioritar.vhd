library IEEE;
    use IEEE.std_logic_1164.all;


entity priority_encoder is
    port(input: in std_logic_vector(7 downto 1);
        output: out std_logic_vector(2 downto 0));
end entity;


architecture arc_priority_encoder of priority_encoder is
begin
    output <= "111" when input(7) = '1' else
              "110" when input(6) = '1' else
              "101" when input(5) = '1' else
              "100" when input(4) = '1' else
              "011" when input(3) = '1' else
              "010" when input(2) = '1' else
              "001" when input(1) = '1' else
              "000";
end architecture;

----------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_priority_encoder is
end entity;


architecture arc_tb_priority_encoder of tb_priority_encoder is
    component priority_encoder is
        port(input: in std_logic_vector(7 downto 1);
            output: out std_logic_vector(2 downto 0));
    end component;
    
    signal input_tb: std_logic_vector(7 downto 1) := "0000000";
    signal output_tb: std_logic_vector(2 downto 0);
begin
    encoder: priority_encoder port map(input => input_tb, output => output_tb);
    
    input_tb(1) <= not input_tb(1) after 10ns;
    input_tb(2) <= not input_tb(2) after 20ns;
    input_tb(3) <= not input_tb(3) after 40ns;
    input_tb(4) <= not input_tb(4) after 80ns;
    input_tb(5) <= not input_tb(5) after 160ns;
    input_tb(6) <= not input_tb(6) after 250ns;
end architecture;