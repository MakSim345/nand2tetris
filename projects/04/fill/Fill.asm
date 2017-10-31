//; This file is part of www.nand2tetris.org
//; and the book "The Elements of Computing Systems"
//; by Nisan and Schocken, MIT Press.
//; File name: projects/04/Fill.asm

//; Runs an infinite loop that listens to the keyboard input. 
//; When a key is pressed (any key), the program blackens the screen,
//; i.e. writes "black" in every pixel. When no key is pressed, the
//; program clears the screen, i.e. writes "white" in every pixel.

//; BLack whole screen
   
   @status  //; create variable "status" 
   M=0     //; save to "status" value 0xFFFF

   
(LOOP)
   @SCREEN  //; define SCREEN = 16384
   D=A      //; save SCREEN to DATA register
   @scr_ptr //; create variable "screen pointer"
   M=D      //; save there a value from DATA register (SCREEN) 

   @8192    //; move number to accumulator (512 lines of 32 bit - a screen)
   //; @31
   D=A      //; save number from accumulator to DATA register   
   @counter //; create variable "counter"
   M=D      //; save there value from DATA register: 8192
    
   D=0         //; Argument - what to set screen bits to 
   @KBD
   D=M      //; D = current keyboard character
   @SETSCREEN
   D;JEQ    //; If no key, set screen to zeroes (white)
   D=-1     //; elseif key pressed, set screen to all 1 bits (black)

(SETSCREEN) //; Set D=new_status before jumping here
   @ARG
   M=D      //; Save new_status to ARG
   @status     //; FFFF=black, 0=white - status of entire screen
   D=D-M       //; D=newstatus-status
   @LOOP       //; GOTO LOOP
   D;JEQ       //; Do nothing if new status == old status

   //; load ARG to variable "status"
   @ARG
   D=M
   @status
   M=D         //; status = ARG

(DRAW_LOOP)
   @status
   D=M         //; D=status
   @scr_ptr //; select variable "scr_ptr" (SCREEN)
   A=M      //; copy value of "scr_ptr" to ADDRESS register
   //; M=-1  //; save (FFFF) to memory pointed by ADDRESS register   
   M=D         //; M[current screen address]=status

   @scr_ptr //; select variable "scr_ptr" (SCREEN)
   D=M      //; save value of "scr_ptr" to DATA register

   @1       //; load 1 to accumulator
   D=D+A    //; add 1 to DATA register and save to DATA register 
   @scr_ptr //; select address of variable "scr_ptr" (SCREEN)
   M=D      //; store to variable "scr_ptr" a value from DATA register

   @counter //; select memory address of variable "counter"
   MD=M-1   //; decrement value of variable "counter" 
            //; and save it to MEMORY and DATA registers

   @DRAW_LOOP //; take address of SETSCREEN in case loop is over.
   D;JGT      //; if value in DATA register greater than ZERO
              //; goto SETSCREEN

   @LOOP
   0;JMP

(APPLICATION_END)
   @APPLICATION_END
   0;JMP

