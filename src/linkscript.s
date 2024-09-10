*
*  linkscript.asm
*  Merlin32 Cross Compiler
*
*  Created by John Newcombe on 21/08/24.

    typ $06         ; file type (06=bin, FF=sys)
    dsk rocket      ; name of binary file
    org $0200       ;

    asm rocket.s
    sna rocket     ; segment name

