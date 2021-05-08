library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all; 


ENTITY TEXT_DISPLAY is 
	PORT(
		enable: IN STD_LOGIC;
		clock_25Mhz : IN STD_LOGIC;
		pixel_row, pixel_column: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		ones_score, tens_score :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		state_out: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		char_data_out : OUT STD_LOGIC;
		sw0 : IN STD_LOGIC
	 --  level : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	  );
END ENTITY TEXT_DISPLAY;

ARCHITECTURE BEHAVIOUR of TEXT_DISPLAY is
	
	COMPONENT char_rom
		PORT 
			(
				character_address	:	IN STD_LOGIC_VECTOR (5 DOWNTO 0);
				font_row, font_column	:	IN STD_LOGIC_VECTOR (2 DOWNTO 0);
				clock				: 	IN STD_LOGIC ;
				rom_mux_output		:OUT STD_LOGIC
			);
		end component;
		signal select_font_row, select_font_col : STD_LOGIC_VECTOR (2 DOWNTO 0);
		signal character_address : STD_LOGIC_VECTOR (5 DOWNTO 0);
		signal char_data_int : STD_LOGIC;
		
	begin
	
		char_data:char_rom PORT MAP(
			character_address=> character_address,
			font_row=> select_font_row,font_column => select_font_col,
			clock=>clock_25Mhz,
			rom_mux_output=>char_data_int
		);

		  character_address <= "010011" when ((pixel_column <= CONV_STD_LOGIC_VECTOR((304,10))) AND (pixel_column >= CONV_STD_LOGIC_VECTOR(288, 10)) AND(pixel_row >= CONV_STD_LOGIC_VECTOR((320,10)))AND(pixel_row <= CONV_STD_LOGIC_VECTOR((335,10))))--S
			else "000011" when ((pixel_column <= CONV_STD_LOGIC_VECTOR((320,10)))AND (pixel_column >= CONV_STD_LOGIC_VECTOR(304, 10)) AND(pixel_row >= CONV_STD_LOGIC_VECTOR((320,10)))AND(pixel_row <= CONV_STD_LOGIC_VECTOR((335,10))))--C
			else "001111" when ((pixel_column <= CONV_STD_LOGIC_VECTOR((336,10)))AND (pixel_column >= CONV_STD_LOGIC_VECTOR(320, 10))AND(pixel_row >= CONV_STD_LOGIC_VECTOR((320,10)))AND(pixel_row <= CONV_STD_LOGIC_VECTOR((335,10))))--O
			else "010010" when ((pixel_column <= CONV_STD_LOGIC_VECTOR((352,10)))AND (pixel_column >= CONV_STD_LOGIC_VECTOR(336, 10)) AND(pixel_row >= CONV_STD_LOGIC_VECTOR((320,10)))AND(pixel_row <= CONV_STD_LOGIC_VECTOR((335,10))))--R
			else "100000" when ((pixel_column <= CONV_STD_LOGIC_VECTOR((368,10))) AND (pixel_column >= CONV_STD_LOGIC_VECTOR(352, 10))AND(pixel_row >= CONV_STD_LOGIC_VECTOR((320,10)))AND(pixel_row <= CONV_STD_LOGIC_VECTOR((335,10))))--E	

			;
			
			
			
		select_font_row<=pixel_row(3 downto 1);
		select_font_col<=pixel_column (3 downto 1);
	        char_data_out<= '0' when ((pixel_row)<= CONV_STD_LOGIC_VECTOR((0,10)) OR ((pixel_row)<= CONV_STD_LOGIC_VECTOR((448,10))) OR(pixel_column)>= CONV_STD_LOGIC_VECTOR((450,10))) --recheck
			else char_data_int;
END ARCHITECTURE;
