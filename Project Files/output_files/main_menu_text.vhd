library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_SIGNED.all; 
use IEEE.NUMERIC_STD.all; 



ENTITY main_menu_display is 
	PORT(
		clock_25Mhz : IN STD_LOGIC;
		pixel_row, pixel_column: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		ones_score, tens_score:IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		gameState : in std_LOGIC_VECTOR(1 DOWNTO 0);
		over_text_on : OUT STD_LOGIC;
		output_text : OUT STD_LOGIC	
	  );
END ENTITY main_menu_display;



ARCHITECTURE BEHAVIOUR of main_menu_display is

	COMPONENT char_rom
		PORT 
			(
				character_address	:	IN STD_LOGIC_VECTOR (5 DOWNTO 0);
				font_row, font_col	:	IN STD_LOGIC_VECTOR (2 DOWNTO 0);
				clock				: 	IN STD_LOGIC ;
				rom_mux_output		:OUT STD_LOGIC
			);
			
	end COMPONENT;

	SIGNAL score_display : std_logic_vector(5 downto 0);
	SIGNAL output_score  : STD_LOGIC := '0';
	SIGNAL main_menu_display : std_logic_vector(5 downto 0); 
 
	
BEGIN							

--START GAME OVER TEXT--
		over_text_on <= '1' when (output_score = '1' and pixel_column <= CONV_STD_LOGIC_VECTOR(463,10) and pixel_column >= CONV_STD_LOGIC_VECTOR(239,10) 
		and pixel_row <= CONV_STD_LOGIC_VECTOR(300,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10)) else'0';

--START GAME DISPLAY TEXT--	
		main_menu_display <= 
				
					--"START GAME"--
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(255,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"space"
					CONV_STD_LOGIC_VECTOR(19,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(271,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"S"
					CONV_STD_LOGIC_VECTOR(20,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(287,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"T"
					CONV_STD_LOGIC_VECTOR(1,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(303,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"A"
					CONV_STD_LOGIC_VECTOR(18,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(319,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"R"
					CONV_STD_LOGIC_VECTOR(20,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(335,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"T"					
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(351,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"space"
					CONV_STD_LOGIC_VECTOR(7,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(367,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"G"
					CONV_STD_LOGIC_VECTOR(1,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(383,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"A"
					CONV_STD_LOGIC_VECTOR(13,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(399,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"M"
					CONV_STD_LOGIC_VECTOR(5,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(415,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"E"
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(431,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"space"
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(447,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"space"
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(463,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(45,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(30,10) else --"space"
					
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_row <= CONV_STD_LOGIC_VECTOR(205,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(45,10) else --"space"
					
					--"TRAINING MODE"--
					CONV_STD_LOGIC_VECTOR(20,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(255,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"T"
					CONV_STD_LOGIC_VECTOR(18,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(271,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"R"
					CONV_STD_LOGIC_VECTOR(1,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(287,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"A"
					CONV_STD_LOGIC_VECTOR(9,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(301,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"I"
					CONV_STD_LOGIC_VECTOR(14,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(319,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"N"					
					CONV_STD_LOGIC_VECTOR(9,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(335,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"I"
					CONV_STD_LOGIC_VECTOR(14,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(351,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"N"
					CONV_STD_LOGIC_VECTOR(7,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(367,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"G"
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(383,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"space"
					CONV_STD_LOGIC_VECTOR(13,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(399,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"M" 
					CONV_STD_LOGIC_VECTOR(15,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(415,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"O"
					CONV_STD_LOGIC_VECTOR(4,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(431,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"D"
					CONV_STD_LOGIC_VECTOR(5,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(447,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"E"	
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(463,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(221,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(205,10) else --"space"

					CONV_STD_LOGIC_VECTOR(32,6) when pixel_row <= CONV_STD_LOGIC_VECTOR(255,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(221,10) else --"space"					
					
					--"GAME MODE"--
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(255,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"space"
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(271,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"space"
					CONV_STD_LOGIC_VECTOR(7,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(287,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"G"
					CONV_STD_LOGIC_VECTOR(1,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(303,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"A"
					CONV_STD_LOGIC_VECTOR(13,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(319,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"M"
					CONV_STD_LOGIC_VECTOR(5,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(335,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"E"
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(351,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"space"					
					CONV_STD_LOGIC_VECTOR(13,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(367,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"M"
					CONV_STD_LOGIC_VECTOR(15,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(383,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"O"
					CONV_STD_LOGIC_VECTOR(4,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(399,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"D"
					CONV_STD_LOGIC_VECTOR(5,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(415,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"E"
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(431,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"space" 
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(447,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"space"
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(463,10) and pixel_row <= CONV_STD_LOGIC_VECTOR(270,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(255,10) else --"space"
				
					CONV_STD_LOGIC_VECTOR(32,6) when pixel_row <= CONV_STD_LOGIC_VECTOR(300,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(270,10) --"space"
				;
	
		scoretext : char_rom PORT MAP(
							character_address => main_menu_display,
							font_row=>pixel_row(3 downto 1),
							font_col=>pixel_column(3 downto 1),
							clock => clock_25Mhz,
							rom_mux_output =>output_score
							);

	output_text <= output_score;

END ARCHITECTURE;