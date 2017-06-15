    //setup outer loop
    @256
    D=A
    @maxRows
    M=D
    @rows
    M=0
    @currentRow
    M=0

    (CHECK)
    @KBD
    D=M
    @OUTER
    D;JNE
    @CHECK
    0;JMP

    (OUTER)
    //check rows
    @rows
    D=M
    @maxRows
    D=D-M
    //go to @END if @rows ≥ 0
    @CHECK
    D;JGE
    //inner loop
    //setup inner loop
    @32
    D=A
    @maxCols
    M=D
    @cols
    M=0

    (INNER)
    //check cols
    @cols
    D=M
    @maxCols
    D=D-M
    //go to @SLOC if @cols ≥ 0
    @SLOC
    D;JGE
    //set screen pointer
    @currentRow
    D=M
    @cols
    D=D+M
    @SCREEN
    D=D+A
    A=D
    //fill pixels
    M=-1
    //increment
    @cols
    M=M+1
    @INNER
    0;JMP

    (SLOC)
    @32
    D=A
    @currentRow
    M=M+D
    @rows
    M=M+1
    @OUTER
    0;JMP

    (END)
    @END
    0;JMP
