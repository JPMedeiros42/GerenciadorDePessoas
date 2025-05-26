--------------------------------------------------------
--  Arquivo criado - segunda-feira-maio-26-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure STP_PESSOAS_INS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "SYSTEM"."STP_PESSOAS_INS" (
    p_Nome            IN VARCHAR2,
    p_Cidade          IN VARCHAR2,
    p_Email           IN VARCHAR2,
    p_Cep             IN VARCHAR2,
    p_Endereco        IN VARCHAR2,
    p_Pais            IN VARCHAR2,
    p_Usuario         IN VARCHAR2,
    p_Telefone        IN VARCHAR2,
    p_Data_Nascimento IN DATE,
    p_Cargo_Id        IN NUMBER,
    p_CodigoRetorno   OUT NUMBER,
    p_Mensagem        OUT VARCHAR2)
AS
BEGIN  

    IF p_Nome IS NULL OR TRIM(p_Nome) = '' THEN
        p_CodigoRetorno := -1;
        p_Mensagem := 'Nome inválido.';
        RETURN;
    END IF;

    IF p_Email IS NULL OR TRIM(p_Email) = '' THEN
        p_CodigoRetorno := -1;
        p_Mensagem := 'Email inválido.';
        RETURN;
    END IF;
    
    IF p_Data_Nascimento IS NULL THEN
        p_CodigoRetorno := -1;
        p_Mensagem := 'Data de nascimento inválida.';
        RETURN;
    END IF;
    
    IF p_Cidade IS NULL OR TRIM(p_Cidade) = '' THEN
        p_CodigoRetorno := -1;
        p_Mensagem := 'Cidade inválida.';
        RETURN;
    END IF;
    
     IF p_Pais IS NULL OR TRIM(p_Pais) = '' THEN
        p_CodigoRetorno := -1;
        p_Mensagem := 'País inválido.';
        RETURN;
    END IF;
    
    IF p_Cargo_Id IS NULL OR p_Cargo_Id <= 0 THEN
        p_CodigoRetorno := -1;
        p_Mensagem := 'Cargo inválido.';
        RETURN;
    END IF;

     INSERT INTO Pessoa (
        Nome, 
        Cidade,
        Email, 
        Cep,
        Endereco,
        Pais, 
        Usuario, 
        Telefone,
        Data_Nascimento, 
        Cargo_Id)
    VALUES ( 
        p_Nome,
        p_Cidade,
        p_Email, 
        p_Cep,
        p_Endereco, 
        p_Pais, 
        p_Usuario, 
        p_Telefone,
        p_Data_Nascimento,
        p_Cargo_Id);

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
