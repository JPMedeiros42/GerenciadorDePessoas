--------------------------------------------------------
--  Arquivo criado - segunda-feira-maio-26-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure STP_PESSOASSALARIO_SEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "SYSTEM"."STP_PESSOASSALARIO_SEL" (
    p_Filtro IN NUMBER DEFAULT NULL,
    p_NomeFiltro IN VARCHAR2 DEFAULT NULL,
    p_Resultado OUT SYS_REFCURSOR,
    p_CodigoRetorno OUT NUMBER,
    p_Mensagem OUT VARCHAR2
) IS
BEGIN


    Open p_Resultado FOR
        SELECT
            ps.Pessoa_Id AS Id,
            ps.Nome,
            c.Nome AS Cargo,
            ps.Salario_Bruto AS SalarioBruto,
            ps.Descontos,
            ps.Salario_Liquido AS SalarioLiquido
        FROM Pessoa_Salario ps
        LEFT JOIN Pessoa p ON p.id = ps.Pessoa_Id
        LEFT JOIN Cargo c ON p.Cargo_Id = c.id
        WHERE (p_filtro IS NULL OR p_filtro = c.Id)
        AND (p_NomeFiltro IS NULL OR UPPER(ps.Nome) LIKE '%' || UPPER(p_NomeFiltro) || '%')
        ORDER BY ps.Nome;


    p_CodigoRetorno := 0;
    p_Mensagem := 'Consulta realizada com sucesso';

EXCEPTION
    WHEN OTHERS THEN
        p_CodigoRetorno := -1;
        p_Mensagem := 'Erro ao consultar pessoas: ' || SQLERRM;

        IF p_Resultado%ISOPEN THEN
            CLOSE p_Resultado;
        END IF;

END;

/
