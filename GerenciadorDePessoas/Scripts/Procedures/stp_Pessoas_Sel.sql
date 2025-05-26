--------------------------------------------------------
--  Arquivo criado - segunda-feira-maio-26-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure STP_PESSOAS_SEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "SYSTEM"."STP_PESSOAS_SEL" (
    p_IdPessoa IN NUMBER DEFAULT NULL,
    p_CargoFiltro IN NUMBER DEFAULT NULL,
    p_NomeFiltro IN VARCHAR2 DEFAULT NULL,
    p_Resultado OUT SYS_REFCURSOR,
    p_CodigoRetorno OUT NUMBER,
    p_Mensagem OUT VARCHAR2
) IS
BEGIN
    

    Open p_Resultado FOR
        SELECT
            p.Id,
            p.Nome,
            c.Nome AS Cargo,
            p.Email,
            p.Telefone,
            p.data_nascimento AS DataNascimento,
            p.Pais,
            p.Cidade,
            p.Endereco,
            p.CEP,
            p.Usuario,
            p.cargo_id AS CargoID
        FROM Pessoa p
        INNER JOIN Cargo c ON p.Cargo_Id = c.id
        WHERE (p_CargoFiltro IS NULL OR p.Cargo_Id = p_CargoFiltro)
        AND (p_NomeFiltro IS NULL OR UPPER(p.Nome) LIKE '%' || UPPER(p_NomeFiltro) || '%')
        AND (p_IdPessoa IS NULL OR p_IdPessoa = p.id)
        ORDER BY p.Nome;
        
    p_CodigoRetorno := 0;
    p_Mensagem := 'Consulta realizada com sucesso';

EXCEPTION
    WHEN OTHERS THEN
        p_CodigoRetorno := -1;
        p_Mensagem := 'Erro ao consultar pessoas: ' || SQLERRM;

        IF p_Resultado%ISOPEN THEN
            CLOSE p_Resultado;
        END IF;

END stp_Pessoas_Sel;

/
