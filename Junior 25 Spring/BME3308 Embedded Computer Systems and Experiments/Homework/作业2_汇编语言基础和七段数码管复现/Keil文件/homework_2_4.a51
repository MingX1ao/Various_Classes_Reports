ORG 0000H
               AJMP START
               ORG 0040H
START:   	   MOV P0, #00H
TEST:     	   MOV P2, #0FFH
               CLR P2.3
               JNB P2.2, NUM1
               JNB P2.1, NUM2
               JNB P2.0, NUM3
               SETB P2.3
               CLR P2.4
               JNB P2.2, NUM4
               JNB P2.1, NUM5
               JNB P2.0, NUM6
               SETB P2.4
               CLR P2.5
               JNB P2.2, NUM7
               JNB P2.1, NUM8
               JNB P2.0, NUM9
               SETB P2.5
               CLR P2.6
               JNB P2.1, NUM0
               SETB P2.6
               SJMP TEST
			   
NUM0:     MOV P0,#3FH
                SJMP TEST
NUM1:     MOV P0,#06H
                SJMP TEST         
NUM2:     MOV P0,#5BH
                SJMP TEST
NUM3:     MOV P0,#4FH
                SJMP TEST
NUM4:     MOV P0,#66H
                SJMP TEST
NUM5:     MOV P0,#6DH
                SJMP TEST
NUM6:     MOV P0,#7DH
                SJMP TEST
NUM7:     MOV P0,#07H
                SJMP TEST
NUM8:     MOV P0,#7FH
                SJMP TEST
NUM9:     MOV P0,#6FH
                SJMP TEST
END
