----------------------------------------------------------------------------------
-- Company: IPVS
-- Developer: Levindo Gabriel Taschetto Neto 
-- 
-- Create Date: 04.07.2017 20:33:08
-- Design Name: 
-- Module Name: run_length_encoder - Behavioral
-- Project Name: Run Length Encoder
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
        symbol_i    : in STD_LOGIC_VECTOR(11 downto 0);                         -- input from -2048 to 2048.
        eol_i       : in STD_LOGIC;                         -- notify the end of row.
        -- output signals
        len_o       : out STD_LOGIC_VECTOR(3 downto 0);        -- the number of leading zeros can be up to 15.
        run_o       : out STD_LOGIC_VECTOR(11 downto 0);                        -- run code, either 0: white, 1: black
        valid_o     : out STD_LOGIC;                        -- run length code is valid or not.
        eol_o       : out STD_LOGIC                         -- indicate the end of row data.
    );
end run_length_encoder;

architecture Behavioral of run_length_encoder is
	-- Internal signals
	type      state_t is (s0, s1, s2);
	signal    state_s       : state_t;
	signal    counter_s     : unsigned (len_o'range);
	signal    run_s         : std_logic_vector(symbol_i'range);
	signal    is_zero_s     : std_logic;
	signal    eol_s         : std_logic;
	signal    is_overflow_s : std_logic;
	signal    inc_s         : std_logic;
	signal    send_s        : std_logic;
	 
	-- constant valudes
	constant   init_value  : unsigned(len_o'range) := to_unsigned(1,len_o'length);
	constant   zeros_c     : std_logic_vector(symbol_i'range) := (others => '0');
begin

    -- Datapath
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            counter_s <= (others => '0');
            run_o  <= (others => '0');
            len_o  <= (others => '0');
        elsif (rising_edge(clk_i)) then
            if ce_i = '1' then
                run_s <= symbol_i;
                eol_s <= eol_i;
                eol_o <= eol_s;
                -- Handle output
                if eol_i = '1' and valid_i = '1' then
                    len_o     <=  std_logic_vector(counter_s);
                    run_o     <=  run_s; 
                    valid_o   <=  '1';
                    counter_s <= (others => '0');       
                elsif send_s = '1' then
                    len_o     <=  std_logic_vector(counter_s);
                    run_o     <=  run_s; 
                    valid_o   <=  '1';
                    counter_s <= (others => '0');
                else
                    valid_o   <=  '0';
                    if inc_s = '1' then
                        counter_s <= counter_s + 1;
                    end if;
                end if;
            end if;  -- if ce_i = '1'
        end if;  -- if rst_i='1'.
    end process;
    
    process( counter_s, symbol_i )
    begin
        if symbol_i /= zeros_c then
            is_zero_s <= '0';
        else
            is_zero_s <= '1';
        end if;
        
        if counter_s = 14 and symbol_i = zeros_c then
            is_overflow_s <='1';
        else
            is_overflow_s <='0';
        end if;
    end process;
   
    -- Controller
    process(clk_i, rst_i)
    begin
        if rst_i='1' then -- reset=1 -> start=0
              state_s<=s0;
        elsif (clk_i'event and clk_i='1') then -- Clock rising up
            if eol_i='1' or valid_i='0' then -- Now it'll be sincronized
                state_s<=s0;
            else -- FSM's initialization
                case state_s is
                    when s0 =>
                        if is_zero_s='0' or is_overflow_s='1' then
                            state_s <= s2;
                        else --  is_zero='1' or is_overflow='0'
                            state_s <= s1;
                        end if;
                    when s1 =>
                        if is_zero_s='0' or is_overflow_s='1' then
                            state_s <= s2;
                        else
                            state_s <= s1;
                        end if;
                    when s2 =>
                        if is_zero_s='1' and is_overflow_s='0' then
                            state_s <= s1;
                        else
                            state_s <= s2;
                        end if;
                end case;
             end if;
        end if;  
    end process;
    
    --process(state_s)
    --begin
      
    --end process;
    
end Behavioral;