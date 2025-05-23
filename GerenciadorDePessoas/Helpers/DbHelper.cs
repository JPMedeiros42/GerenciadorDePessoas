using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ToDoListWebForms.Helpers
{
    public sealed class DbHelper : BaseDbHelper
    {
        public DataTable ExecutarProcedureDT(string procedure, Dictionary<string, object> parametros)
        {
            DataTable dt = new DataTable();

            try
            {
                base.SetCommand(procedure);

                if (parametros != null && parametros.Count > 0)
                {
                    foreach (var param in parametros)
                    {
                        var oracleParam = new OracleParameter(param.Key, param.Value ?? DBNull.Value);
                        _cmmd.Parameters.Add(oracleParam);
                    }
                }

                var pResultado = new OracleParameter("p_Resultado", OracleDbType.RefCursor)
                {
                    Direction = ParameterDirection.Output
                };
                _cmmd.Parameters.Add(pResultado);

                _cmmd.Parameters.Add("p_CodigoRetorno", OracleDbType.Int32).Direction = ParameterDirection.Output;
                _cmmd.Parameters.Add("p_Mensagem", OracleDbType.Varchar2, 4000).Direction = ParameterDirection.Output;


                base.AbreConexao();

                _cmmd.ExecuteNonQuery();

                OracleRefCursor refCursor = (OracleRefCursor)_cmmd.Parameters["p_Resultado"].Value;
                using (OracleDataReader dr = refCursor.GetDataReader())
                {
                    dt.Load(dr);
                }

            }
            catch (OracleException ex)
            {
                throw new Exception($"Erro Oracle ({ex.ErrorCode}): {ex.Message}", ex);
            }
            finally
            {
                base.DescartaComando();
                base.FechaConexao();
            }

            return dt;
        }

        public void ExecutarProcedure(string procedure, Dictionary<string, object> parametros)
        {
            try
            {
                base.SetCommand(procedure);

                if (parametros != null && parametros.Count > 0)
                {
                    foreach (var param in parametros)
                    {
                        var oracleParam = new OracleParameter(param.Key, param.Value ?? DBNull.Value);
                        _cmmd.Parameters.Add(oracleParam);
                    }
                }

                base.AbreConexao();

                _cmmd.ExecuteNonQuery();
            }
            catch (OracleException ex)
            {
                throw new Exception($"Erro Oracle ({ex.ErrorCode}): {ex.Message}", ex);
            }
            finally
            {
                base.DescartaComando();
                base.FechaConexao();
            }
        }

    }
}