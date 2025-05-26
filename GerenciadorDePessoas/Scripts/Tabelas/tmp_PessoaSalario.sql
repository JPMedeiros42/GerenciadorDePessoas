--------------------------------------------------------
--  Arquivo criado - segunda-feira-maio-26-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table TMP_PESSOASALARIO
--------------------------------------------------------

  CREATE GLOBAL TEMPORARY TABLE "SYSTEM"."TMP_PESSOASALARIO" 
   (	"PESSOA_ID" NUMBER(*,0), 
	"NOME" VARCHAR2(100 BYTE), 
	"SALARIO_BRUTO" NUMBER(10,2), 
	"DESCONTOS" NUMBER(10,2), 
	"SALARIO_LIQUIDO" NUMBER(10,2)
   ) ON COMMIT PRESERVE ROWS ;
REM INSERTING into SYSTEM.TMP_PESSOASALARIO
SET DEFINE OFF;
