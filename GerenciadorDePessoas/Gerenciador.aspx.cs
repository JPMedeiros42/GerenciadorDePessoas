using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ToDoListWebForms.Helpers;

namespace GerenciadorDePessoas
{
    public partial class Gerenciador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BuscarTarefas();
        }

        private void BuscarTarefas()
        {
            try
            {
                using (var db = new DbHelper())
                {
                    var parametros = new Dictionary<string, object>();

                    if (!string.IsNullOrEmpty(filterCargo.SelectedValue))
                    {
                        parametros.Add("p_Filtro", filterCargo.SelectedValue);
                    }

                    DataTable tarefas = db.ExecutarProcedureDT("stp_Pessoas_Sel", parametros);
                    gridPessoas.DataSource = tarefas;
                    gridPessoas.DataBind();

                    lblTarefas.Visible = (tarefas == null || tarefas.Rows.Count == 0);
                }
            }
            catch (OracleException ex)
            {
                lblMensagem.Text = $"Erro ao buscar tarefas: {ex.Message}";
                lblMensagem.CssClass = "alert alert-danger";
            }
            catch (Exception)
            {
                lblMensagem.Text = "Ocorreu um erro inesperado.";
                lblMensagem.CssClass = "alert alert-danger";
            }
        }
    }
}