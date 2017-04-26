----------------------------------------------------------------------------------
-- Company: IPVS/PAS
-- Engineer: 
-- 
-- Create Date: 25.04.2017 17:23:12
-- Design Name: 
-- Module Name: moore_4s - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: DATA COMPRESSION LAB
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity moore_4s is
	port(
    clk_i      : in   std_logic;
    ce_i       : in   std_logic;
    rst_i      : in   std_logic;
    
    data_i     : in   std_logic;
    data_o     : out  std_logic_vector(1 downto 0)
);
end moore_4s;

architecture Behavioral of moore_4s is    
    -- Build an enumerated type for the state machine
    type state_t is (s0, s1, s2, s3);
    -- Register to hold the current state
    signal state_s   :  state_t;
    
begin

    edges: process(clk_i, rst_i)
    begin
        if rst_i='1' then
            state_s<=s0;
        elsif (clk_i'event and clk_i='1') then
            case state_s is
                when s0 => 
                    if    data_i = '0' then 
                        state_s<=s0;
                    elsif data_i='1'   then 
                        state_s<=s1; 
                    end if;
                    
                when s1 => 
                    if    data_i = '0' then 
                        state_s<=s1;
                    elsif data_i='1'   then 
                        state_s<=s2; 
                    end if;                           
                
                when s2 =>
                    if    data_i = '0' then 
                       state_s<=s2;
                    elsif data_i='1'   then 
                        state_s<=s3; 
                    end if; 
                
                when s3 =>
                    if    data_i = '0' then 
                        state_s<=s3;
                    elsif data_i='1'   then 
                        state_s<=s0; 
                    end if;
                end case; 
           end if;	     
    end process edges;
    
  
    outputs: process (state_s)
    begin
        case state_s is
            when s0 => 
                data_o <= "00";  
            when s1 => 
                data_o <= "01"; 
            when s2 => 
                data_o <= "10"; 
            when s3 => 
                data_o <= "11";
        end case;   
    end process outputs;
end Behavioral;
