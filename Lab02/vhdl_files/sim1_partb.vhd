----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2017 09:51:05
-- Design Name: 
-- Module Name: sim1_partb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
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

entity sim1_partb is
--  Port ( );
end sim1_partb;

architecture Behavioral of sim1_partb is


component run_length_encoder is
    Port (
        clk_i       : in STD_LOGIC;                         -- clk_i signal
        rst_i       : in STD_LOGIC;                         -- reset signal
        ce_i        : in STD_LOGIC;                         -- clock enable signal
        -- input signals
        valid_i     : in STD_LOGIC;                         -- input data is valid.
        pixel_i     : in STD_LOGIC;                         -- bit input
        eol_i       : in STD_LOGIC;                         -- notify the end of row.
        -- output signals
        len_o    : out STD_LOGIC_VECTOR(10 downto 0);    -- the legth of run code cover up to 2^11 - 1 = 2047 length.
        run_o       : out STD_LOGIC;                        -- run code, either 0: white, 1: black
        valid_o     : out STD_LOGIC;                        -- run length code is valid or not.
        eol_o       : out STD_LOGIC                         -- indicate the end of row data.
    );
end component;

signal clk_i    : STD_LOGIC;
signal ce_i     : STD_LOGIC;
signal rst_i    : STD_LOGIC;

signal pixel_i   : STD_LOGIC;
signal eol_i   : STD_LOGIC;
signal valid_i   : STD_LOGIC;


signal len_o   : STD_LOGIC_VECTOR(10 downto 0);
signal run_o   : STD_LOGIC;
signal valid_o   : STD_LOGIC;
signal eol_o  : STD_LOGIC;


constant clk_period : time := 10 ns;

begin
    uut: run_length_encoder
        port map (
        clk_i   => clk_i,
        ce_i    => ce_i,
        rst_i   => rst_i,
        
        valid_i  => valid_i,
        pixel_i  => pixel_i,
        eol_i   => eol_i,
        
        valid_o => valid_o,
        run_o   => run_o,
        len_o   => len_o,
        eol_o   => eol_o);
        
    clk_generator : process
    begin
        clk_i <= '0';
        wait for clk_period / 2;
        clk_i <= '1';
        wait for clk_period / 2;
    end process; -- clock_generator
    
    stimuli: process
    begin
        ce_i    <= '1'; -- always enable clock.
        rst_i   <= '0'; -- reset
        pixel_i <= '1';
        eol_i   <= '0';
        valid_i <= '0';
        wait for 10 ns;
        rst_i   <= '1';
        wait for 10 ns;
        rst_i   <= '0'; 
        valid_i <= '0'; pixel_i <= '1';  eol_i <= '0';
        wait for 20 ns;
        valid_i <= '1'; pixel_i <= '1';  eol_i <= '0';
        wait for 30 ns;
        valid_i <= '1'; pixel_i <= '0';  eol_i <= '0';  
        wait for 20 ns;
        ce_i    <= '0';
        wait for 20 ns;
        ce_i    <= '1';
        wait for 10 ns;
        valid_i <= '1'; pixel_i <= '1';  eol_i <= '0';
        wait for 10 ns;
        valid_i <= '1'; pixel_i <= '0';  eol_i <= '1';
        wait for 10ns;
        valid_i <= '1'; pixel_i <= '1';  eol_i <= '0';
        wait for 40ns;
    end process; -- stimuli
    

end Behavioral;
