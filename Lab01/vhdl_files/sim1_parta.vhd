----------------------------------------------------------------------------------
-- Company: IPVS/PAS
-- Engineer:
--
-- Create Date: 25.04.2017 17:31:35
-- Design Name:
-- Module Name: sim1_parta - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies: DATA COMPRESSION LAB
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sim1_parta is
--  Port ( );
end sim1_parta;

architecture Behavioral of sim1_parta is

component moore_4s is
	port(
    clk_i      : in    std_logic;
    ce_i       : in    std_logic;
    rst_i      : in    std_logic;

    data_i  : in    std_logic;
    data_o : out    std_logic_vector(1 downto 0)
);
end component;

signal clk_i    : STD_LOGIC;
signal ce_i     : STD_LOGIC;
signal rst_i    : STD_LOGIC;

signal data_i   : STD_LOGIC;
signal data_o   : STD_LOGIC_VECTOR(1 downto 0);

signal err_cnt: integer := 0;

constant clk_period : time := 10 ns;

begin
    uut: moore_4s
        port map (
        clk_i   => clk_i,
        ce_i    => ce_i,
        rst_i   => rst_i,
        data_i  => data_i,
        data_o  => data_o);

    clk_generator : process
    begin
        clk_i <= '0';
        wait for clk_period / 2;
        clk_i <= '1';
        wait for clk_period / 2;
    end process; -- clock_generator

    stimuli : process
    begin
        ce_i   <= '1'; -- always enable clock.
        rst_i  <= '1'; -- reset
        data_i <= '0';
        wait for 20 ns;
        rst_i <= '0'; data_i <= '0';

        wait for 10 ns;
        if data_o /= "00" then
            err_cnt <= err_cnt + 1;
        end if;
        data_i <= '1';

        wait for 10 ns;
        if data_o /= "01" then
            err_cnt <= err_cnt + 1;
        end if;
        data_i <= '0';

        wait for 10 ns;
        if data_o /= "01" then
            err_cnt <= err_cnt + 1;
        end if;
        data_i <= '1';

        wait for 10 ns;
        if data_o /= "10" then
            err_cnt <= err_cnt + 1;
        end if;
        data_i <= '0';

        wait for 10 ns;
        if data_o /= "10" then
            err_cnt <= err_cnt + 1;
        end if;
        data_i <= '0';

        wait for 10 ns;
        if data_o /= "10" then
            err_cnt <= err_cnt + 1;
        end if;
        data_i <= '1';

        wait for 10 ns;
        if data_o /= "11" then
            err_cnt <= err_cnt + 1;
        end if;
        data_i <= '1';

        wait for 10 ns;
        if data_o /= "00" then
            err_cnt <= err_cnt + 1;
        end if;
        data_i <= '1';

        wait for 10 ns;
        if data_o /= "01" then
            err_cnt <= err_cnt + 1;
        end if;
        data_i <= '0';

        if err_cnt <= 0 then
            report "Test Passed";
        else
            report "Test Failed";
        end if;


        wait;
    end process;

end Behavioral;
