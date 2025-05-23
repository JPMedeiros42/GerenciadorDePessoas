using Oracle.ManagedDataAccess.Client;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ToDoListWebForms.Helpers
{
    public class BaseDbHelper : IDisposable
    {
        protected OracleConnection _conexao = null;

        protected OracleCommand _cmmd = null;

        private bool _disposed = false;

        public BaseDbHelper()
        {
            SetConn();
        }

        protected void SetConn()
        {
            if (_conexao == null)
            {
                string connString = ConfigurationManager.ConnectionStrings["GerenciamentoDB"].ConnectionString;
                _conexao = new OracleConnection(connString);
            }
        }

        public void SetCommand(string nomeProcedure)
        {
            if (string.IsNullOrWhiteSpace(nomeProcedure))
            {
                throw new ArgumentException("Nome da procedure não pode ser vazio ou nulo.", nameof(nomeProcedure));
            }

            _cmmd = new OracleCommand(nomeProcedure, _conexao)
            {
                CommandType = CommandType.StoredProcedure,
                CommandTimeout = 60,
                BindByName = true
            };

        }

        public void AbreConexao()
        {
            if (_conexao.State == ConnectionState.Closed)
            {
                _conexao.Open();
            }
        }

        public void FechaConexao()
        {
            if (_conexao.State == ConnectionState.Open)
            {
                _conexao.Close();
            }
        }

        public void DescartaComando()
        {
            if (_cmmd != null)
            {
                _cmmd.Dispose();
                _cmmd = null;
            }
        }

        public void DescartaConexao()
        {
            if (_conexao != null)
            {
                _conexao.Dispose();
                _conexao = null;
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    _cmmd?.Dispose();
                    FechaConexao();
                    _conexao?.Dispose();
                }

                _disposed = true;
            }
        }

        ~BaseDbHelper()
        {
            Dispose(false);
        }
    }
}