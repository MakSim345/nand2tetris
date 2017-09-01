//;      for (i=0; i<n; i++)
//;      {
//;          arr[i] = -1
//;      }

    //; load 100 to DATA register:
    @100
    D=A

    @arr //; command @arr will take first free memory cell after R15
    M=D  //; MEMORY[16] is variable "arr" now

    //; create counter variable "n"
    @10
    D=A
    @n
    M=D

    //; create and initialize variable "index" = 0:
    @index
    M=0

(LOOP)
    // if (index == n) goto END
    @index
    D=M   //; put i to DATA register

    @n    //; select MEMORY[] where "n" stored
    D=D-M //; substract "n" from "i" and put result to DATA register

    @END
    D;JEQ  //; if (i - n == 0) then goto END

    @arr //; select MEMORY[arr]
    D=M  //; and copy it to DATA register

    @index //; select MEMORY[index] value. M=index
    A=D+M  //; calculate MEMORY where next array index located.
           //; D - array address, M - shift
    M = -1 //; put value to the array cell in MEMORY

    //; index++
    @index //;select MEMORY[index] value
    M=M+1  //; increment value in MEMORY[index]

    @LOOP //;goto LOOP
    0;JMP

(END)
    @END
    0;JMP

