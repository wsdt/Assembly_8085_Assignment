MVI B, 0AH ; value to search in S[]
MVI C, 8 ; count of values in S[] = also HIGH
MVI A, 00H ; min
STA 0021H ; save min in mem
;MVI D, 00H ; initialize with 0 
LXI H, 0000H

LOOP: XRA A
LDA 0021H
ADD C ; add max
RRC ; /2 ; get mid in A
STA 0010H ; save mid 
;MOV E, A ; get into E to load val from mem
MOV L, A
;LDAX D
MOV A, M
CMP B ; compare with X
JZ found ; val found
JNC newhigh ; x (=B) < S[mid] (=A)
LDA 0010H ; get mid
INR A; mid + 1
STA 0021H
JMP LOOP
newhigh: LDA 0010H
DCR A ; mid - 1
MOV C, A ; high = mid - 1
JMP LOOP
found: HLT ; SOLUTION IN E (LOCATION)







