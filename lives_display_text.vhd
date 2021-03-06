library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_SIGNED.all; 
use IEEE.NUMERIC_STD.all; 




ENTITY lives_display is 
	PORT(
		clock_25Mhz : IN STD_LOGIC;
		pixel_row, pixel_column: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		lives:IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		gameState : in std_LOGIC_VECTOR(1 DOWNTO 0);
		over_text_on : OUT STD_LOGIC;
		output_text : OUT STD_LOGIC	
	  );
END ENTITY lives_display;



ARCHITECTURE BEHAVIOUR of lives_display is

	COMPONENT char_rom
		PORT 
			(
				character_address	:	IN STD_LOGIC_VECTOR (5 DOWNTO 0);
				font_row, font_col	:	IN STD_LOGIC_VECTOR (2 DOWNTO 0);
				clock				: 	IN STD_LOGIC ;
				rom_mux_output		:OUT STD_LOGIC
			);
			
	end COMPONENT;

	SIGNAL lives_display : std_logic_vector(5 downto 0);
	SIGNAL output_score  : STD_LOGIC := '0';
 
	
	

BEGIN							
--
--		over_text_on <= '1' when (output_score = '1' and pixel_column <= CONV_STD_LOGIC_VECTOR(335,10) and pixel_column >= CONV_STD_LOGIC_VECTOR(320,10) 
--		and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10)) and gameState = "00" else'0';

		over_text_on <= '1' when (output_score = '1' and pixel_column <= CONV_STD_LOGIC_VECTOR(385,10) and pixel_column >= CONV_STD_LOGIC_VECTOR(305,10) 
		and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10)) else'0';
		
		
	lives_display <= 
					CONV_STD_LOGIC_VECTOR(12,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(321,10) else --"L"
					CONV_STD_LOGIC_VECTOR(9,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(337,10) else --"I"
					CONV_STD_LOGIC_VECTOR(22,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(353,10) else --"V"
					CONV_STD_LOGIC_VECTOR(5,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(369,10) else --"E"
					CONV_STD_LOGIC_VECTOR(19,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(385,10)else --"S"
					lives when pixel_column <= CONV_STD_LOGIC_VECTOR(102,10) else				--"number of lives"
					
					

	-- number of lives
					CONV_STD_LOGIC_VECTOR(48,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(446,10) AND lives = "110000" else --"0"
					CONV_STD_LOGIC_VECTOR(49,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(446,10) AND lives = "110001" else --"1"
			      CONV_STD_LOGIC_VECTOR(50,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(446,10) AND lives = "110010" else --"2"
					CONV_STD_LOGIC_VECTOR(51,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(446,10) AND lives = "110011"  --"3"

					
						;
					
		
		scoretext : char_rom PORT MAP(
							character_address => lives_display,
							font_row=>pixel_row(3 downto 1),
							font_col=>pixel_column(3 downto 1),
							clock => clock_25Mhz,
							rom_mux_output =>output_score
							);

	output_text <= output_score;

END ARCHITECTURE;
