--------------------------------------------------------
--  Arquivo criado - segunda-feira-maio-26-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure STP_PREENCHERPS_INS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "SYSTEM"."STP_PREENCHERPS_INS" (
    p_CodigoRetorno OUT NUMBER,
    p_Mensagem OUT VARCHAR2)
AS
BEGIN  
    
    INSERT INTO tmp_PessoaSalario(Pessoa_Id,Nome,Salario_Bruto,Descontos)
    SELECT
        p.Id,
        p.Nome,
        SUM(CASE
                WHEN v.Forma_Incidencia = 'V' AND v.Tipo = 'C' THEN v.Valor
                ELSE 0
            END) AS Salario_Bruto,
        SUM(CASE
                WHEN v.Forma_Incidencia = 'V' AND v.Tipo = 'D' THEN v.Valor
                WHEN v.Forma_Incidencia = 'P' AND v.Tipo = 'D' 
                    THEN (SELECT 
                            SUM (v2.Valor)
                        FROM Vencimentos v2
                        INNER JOIN Cargo_Vencimento cv2 
                            ON v2.Id = cv2.Vencimento_Id
                        WHERE cv2.Cargo_Id = p.Cargo_Id
                            AND v2.Forma_Incidencia = 'V'
                            AND v2.Tipo = 'C') * (v.Valor/100) 
                ELSE 0
            END) AS Desconto  
    FROM Pessoa p
    INNER JOIN Cargo c ON c.id = p.Cargo_Id
    LEFT JOIN Cargo_Vencimento cv ON cv.Cargo_Id = p.Cargo_Id
    LEFT JOIN Vencimentos v ON v.Id = cv.Vencimento_Id
    GROUP BY p.Id, p.Nome;
    
    UPDATE tmp_PessoaSalario
    SET Salario_Liquido = NVL(Salario_Bruto, 0) - NVL(Descontos, 0);
    
    DELETE FROM Pessoa_Salario ps
    WHERE NOT EXISTS (
        SELECT 1 FROM tmp_PessoaSalario tmp
        WHERE tmp.Pessoa_Id = ps.Pessoa_Id);
        

    MERGE INTO Pessoa_Salario ps
    USING tmp_PessoaSalario tmp
    ON (ps.Pessoa_Id = tmp.Pessoa_Id)
    WHEN MATCHED THEN
        UPDATE SET            
            ps.Nome = tmp.Nome,
            ps.Salario_Bruto = tmp.Salario_Bruto,
            ps.Descontos = tmp.Descontos,
            ps.Salario_Liquido = tmp.Salario_Liquido
    WHEN NOT MATCHED THEN
        INSERT (Pessoa_Id,Nome,Salario_Bruto,Descontos,Salario_Liquido)
        VALUES (tmp.Pessoa_Id, tmp.Nome, tmp.Salario_Bruto, 
                            tmp.Descontos, tmp.Salario_Liquido);
                            
    p_CodigoRetorno := 0;
    p_Mensagem := 'Operação realizada com sucesso';
    
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
    
    ROLLBACK;
        p_CodigoRetorno := -1;
        p_Mensagem := 'Erro ao calcular : ' || SQLERRM;
    
END;

/
