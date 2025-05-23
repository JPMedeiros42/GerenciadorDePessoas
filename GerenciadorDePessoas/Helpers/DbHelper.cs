using Oracle.ManagedDataAccess.Client;
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

                base.AbreConexao();

                using (OracleDataReader dr = _cmmd.ExecuteReader(CommandBehavior.CloseConnection))
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