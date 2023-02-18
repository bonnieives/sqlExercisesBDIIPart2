-- First of first, let's connect to sys as sysdba
connect sys/sys as sysdba;

-- Connect to Scott
CONNECT scott/tiger

SPOOL C:\BD2\project_part2_spool.txt
SELECT to_char(sysdate,'DD Month YYYY Day HH:MI"SS') FROM dual;


-- QUESTION 1

CREATE OR REPLACE FUNCTION proj2_q1 (num1 IN NUMBER, num2 IN NUMBER)
	RETURN NUMBER AS
		num_out NUMBER;
	BEGIN
		num_out := num1 * num2;
	RETURN num_out;
END;
/

SELECT proj2_q1(4,6) FROM dual;


-- QUESTION 2

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE proj2_q2 (numq1 IN NUMBER, numq2 IN NUMBER) AS
	prod NUMBER;
	BEGIN
		prod := proj2_q1(numq1,numq2);
		DBMS_OUTPUT.PUT_LINE('For a rectangle of size ' || numq1 || ' by ' || numq2 || ' the area is ' || prod ||'.');
	END;
/

EXEC proj2_q2(2,4)


-- QUESTION 3

CREATE OR REPLACE PROCEDURE proj2_q3 (numq1 IN NUMBER, numq2 IN NUMBER) AS
	prod NUMBER;
	BEGIN
		IF (numq1 = numq2) THEN
			DBMS_OUTPUT.PUT_LINE('Square!');
		ELSE
			prod := proj2_q1(numq1,numq2);
			DBMS_OUTPUT.PUT_LINE('For a rectangle of size ' || numq1 || ' by ' || numq2 || ' the area is ' || prod ||'.');
		END IF;
	END;
/

EXEC proj2_q3(4,4)


-- QUESTION 4

CREATE OR REPLACE PROCEDURE proj2_q4 (amount IN NUMBER, curr IN VARCHAR2) AS
	BEGIN
		IF (curr = 'E') THEN
			DBMS_OUTPUT.PUT_LINE('For ' || amount || ' dollars, you will have ' || ROUND((amount / 1.50),2) || ' euros.');
		ELSIF (curr = 'Y') THEN
			DBMS_OUTPUT.PUT_LINE('For ' || amount || ' dollars, you will have ' || ROUND((amount * 100),2) || ' yen.');
		ELSIF (curr = 'V') THEN
			DBMS_OUTPUT.PUT_LINE('For ' || amount || ' dollars, you will have ' || ROUND((amount * 10000),2) || ' Viet Nam DONG.');
		ELSIF (curr = 'Z') THEN
			DBMS_OUTPUT.PUT_LINE('For ' || amount || ' dollars, you will have ' || ROUND((amount * 1000000),2) || ' Endora ZIP.');
		END IF;
	END;
/

EXEC proj2_q4(35,'E')
EXEC proj2_q4(35,'Y')
EXEC proj2_q4(35,'V')
EXEC proj2_q4(35,'Z')


-- QUESTION 5

CREATE OR REPLACE FUNCTION yes_even (in_num IN NUMBER)
RETURN BOOLEAN AS
	out_num BOOLEAN := FALSE;
	test NUMBER;
	BEGIN
	test := MOD(in_num,2);
		IF (test = 0) THEN
			out_num := TRUE;
		END IF;
	RETURN out_num;
	END;
/


-- QUESTION 6

CREATE OR REPLACE PROCEDURE proj2_q6 (en_num IN NUMBER) AS
	BEGIN
		IF yes_even(en_num) THEN
			DBMS_OUTPUT.PUT_LINE('Number ' || en_num || ' is EVEN.');
		ELSE
			DBMS_OUTPUT.PUT_LINE('Number ' || en_num || ' is ODD.');
		END IF;
	END;
/

EXEC proj2_q6(35)

-- BONUS QUESTION

CREATE OR REPLACE PROCEDURE b_quest (amt IN NUMBER, curr1 IN VARCHAR2, curr2 IN VARCHAR2) AS
	conv1 NUMBER;
	conv2 NUMBER;
	name1 VARCHAR2(30);
	name2 VARCHAR2(30);
	BEGIN
		
		IF (curr1 = 'C') THEN
			conv1 := 1;
			name1 := 'canadian dolar';
		ELSIF (curr1 = 'E') THEN
			conv1 := 2/3;
			name1 := 'euro';
		ELSIF (curr1 = 'Y') THEN
			conv1 := 100;
			name1 := 'yen';
		ELSIF (curr1 = 'V') THEN
			conv1 := 10000;
			name1 := 'viet nam dong';
		ELSIF (curr1 = 'Z') THEN
			conv1 := 1000000;
			name1 := 'endora zip';
		END IF;

		IF (curr2 = 'C') THEN
			conv2 := 1;
			name2 := 'canadian dolar';
		ELSIF (curr2 = 'E') THEN
			conv2 := 2/3;
			name2 := 'euro';
		ELSIF (curr2 = 'Y') THEN
			conv2 := 100;
			name2 := 'yen';
		ELSIF (curr2 = 'V') THEN
			conv2 := 10000;
			name2 := 'viet nam dong';
		ELSIF (curr2 = 'Z') THEN
			conv2 := 1000000;
			name2 := 'endora zip';
		END IF;

		IF (conv1 != conv2) THEN
			DBMS_OUTPUT.PUT_LINE('For ' || amt || ' ' || name1 || ', you will have ' || ROUND(((amt*conv2) / conv1),2) || ' ' || name2 || '.');
		ELSE
			DBMS_OUTPUT.PUT_LINE('You choose the same currency.');
		END IF;
	END;
/

EXEC b_quest(100,'C','E')
EXEC b_quest(100,'E','C')
EXEC b_quest(100,'C','V')
EXEC b_quest(100,'V','Z')

SPOOL OFF
