using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Services.Description;
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
            try
            {
                BuscarPessoas();
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
            FecharMensagem();
        }

        private void BuscarPessoas()
        {

            using (var db = new DbHelper())
            {
                var parametros = new Dictionary<string, object>();

                if (!string.IsNullOrEmpty(cargoFilterPessoa.SelectedValue))
                {
                    parametros.Add("p_CargoFiltro", cargoFilterPessoa.SelectedValue);
                }
                if (!string.IsNullOrEmpty(nomeFilterPessoa.Text.Trim()))
                {
                    parametros.Add("p_NomeFiltro", nomeFilterPessoa.Text.Trim());
                }
                string mensagem = string.Empty;

                DataTable pessoas = db.ExecutarProcedureDT("stp_Pessoas_Sel", parametros, out mensagem);
                gridPessoas.DataSource = pessoas;
                gridPessoas.DataBind();

                lblPessoas.Visible = !(pessoas.Rows.Count > 0);

                if (!string.IsNullOrEmpty(mensagem))
                {
                    if (IsPostBack)
                    {
                        lblMensagem.Text = mensagem;
                        lblMensagem.CssClass = "alert alert-success"; // ou danger se for erro
                        lblMensagem.Visible = true;
                    }

                }

            }

        }

        protected void btnBuscarPorId_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btnId = (LinkButton)sender;
                int id = int.Parse(btnId.CommandArgument);
                BuscarPessoaPorId(id);
                ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "AbrirModal('Editar');", true);
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

        private void BuscarPessoaPorId(int id)
        {
            using (var db = new DbHelper())
            {
                var parametros = new Dictionary<string, object>
                    {
                        {"p_IdPessoa", id }
                    };

                string mensagem = string.Empty;

                DataTable pessoa = db.ExecutarProcedureDT("stp_Pessoas_Sel", parametros, out mensagem);

                if (pessoa != null && pessoa.Rows.Count > 0)
                {
                    DataRow row = pessoa.Rows[0];
                    modalId.Text = row["Id"].ToString();
                    txtNome.Text = row["Nome"].ToString();
                    txtEmail.Text = row["Email"].ToString();
                    txtUsuario.Text = row["Usuario"].ToString();
                    txtTelefone.Text = row["Telefone"].ToString();
                    txtDataNasc.Text = DateTime.TryParse(row["DataNascimento"].ToString(), out DateTime data)
                                                                            ? data.ToString("dd/MM/yyyy")
                                                                            : string.Empty;
                    ddlPais.SelectedValue = row["Pais"].ToString();
                    ddlCidade.SelectedValue = row["Cidade"].ToString();
                    txtEndereco.Text = row["Endereco"].ToString();
                    txtCep.Text = row["CEP"].ToString();
                    ddlCargo.SelectedValue = row["CargoID"].ToString();
                }
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

                LimparValores();

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
                LimparValores();
                lblMensagem.Text = ex.Message;
                lblMensagem.CssClass = "alert alert-danger";
                lblMensagem.Visible = true;
                System.Diagnostics.Debug.WriteLine(ex.ToString());
            }
            FecharMensagem();
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
                        {"p_Cargo_Id", pessoa.CargoId}
                    };

                string mensagem = string.Empty;

                db.ExecutarProcedure("stp_Pessoas_Ins", parametros, out mensagem);

                if (!string.IsNullOrEmpty(mensagem))
                {
                    lblMensagem.Text = mensagem;
                    lblMensagem.CssClass = "alert alert-success"; // ou danger se for erro
                    lblMensagem.Visible = true;
                }
            }
        }
        protected void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                var editarPessoa = new Pessoa
                {
                    Id = int.TryParse(modalId.Text, out var id) ? id : throw new Exception("ID inválido."),
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

                EditarPessoa(editarPessoa);

                LimparValores();

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
                LimparValores();
                lblMensagem.Text = ex.Message;
                lblMensagem.CssClass = "alert alert-danger";
                lblMensagem.Visible = true;
                System.Diagnostics.Debug.WriteLine(ex.ToString());
            }
            FecharMensagem();
        }

        private void EditarPessoa(Pessoa pessoa)
        {
            using (var db = new DbHelper())
            {
                var parametros = new Dictionary<string, object>
                    {
                        {"p_Id", pessoa.Id},
                        {"p_Nome", pessoa.Nome},
                        {"p_Cidade", pessoa.Cidade},
                        {"p_Email", pessoa.Email},
                        {"p_Cep", pessoa.Cep},
                        {"p_Endereco", pessoa.Endereco},
                        {"p_Pais", pessoa.Pais},
                        {"p_Usuario", pessoa.Usuario},
                        {"p_Telefone", pessoa.Telefone},
                        {"p_Data_Nascimento", pessoa.DataNascimento},
                        {"p_Cargo_Id", pessoa.CargoId}
                    };

                string mensagem = string.Empty;

                db.ExecutarProcedure("stp_Pessoas_Upd", parametros, out mensagem);

                if (!string.IsNullOrEmpty(mensagem))
                {
                    lblMensagem.Text = mensagem;
                    lblMensagem.CssClass = "alert alert-success"; // ou danger se for erro
                    lblMensagem.Visible = true;
                }

            }
        }
        protected void btnDeletar_Click(object sender, EventArgs e)
        {
            try
            {
                DeletarPessoa(int.TryParse(modalId.Text, out var id) ? id : throw new Exception("ID inválido."));

                LimparValores();

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
                LimparValores();
                lblMensagem.Text = ex.Message;
                lblMensagem.CssClass = "alert alert-danger";
                lblMensagem.Visible = true;
                System.Diagnostics.Debug.WriteLine(ex.ToString());
            }
            FecharMensagem();
        }


        private void DeletarPessoa(int id)
        {
            using (var db = new DbHelper())
            {
                var parametros = new Dictionary<string, object>
                {
                    {"p_Id", id}
                };

                string mensagem = string.Empty;

                db.ExecutarProcedure("stp_Pessoas_Del", parametros, out mensagem);

                if (!string.IsNullOrEmpty(mensagem))
                {
                    lblMensagem.Text = mensagem;
                    lblMensagem.CssClass = "alert alert-success"; // ou danger se for erro
                    lblMensagem.Visible = true;
                }
            }
        }

        private void LimparValores()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "fecharModal", "FecharModal();", true);
        }
        private void FecharMensagem()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "fecharMensagem", "FecharMensagem();", true);
        }
    }
}