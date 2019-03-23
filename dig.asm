LDA 0030H ; =x, address of value to search
MOV B, A 
MVI A, 0 ; low
STA 0023H ; address of iteration number
MOV L, A 
MVI A, 9 ; high
MOV H, A ; store high/low in H/L done
loop: LDA 0023H ; load iteration number
INR A
STA 0023H ; store back
MOV A, H ; store high in A
CMP L ; compare lower index
JC endloop ; high is less than low
ADD L
RAR ; divide /2 (mid)
MOV C, A
JNC reset
CMC ; complement carry
reset: NOP ; no operation, one cycle
LXI D, 0021H ; address into D/E
ADD E ; add mid for offset
MOV E, A ; get changed address back to have a pointer
MVI A, 0 ; reset
ADC D ; add with carry
MOV D, A ; handle mem. index
LDAX D ; array elem in A
CMP B ; compare value to search
JC else ; value bigger than mid (low=mid+1)
JZ print ; elem found
MOV A, C ; not executed (val<mid)
DCR A ; mid = mid-1
MOV H, A ; h=mid
JMP loop
print: MVI A, 1
STA 0020H ; indicate success with 1
else: MOV A, C ; move index (mid) to A
STA 0201H 
JMP end
endloop: MVI A, 2
STA 0200H ; indicate error with 2
end: HLT