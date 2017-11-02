//; This file is part of www.nand2tetris.org
//; and the book "The Elements of Computing Systems"
//; by Nisan and Schocken, MIT Press.
//; File name: projects/04/Mult.asm

//; Multiplies R0 and R1 and stores the result in R2.
//; (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[3], respectively.)

    @R2      //; select R0 address from memory
    M=0      //; R2 = 0
    @counter //; declare variable "counter"
    M=0      //; counter=0
(LOOP)
    @counter //; select "counter" address from MEMORY
    D=M      //; D = counter
    @R0      //; select R0 address from memory
    D=D-M    //; D = counter - R0
    @END
    D;JGE    //; if i-R0 >= 0 goto END

    @R1     //; select R1 address from memory
    D=M     //; copy R1 to D register
    @R2     //; M=R2, select R2 address from memory
    M=D+M   //; means R2 = R2 + R1

    @counter
    M=M+1   //; counter = counter + 1
    @LOOP
    0;JMP   //; Repeat
(END)
    @END
    0;JMP
