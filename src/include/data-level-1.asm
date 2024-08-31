METEOR_UP   EQU %01100011
METEOR_DN   EQU %01011100

            ; Alphabet
            ; TODO add a specific clear screen function

            ; data in groups of 6
            DB LSPC,LSPC,LSPC,LSPC,LSPC
DATAROCK    DB METEOR_DN
            DB LSPC,LSPC,LSPC,LSPC,LSPC
            DB DATATERM

