--------------------------------------------------------
--  Arquivo criado - segunda-feira-maio-26-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure STP_PESSOAS_UPD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "SYSTEM"."STP_PESSOAS_UPD" (
    p_Id              IN NUMBER,
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
    aux NUMBER;
BEGIN  
    
    IF p_Id IS NULL THEN
        p_CodigoRetorno := -1;
        p_Mensagem := 'ID não pode ser nulo.';
        RETURN;
    END IF;

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
    
    BEGIN
        SELECT 1 INTO aux FROM Pessoa WHERE id = p_Id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_CodigoRetorno := -1;
            p_Mensagem := 'Id não encontrado.';
            RETURN;
    END;

     UPDATE Pessoa SET 
        Nome            = p_Nome,              
        Cidade          = p_Cidade,
        Email           = p_Email,
        Cep             = p_Cep,
        Endereco       = p_Endereco,
        Pais            = p_Pais,
        Usuario         = p_Usuario,
        Telefone        = p_Telefone,
        Data_Nascimento = p_Data_Nascimento,
        Cargo_Id        = p_Cargo_Id
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
