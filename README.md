# VHDL Guessing Game (Artix-7 family Nexys 4 FPGA)
Creator: Ben Mighall

This program is a simple guessing game; switches 2, 1, and 0 indicate a binary number that is translated into the first hexadecimal digit shown on the seven-segment display. The display is "clocked" by a button- one press moves it between your guess and the number you were trying to guess using the switches. 

Note: This program may require you to slightly alter the constraints file to suppress warnings about clock in order to run it. 
The easiest way to do it: if you're using Vivado, just copy and paste the suppression code they give you into the constraints file after you do synthesis/implementation.

