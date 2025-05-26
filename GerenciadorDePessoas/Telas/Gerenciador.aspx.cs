using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using ToDoListWebForms.Helpers;

namespace GerenciadorDePessoas
{
    public partial class Gerenciador : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BuscarVencimentos();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarVencimentos();
        }

        private void BuscarVencimentos()
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
                    if (!string.IsNullOrEmpty(nomeFilterPessoa.Text.Trim()))
                    {
                        parametros.Add("p_NomeFiltro", nomeFilterPessoa.Text.Trim());
                    }

                    string mensagem = string.Empty;
                    DataTable pessoas = db.ExecutarProcedureDT("stp_PessoasSalario_Sel", parametros, out mensagem);
                    gridVencimentos.DataSource = pessoas;
                    gridVencimentos.DataBind();

                    if (!string.IsNullOrEmpty(mensagem))
                    {
                        if (IsPostBack)
                        {
                            lblMensagem.Text = mensagem;
                            lblMensagem.CssClass = "alert alert-success"; // ou danger se for erro
                            lblMensagem.Visible = true;
                        }

                    }

                    lblPessoas.Visible = (pessoas == null || pessoas.Rows.Count == 0);
                }
            }
            catch (OracleException ex)
            {
                lblMensagem.Text = $"Erro ao buscar as pessoas: {ex.Message}";
                lblMensagem.CssClass = "alert alert-danger";
                lblMensagem.Visible = true;
            }
            catch (Exception ex)
            {
                lblMensagem.Text = "Ocorreu um erro inesperado.";
                lblMensagem.CssClass = "alert alert-danger";
                lblMensagem.Visible = true;
                System.Diagnostics.Debug.WriteLine(ex.ToString());
            }
            FecharMensagem();
        }

        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            try
            {
                CalcularVencimentos();

                BuscarVencimentos();
            }
            catch (OracleException ex)
            {
                lblMensagem.Text = $"Erro ao calcular vencimentos: {ex.Message}";
                lblMensagem.CssClass = "alert alert-danger";
                lblMensagem.Visible = true;
            }
            catch (Exception ex)
            {
                lblMensagem.Text = "Ocorreu um erro inesperado.";
                lblMensagem.CssClass = "alert alert-danger";
                lblMensagem.Visible = true;
                System.Diagnostics.Debug.WriteLine(ex.ToString());
            }
            FecharMensagem();
        }

        protected void CalcularVencimentos()
        {
            using (var db = new DbHelper())
            {
                var parametros = new Dictionary<string, object>();

                string mensagem = string.Empty;

                db.ExecutarProcedure("stp_PreencherPS_Ins", parametros, out mensagem);

                if (!string.IsNullOrEmpty(mensagem))
                {
                    lblMensagem.Text = mensagem;
                    lblMensagem.CssClass = "alert alert-success"; // ou danger se for erro
                    lblMensagem.Visible = true;

                }
            }
        }
        private void FecharMensagem()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "fecharMensagem", "FecharMensagem();", true);
        }
    }
}