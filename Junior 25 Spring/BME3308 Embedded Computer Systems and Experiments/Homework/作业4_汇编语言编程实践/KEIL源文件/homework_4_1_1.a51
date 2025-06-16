ORG 0000H
	LJMP prepare
	
ORG 0400H
	prepare:	MOV 20H, #04H
	LJMP start

org 1000h
start:mov dptr,#table
      mov a,20h
      movc a,@a+dptr
      mov 21h,a
      sjmp $;????
org 2000h
table:db 0,1,4,9,16,25
  
end
