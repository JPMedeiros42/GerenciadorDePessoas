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
            if (!IsPostBack)
            {
                BuscarPessoas();
            }
        }
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarPessoas();
        }

        private void BuscarPessoas()
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

                    DataTable pessoas = db.ExecutarProcedureDT("stp_Pessoas_Sel", parametros);
                    gridPessoas.DataSource = pessoas;
                    gridPessoas.DataBind();

                    lblPessoas.Visible = (pessoas == null || pessoas.Rows.Count == 0);
                }
            }
            catch (OracleException ex)
            {
                lblMensagem.Text = $"Erro ao buscar tarefas: {ex.Message}";
                lblMensagem.CssClass = "alert alert-danger";
            }
            catch (Exception ex)
            {
                lblMensagem.Text = "Ocorreu um erro inesperado.";
                lblMensagem.CssClass = "alert alert-danger";
                System.Diagnostics.Debug.WriteLine(ex.ToString());
            }
        }

        protected void btnAdicionar_Click(object sender, EventArgs e)
        {
            //string nome = txtNome.Text.Trim();
            //string usuario = txtUsuario.Text.Trim();
            //string cargo = ddlCargo.SelectedValue;
            //string telefone = txtTelefone.Text.Trim();
            //string email = txtEmail.Text.Trim();
            //string dataNascimento = txtDataNasc.Text.Trim();
            //string pais = ddlPais.SelectedValue;
            //string endereco = txtEndereco.Text.Trim();
            //string cidade = ddlCidade.Text.Trim();
            //string cep = txtCep.Text.Trim();

            AdicionarPessoas();

            //LimparValores();

            BuscarPessoas();
        }

        private void AdicionarPessoas()
        {
            using (var db = new DbHelper())
            {
                var parametros = new Dictionary<string, object>
                    {
                        //{ "@Titulo", titulo },
                        //{ "@Descricao", descricao }
                    };

                db.ExecutarProcedure("sp_Pessoas_Ins", parametros);
            }
        }

        //private void LimparValores()
        //{
        //    ScriptManager.RegisterStartupScript(this, GetType(), "limparModal", "LimparModal('Adicionar');", true);
        //}
    }
}