ORG 100H
.MODEL SMALL
.STACK 100H
.DATA

X DB 0   
op DB 0
Y DB 2h
SUM DB 0
RES DB 0
str DB 13,10, ' QUE OPERACION DESEA REALIZAR $'

MSG1 DB 13,10,' ESCRIBE UN NUMERO DEL 0 AL 9: $'
MSG2 DB 13,10,' (1) SUMA  $'
MSG3 DB 13,10,' (2) RESTA  $'
MSG4 DB 13,10,' LA SUMA ES: $'
MSG5 DB 13,10,' LA RESTA ES: $'
MSG7 DB 13,10,' ESCRIBE la opcion  $'
               
.CODE
INICIO:
MOV AX, @DATA
MOV DS, AX

LEA DX, MSG1
MOV AH, 09H
INT 21H       ;imprime texto ESCRIBE UN NUMERO DEL 0 AL 9
MOV AH, 01H
INT 21H       ;lee el dato y guarda en AL
SUB AL, 30H   ;restar (30H) para ajustar el dato

MOV BL, AL
SHL BL, 4  
MOV AH, 01H
INT 21H
SUB AL, 30H       ;lee el dato y guarda en AL
ADD BL, AL

MOV X, BL     ;guarda el dato en "X"
 
XOR BL,BL
LEA DX, MSG1
MOV AH, 09H
INT 21H       ;imprime texto ESCRIBE UN NUMERO DEL 0 AL 9
MOV AH, 01H
INT 21H       ;lee el dato y guarda en AL 
SUB AL, 30H   ;restar (30H) para ajustar el dato

MOV BL, AL
SHL BL, 4  
MOV AH, 01
INT 21H   
SUB AL, 30H
ADD BL, AL

MOV Y, BL     ;guarda el dato en "Y"
         
LEA DX, MSG2
MOV AH, 09H
INT 21H      ;impime msg ((1)suma)

LEA DX, MSG3
MOV AH, 09H
INT 21H      ;impime msg ((2)resta)

LEA DX, str
MOV AH, 09H
INT 21H

LEA DX, MSG7
MOV AH, 09H
INT 21H       ;imprime texto ESCRIBE opcion
MOV AH, 01H
INT 21H       ;lee la opcion y guarda en AL
SUB AL, 30H   ;restar (30H) para ajustar el dato
MOV op, AL     ;guarda el dato en "op"

CMP op,01     ;compara DL con 01 (para hacer la suma)
JE suma       ;salto si los operandos son iguales (JE suma) 



CMP op,02     ;compara DL con 02 (para hacer la resta)
JE resta      ;salto si los operandos son iguales (JE resta)


SUMA:       ;etiqueta suma
MOV DL, X
ADD DL, Y    ;suma op1 con op2
XOR DH,DH
ROL DX, 4
SHR DL, 4
ADD DH, 30H
ADD DL, 30H
MOV X, DL
MOV Y, DH
LEA DX, MSG4 ;carga msj de "la suma es" (LEA DX,msj") Y lo despliega por pantalla
MOV AH, 09H   ;mueve el resultado a DL                                                         
INT 21H

MOV DL, Y       
MOV AH, 02H   ;imprime el valor resulyado por pantalla
INT 21H

MOV DL, X
MOV AH, 02H   ;imprime el valor resulyado por pantalla
INT 21H
JMP FIN

RESTA:
MOV DL, X
SUB DL, Y
XOR DH, DH
ROL DX, 4
SHR DL, 4
ADD DH, 30H
ADD DL, 30H
MOV X, DL
MOV Y, DH
LEA DX, MSG5
MOV AH, 09H
INT 21H

MOV DL, Y
MOV AH, 02H
INT 21H

MOV DL, X
MOV AH, 02H
INT 21H
JMP FIN
FIN:
MOV AH, 4CH
INT 21H
END INICIO