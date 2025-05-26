--------------------------------------------------------
--  Arquivo criado - segunda-feira-maio-26-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure STP_PESSOAS_DEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "SYSTEM"."STP_PESSOAS_DEL" (
    p_Id              IN NUMBER,
    p_CodigoRetorno   OUT NUMBER,
    p_Mensagem        OUT VARCHAR2)
AS
    aux NUMBER;
BEGIN  

    BEGIN
        SELECT 1 INTO aux FROM Pessoa WHERE id = p_Id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_CodigoRetorno := -1;
            p_Mensagem := 'Id não encontrado.';
            RETURN;
    END;

     DELETE Pessoa
     WHERE Id = p_Id;

    p_CodigoRetorno := 0;
    p_Mensagem := 'Operação realizada com sucesso';

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN

    ROLLBACK;
        p_CodigoRetorno := -1;
        p_Mensagem := 'Erro ao tentar cadastrar : ' || SUBSTR(SQLERRM, 1, 400);

END;

/
