library IEEE;
    use IEEE.std_logic_1164.all;


entity demux_1x4 is
    port(input: in std_logic;
        sel: in std_logic_vector(1 downto 0);
        output: out std_logic_vector(3 downto 0));
end entity;


architecture arc_demux_1x4 of demux_1x4 is
begin
    output <= "0001" when sel = "00" and input = '1' else
              "0010" when sel = "01" and input = '1' else
              "0100" when sel = "10" and input = '1' else
              "1000" when sel = "11" and input = '1' else
              "0000";
end architecture;

--------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_demux_1x4 is
end entity;


architecture arc_tb_demux_1x4 of tb_demux_1x4 is
    component demux_1x4 is
        port(input: in std_logic;
            sel: in std_logic_vector(1 downto 0);
            output: out std_logic_vector(3 downto 0));
    end component;

    signal input_tb: std_logic := '0';
    signal sel_tb: std_logic_vector(1 downto 0) := "00";
    signal output_tb: std_logic_vector(3 downto 0);
begin
    demux: demux_1x4 port map(input => input_tb, sel => sel_tb, output => output_tb);

    input_tb <= not input_tb after 10ns;
    sel_tb(0) <= not sel_tb(0) after 20ns;
    sel_tb(1) <= not sel_tb(1) after 40ns;
end architecture;