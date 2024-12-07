library IEEE;
    use IEEE.std_logic_1164.all;


entity mux_4x1 is
    port(input: in std_logic_vector(3 downto 0);
        sel: in std_logic_vector(1 downto 0);
        output: out std_logic);
end entity;


architecture arc_mux_4x1 of mux_4x1 is
begin
    output <= input(0) when sel = "00" else
              input(1) when sel = "01" else
              input(2) when sel = "10" else
              input(3) when sel = "00" else '0';
end architecture;

------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_mux_4x1 is
end entity;


architecture arc_tb_mux_4x1 of tb_mux_4x1 is
    component mux_4x1 is
        port(input: in std_logic_vector(3 downto 0);
            sel: in std_logic_vector(1 downto 0);
            output: out std_logic);
    end component;

    signal input_tb: std_logic_vector(3 downto 0) := "0000";
    signal sel_tb: std_logic_vector(1 downto 0) := "00";
    signal output_tb: std_logic;
begin
    mux: mux_4x1 port map(input => input_tb, sel => sel_tb, output => output_tb);

    input_tb(0) <= not input_tb(0) after 20ns;
    input_tb(1) <= not input_tb(1) after 40ns;
    input_tb(2) <= not input_tb(2) after 80ns;
    input_tb(3) <= not input_tb(3) after 160ns;

    sel_tb(0) <= not sel_tb(0) after 5ns;
    sel_tb(1) <= not sel_tb(1) after 10ns;
end architecture;