----------------------------------------------------------------------------------
-- Company: IPVS
-- Developer: Levindo Gabriel Taschetto Neto
--
-- Create Date: 25.04.2017 15:46:47
-- Design Name:
-- Module Name: run_length_encoder - Behavioral
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

entity run_length_encoder is
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
        run_s       : out STD_LOGIC;                        -- run code, either 0: white, 1: black
        valid_i     : out STD_LOGIC;                        -- run length code is valid or not.
        eol_o       : out STD_LOGIC                         -- indicate the end of row data.
    );
end run_length_encoder;

architecture Behavioral of run_length_encoder is
	-- Internal signals
	type      state_t is (s0, s1);
	signal    state_s      : state_t;
	signal    counter_s    : unsigned (len_o'range);
	signal    run_s        : std_logic;
	-- constant valudes
	constant   init_value  : unsigned(len_o'range) := to_unsigned(1,len_o'length);
begin

    -- intenal signal process
    process(clk_i, rst_i)
    edges: process(clk_i, rst_i)
        begin
            if rst_i='1' then
                state_s<=s0;
                counter_s <= (others => '0);
                run_s <= "0";
            elsif (clk_i'event and clk_i='1') then
                if valid_i = '1' then -- activates the counter of cycles that pixel_i=1 to put on len_o
                    if eol_i =  '1' then -- can't be end of line to make the counter increase (changes the row)
                        -- basically it's tje same process, but in another line
                        state_s<=s0;
                        counter_s <= (others => '0);
                        run_s <= "0";
                    else -- it's not end of some row, so it's needy a fsm to controll the number of
                         -- times that pixel_i is 1 (black) or 0 (white)
                         case state_s is
                            when s0 =>
                                if pixel_i = '0' then  -- stays in the same state coz the color isn't changed 
                                    state_s <= s0;
                                    counter_s <= counter_s + 1; -- counts the number of times that the pixel_i appears
                                    run_s <= 0; -- just to show in the output the counter_s is related to the pixel_i=0
                                     
                                else -- pixel_i = '0' (this should change the state because the color is changed)
                                    state_s <= s1; -- stays in the same state coz the color isn't changed
                                    
                                end if;
                            when s1 => 
                                if pixel_i = '0' then
                                    state_s <= s0;
                                    counter_s <= counter_s + 1;
                                    run_s <= 0; 
                                else
								    state_s <= s1;
                                    counter_s <= counter_s + 1;
                                    run_s <= 1;
                            
                                end if;                         
                         end case;
                    end if;         
                else 
					state_s<=s0;
					counter_s <= (others => '0);
					run_s <= "0";
                 end if;
            end if;
    end process;

    -- output signal proce_iss
    outputs: process(clk_i, rst_i)
    begin
		if rst='1' then
			len_o<=(others=>'0');
			run_s<='0';
			valid_i<='0';
			eol_o<='0';
		elsif(rising_edge(clk))then
			if valid_i='0' then
				valid_i<='0';
			else
				if eol_i='1' then
					len_o<=std_logic_vector(counter);
					run_s<=run_reg;
					valid_i<='1';
					eol_o<='1';
				else
				case state is
					whens0=>
					if pixel_i='0' then
						len_o<=(others=>'0');
						run_s<=run_reg;
						valid_i<='0';
						eol_o<='0';
					else
						len_o<=std_logic_vector(counter);
						run_s<=run_reg;
						valid_i<='1';
						eol_o<='0';
					end if;
				when s1=>
					if pixel_i='0' then
						len_o<=std_logic_vector(counter);
						run_s<=run_reg;
						valid_i<='1';
						eol_o<='0';
					else len_o<=(others=>'0');
						run_s<='0';
						valid_i<='0';
						eol_o<='0';
					end if;
				end case;--case state
			end if;--eol_i= '1'
		end if;--valid_1 = '1'
	end if;--rst= '1'
end process;

end Behavioral;



















