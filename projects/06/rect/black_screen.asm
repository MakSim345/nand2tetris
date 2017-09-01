//; BLack whole screen
//; 
   
   @8192     //; move number to accumulator
   D=A      //; save number to DATA register
   @R0      //; select address of R0
   M=D      //; store to a value from DATA register to R0

   @R0 //; select R0, first data MEMORY cell
   D=M //; save value from R0 to DATA register

   @APPLICATION_END //; check if number of lines to draw less than 0
   D;JLE           //; application end  

   @counter //; create variable "counter"
   M=D      //; save there value from DATA register: 

   @SCREEN  //; define SCREEN = 16384
   D=A      //; save SCREEN to DATA register 

   @address //; create variable "address"
   M=D      //; save there a value from DATA register (SCREEN)

(LOOP)
   @address //; select variable "address" (SCREEN)
   A=M      //; copy value of "address" to ADDRESS register
   M=-1     //; save (1111111111111111) to memory pointed by ADDRESS register

   @address //; select variable "address" (SCREEN)
   D=M      //; save value of "address" to DATA register

   @1       //; move number 32 to accumulator
   D=D+A    //; add 32 to DATA register and save to DATA register 

   @address //; select address of variable "address" (SCREEN)
   M=D      //; store to variable "address" a value from DATA register

   @counter //; select address of variable "counter"
   MD=M-1   //; decrement value od variable "counter" and save it to MEMORY and DATA registers

   @LOOP    //; take address of LOOP in case loop is over.
   D;JGT    //; if value in DATA register greater than ZERO, goto LOOP

(APPLICATION_END)
   @APPLICATION_END
   0;JMP
