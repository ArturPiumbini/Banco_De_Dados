SET SERVEROUTPUT ON;

DECLARE
CTRL NUMBER;
NUMERO NUMBER := 5;
TOTAL NUMBER;

BEGIN
    DBMS_OUTPUT.PUT_LINE(NUMERO||'! :');
    IF NUMERO < 0
        THEN DBMS_OUTPUT.PUT_LINE('ERRO NUMERO NEGATIVO');
        ELSE
            IF NUMERO = 0
                THEN TOTAL := 1;
                ELSE CTRL := NUMERO -1;
                    TOTAL := NUMERO;
                    WHILE CTRL > 0 LOOP
                        TOTAL := TOTAL * CTRL;
                        CTRL := CTRL -1;
                    END LOOP;
            END IF;
            DBMS_OUTPUT.PUT_LINE(TOTAL);
    END IF;
END;
/
CLEAR SCREEN;


CREATE OR REPLACE PROCEDURE PR_PA_PG(TIPO CHAR, VLI NUMBER, ICR NUMBER, QTD NUMBER)
AS
TOTAL NUMBER;
BEGIN
    IF UPPER(TIPO) = 'PA'
        THEN DBMS_OUTPUT.PUT_LINE('PA');
            TOTAL := VLI;
            FOR X IN 1 .. QTD LOOP
                DBMS_OUTPUT.PUT(TOTAL||' ');
                TOTAL := TOTAL + ICR;
            END LOOP;
        ELSE DBMS_OUTPUT.PUT_LINE('PG');
            TOTAL := VLI;
            FOR X IN 1 .. QTD LOOP
                DBMS_OUTPUT.PUT(TOTAL||' ');
                TOTAL := TOTAL * ICR;
            END LOOP;
    END IF;
    DBMS_OUTPUT.PUT_LINE('');
END;
/

CLEAR SCREEN;
CALL PR_PA_PG('PA', 1, 2, 5);