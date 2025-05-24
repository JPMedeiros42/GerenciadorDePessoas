using GerenciadorDePessoas.Telas;
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

                    DataTable pessoas = db.ExecutarProcedureDT("stp_PessoasSalario_Sel", parametros);
                    gridVencimentos.DataSource = pessoas;
                    gridVencimentos.DataBind();

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
        }

        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            CalcularVencimentos();

            BuscarVencimentos();
        }

        protected void CalcularVencimentos()
        {
            try
            {
                using (var db = new DbHelper())
                {
                    var parametros = new Dictionary<string, object>
                    {
                        //{"p_CodigoRetorno", null},
                        //{"p_Mensagem", null}
                    };


                    db.ExecutarProcedure("stp_PreencherPS_Ins", parametros);
                }
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
        }        
    }
}