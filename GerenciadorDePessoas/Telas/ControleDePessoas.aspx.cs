using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ToDoListWebForms.Helpers;

namespace GerenciadorDePessoas.Telas
{
    public partial class ControleDePessoas : Page
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

                    if (!string.IsNullOrEmpty(filterPessoa.SelectedValue))
                    {
                        parametros.Add("p_Filtro", filterPessoa.SelectedValue);
                    }

                    DataTable pessoas = db.ExecutarProcedureDT("stp_Pessoas_Sel", parametros);
                    gridPessoas.DataSource = pessoas;
                    gridPessoas.DataBind();

                    lblPessoas.Visible = (pessoas == null || pessoas.Rows.Count == 0);
                }
            }
            catch (OracleException ex)
            {
                lblMensagem.Text = $"Erro ao buscar as pessoas: {ex.Message}";
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
            try
            {
                var novaPessoa = new Pessoa
                {
                    Nome = txtNome.Text.Trim(),
                    Cidade = ddlCidade.SelectedValue.ToString(),
                    Email = txtEmail.Text.Trim(),
                    Cep = txtCep.Text.Trim(),
                    Endereco = txtEndereco.Text.Trim(),
                    Pais = ddlPais.SelectedValue.ToString(),
                    Usuario = txtUsuario.Text.Trim(),
                    Telefone = txtTelefone.Text.Trim(),
                    DataNascimento = DateTime.TryParse(txtDataNasc.Text.Trim(), out var dataNasc)
                            ? dataNasc
                            : throw new Exception("Data de nascimento inválida."),
                    CargoId = int.TryParse(ddlCargo.SelectedValue.ToString(), out var cargoId)
                      ? cargoId
                      : throw new Exception("Cargo inválido.")
                };

                AdicionarPessoa(novaPessoa);

                //LimparValores();

                BuscarPessoas();
            }
            catch (OracleException ex)
            {
                lblMensagem.Text = $"Erro ao buscar tarefas: {ex.Message}";
                lblMensagem.CssClass = "alert alert-danger";
                lblMensagem.Visible = true;
            }
            catch (Exception ex)
            {
                lblMensagem.Text = ex.Message;
                lblMensagem.CssClass = "alert alert-danger";
                lblMensagem.Visible = true;
                System.Diagnostics.Debug.WriteLine(ex.ToString());
            }
        }

        private void AdicionarPessoa(Pessoa pessoa)
        {
            using (var db = new DbHelper())
            {
                var parametros = new Dictionary<string, object>
                    {
                        {"p_Nome", pessoa.Nome},
                        {"p_Cidade", pessoa.Cidade},
                        {"p_Email", pessoa.Email},
                        {"p_Cep", pessoa.Cep},
                        {"p_Endereco", pessoa.Endereco},
                        {"p_Pais", pessoa.Pais},
                        {"p_Usuario", pessoa.Usuario},
                        {"p_Telefone", pessoa.Telefone},
                        {"p_Data_Nascimento", pessoa.DataNascimento},
                        {"p_Cargo_Id", pessoa.CargoId},
                        {"p_CodigoRetorno", null},
                        {"p_Mensagem", null}
                    };

                db.ExecutarProcedure("stp_Pessoas_Ins", parametros);

                var codigoRetorno = parametros["p_CodigoRetorno"];
                var mensagem = parametros["p_Mensagem"];
            }
        }

        //OnClientClick="return AbrirModal('Editar');"
        //private void EditarPessoa(Pessoa pessoa)
        //{
        //    using (var db = new DbHelper())
        //    {
        //        var parametros = new Dictionary<string, object>
        //            {
        //                {"p_Nome", pessoa.Nome},
        //                {"p_Cidade", pessoa.Cidade},
        //                {"p_Email", pessoa.Email},
        //                {"p_Cep", pessoa.Cep},
        //                {"p_Endereco", pessoa.Endereco},
        //                {"p_Pais", pessoa.Pais},
        //                {"p_Usuario", pessoa.Usuario},
        //                {"p_Telefone", pessoa.Telefone},
        //                {"p_Data_Nascimento", pessoa.DataNascimento},
        //                {"p_Cargo_Id", pessoa.CargoId},
        //                {"p_CodigoRetorno", null},
        //                {"p_Mensagem", null}
        //            };

        //        db.ExecutarProcedure("stp_Pessoas_Ins", parametros);

        //        var codigoRetorno = parametros["p_CodigoRetorno"];
        //        var mensagem = parametros["p_Mensagem"];
        //    }
        //}
        //OnClientClick='<%# "return AbrirModal(&#39;Deletar&#39;," + Eval("Id") + ");" %>'
        //private void DeletarPessoa()
        //{
        //    using (var db = new DbHelper())
        //    {
        //        var parametros = new Dictionary<string, object>
        //            {
        //                {"p_Nome", id.SelectedValue},    
        //                {"p_CodigoRetorno", null},
        //                {"p_Mensagem", null}
        //            };

        //        db.ExecutarProcedure("stp_Pessoas_Ins", parametros);

        //        var codigoRetorno = parametros["p_CodigoRetorno"];
        //        var mensagem = parametros["p_Mensagem"];
        //    }
        //}

        //private void LimparValores()
        //{
        //    ScriptManager.RegisterStartupScript(this, GetType(), "limparModal", "LimparModal('Adicionar');", true);
        //}
    }
}