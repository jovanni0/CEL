library IEEE;
    use IEEE.std_logic_1164.all;


entity sum_1bit is
    port(a, b, c_in: in std_logic;
        s, c_out: out std_logic);
end entity;


architecture arc_sum_1bit of sum_1bit is
begin
    s <= a xor b xor c_in;
    c_out <= (a and b) or (a and c_in) or (b and c_in);
end architecture;

--------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity sum_4bit is
    port(a, b: in std_logic_vector(3 downto 0);
        c_in: in std_logic;
        s: out std_logic_vector(3 downto 0);
        c_out: out std_logic);
end entity;


architecture arc_sum_4bit of sum_4bit is
    component sum_1bit is
        port(a, b, c_in: in std_logic;
            s, c_out: out std_logic);
    end component;

    signal carry: std_logic_vector(2 downto 0) := "000";
begin
    sum0: sum_1bit port map(a => a(0), b => b(0), c_in => c_in, s => s(0), c_out => carry(0));
    sum1: sum_1bit port map(a => a(1), b => b(1), c_in => carry(0), s => s(1), c_out => carry(1));
    sum2: sum_1bit port map(a => a(2), b => b(2), c_in => carry(1), s => s(2), c_out => carry(2));
    sum3: sum_1bit port map(a => a(3), b => b(3), c_in => carry(2), s => s(3), c_out => c_out);
end architecture;

-------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_sum_4bit is
end entity;


architecture arc_tb_sum_4bit of tb_sum_4bit is
    component sum_4bit is
        port(a, b: in std_logic_vector(3 downto 0);
            c_in: in std_logic;
            s: out std_logic_vector(3 downto 0);
            c_out: out std_logic);
    end component;

    signal a_tb, b_tb, s_tb: std_logic_vector(3 downto 0) := "0000";
    signal c_in_tb, c_out_tb: std_logic := '0';
begin
    sum0: sum_4bit port map(a => a_tb, b => b_tb, c_in => c_in_tb, s => s_tb, c_out => c_out_tb);

    a_tb <= "0110" after 20ns, "1100" after 40ns;
    b_tb <= "0001", "0100" after 10ns, "1001" after 35ns;

    c_in_tb <= '1' after 50ns;
end architecture;