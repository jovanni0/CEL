library IEEE;
    use IEEE.std_logic_1164.all;


entity transparent_d_latch is
    port(d, enable: in std_logic;
        q: out std_logic);
end entity;


architecture arc of transparent_d_latch is
begin
    process(enable, d)
    begin
        if enable = '1' then
            q <= d;
        end if;
    end process;
end architecture;