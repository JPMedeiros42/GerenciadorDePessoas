﻿<%@ Page Title="Cadastro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ControleDePessoas.aspx.cs" Inherits="GerenciadorDePessoas.Telas.ControleDePessoas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="row mb-3">
                <h2>Lista de Pessoas</h2>
                <div class="col-md-2">
                    <asp:DropDownList ID="cargoFilterPessoa" runat="server" CssClass="form-select">
                        <asp:ListItem Value="">Todos</asp:ListItem>
                        <asp:ListItem Value="1">Estagiario</asp:ListItem>
                        <asp:ListItem Value="2">Tecnico</asp:ListItem>
                        <asp:ListItem Value="3">Analista</asp:ListItem>
                        <asp:ListItem Value="4">Coordenador</asp:ListItem>
                        <asp:ListItem Value="5">Gerente</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:TextBox ID="nomeFilterPessoa" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnBuscar" runat="server" CssClass="btn btn-primary w-100" OnClick="btnBuscar_Click" Text="Buscar" />
                </div>
                <div class="col-md-2">
                    <button type="button" id="btnAdicionarPessoa" class="btn btn-success w-100"
                        data-bs-target="#modalPessoa" data-bs-toggle="modal" onclick="AbrirModal('Adicionar')">
                        Adicionar Pessoa</button>
                </div>
            </div>

            <div class="mensagemErro row">
                <asp:Label ID="lblMensagem" runat="server" CssClass="" Visible="false" />
            </div>

            <div class="container-fluid" style="width: 120%; position: relative; left: 50%; transform: translateX(-50%);">
                <asp:GridView ID="gridPessoas" runat="server" AutoGenerateColumns="false"
                    CssClass="table table-bordered" DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" Visible="false" />
                        <asp:TemplateField HeaderText="Nome" ItemStyle-CssClass="align-Grid">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkAbrirModal" runat="server"
                                    Text='<%# Eval("Nome") %>'
                                    CommandArgument='<%# Eval("Id") %>'
                                    OnClick="btnBuscarPorId_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Cargo" HeaderText="Cargo" ItemStyle-CssClass="align-Grid" />
                        <asp:BoundField DataField="Email" HeaderText="E-mail" ItemStyle-CssClass="align-Grid" />
                        <asp:BoundField DataField="Telefone" HeaderText="Telefone" ItemStyle-CssClass="align-Grid" />
                        <asp:BoundField DataField="DataNascimento" HeaderText="Data Nascimento"
                            DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="false" ItemStyle-CssClass="align-Grid" />
                        <asp:BoundField DataField="Pais" HeaderText="País" ItemStyle-CssClass="align-Grid" />
                        <asp:BoundField DataField="Cidade" HeaderText="Cidade" ItemStyle-CssClass="align-Grid" />
                        <asp:BoundField DataField="Endereco" HeaderText="Endereço" ItemStyle-CssClass="align-Grid" />
                        <asp:BoundField DataField="CEP" HeaderText="CEP" ItemStyle-CssClass="align-Grid" />
                        <asp:BoundField DataField="Usuario" HeaderText="Usuário" ItemStyle-CssClass="align-Grid" />

                    </Columns>
                </asp:GridView>
                <asp:Label ID="lblPessoas" runat="server" Text="Nenhuma pessoa encontrada" Visible="false" CssClass="text-muted"></asp:Label>
            </div>

            <!---- Modal ---->
            <div class="modal fade" id="modalPessoa" tabindex="-1" role="dialog" aria-labelledby="modalPessoaLabel1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                    <div class="modal-content">

                        <div class="modal-header">
                            <h5 class="modal-title" id="modalPessoaLabel">Adicionar Pessoa</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">
                            <div class="container">
                                <asp:Label ID="modalId" runat="server" CssClass="" Visible="false" />
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <asp:Label ID="lblNome" runat="server" Text="Nome Completo"></asp:Label>
                                        <asp:TextBox ID="txtNome" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvNome" runat="server"
                                            ControlToValidate="txtNome"
                                            ValidationGroup="Cadastro"
                                            ErrorMessage="* Nome obrigatório"
                                            Display="Dynamic"
                                            CssClass="text-danger" />
                                    </div>
                                    <div class="col-md-4">
                                        <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                                        <asp:TextBox ID="txtEmail" placeholder="exemplo@gmail.com"
                                            runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                            ControlToValidate="txtEmail"
                                            ValidationGroup="Cadastro"
                                            ErrorMessage="* Email é obrigatório"
                                            Display="Dynamic"
                                            CssClass="text-danger" />
                                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                            ControlToValidate="txtEmail"
                                            ValidationGroup="Cadastro"
                                            ValidationExpression="^[\w\.-]+@[\w\.-]+\.\w{2,}$"
                                            ErrorMessage="* Email inválido"
                                            Display="Dynamic"
                                            CssClass="text-danger" />
                                    </div>
                                    <div class="col-md-4">
                                        <asp:Label ID="lblUsuario" runat="server" Text="Nome de Usuario"></asp:Label>
                                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvUsuario" runat="server"
                                            ControlToValidate="txtUsuario"
                                            ValidationGroup="Cadastro"
                                            ErrorMessage="* Usuário é obrigatório"
                                            Display="Dynamic"
                                            CssClass="text-danger" />
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-3">
                                        <asp:Label ID="lblPais" runat="server" Text="Pais"></asp:Label>
                                        <asp:DropDownList ID="ddlPais" runat="server" CssClass="form-select">
                                            <asp:ListItem Value=""></asp:ListItem>
                                            <asp:ListItem Value="Brazil">Brazil</asp:ListItem>
                                            <asp:ListItem Value="2">Estados Unidos</asp:ListItem>
                                            <asp:ListItem Value="3">Argentina</asp:ListItem>
                                            <asp:ListItem Value="4">Australia</asp:ListItem>
                                            <asp:ListItem Value="5">Colombia</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvPais" runat="server"
                                            ControlToValidate="ddlPais"
                                            ValidationGroup="Cadastro"
                                            InitialValue=""
                                            ErrorMessage="* País é obrigatório"
                                            Display="Dynamic"
                                            CssClass="text-danger" />
                                    </div>
                                    <div class="col-md-3">
                                        <asp:Label ID="lblCep" runat="server" Text="CEP"></asp:Label>
                                        <asp:TextBox ID="txtCep" placeholder="12345-678"
                                            runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revTelefone" runat="server"
                                            ControlToValidate="txtCep"
                                            ValidationGroup="Cadastro"
                                            ValidationExpression="^\d{5}-\d{3}$"
                                            ErrorMessage="* CEP inválido"
                                            Display="Dynamic"
                                            CssClass="text-danger" />

                                    </div>
                                    <div class="col-md-6">
                                        <asp:Label ID="Cidade" runat="server" Text="Cidade"></asp:Label>
                                        <asp:DropDownList ID="ddlCidade" runat="server" CssClass="form-select">
                                            <asp:ListItem Value=""></asp:ListItem>
                                            <asp:ListItem Value="Rio Grande do Norte">Rio Grande do Norte</asp:ListItem>
                                            <asp:ListItem Value="Distrito Federal">Distrito Federal</asp:ListItem>
                                            <asp:ListItem Value="São Paulo">São Paulo</asp:ListItem>
                                            <asp:ListItem Value="Minas Gerais">Minas Gerais</asp:ListItem>
                                            <asp:ListItem Value="Rio de Janeiro">Rio de Janeiro</asp:ListItem>
                                            <asp:ListItem Value="Bahia">Bahia</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvCidade" runat="server"
                                            ControlToValidate="ddlCidade"
                                            ValidationGroup="Cadastro"
                                            InitialValue=""
                                            ErrorMessage="* Cidade é obrigatória"
                                            Display="Dynamic"
                                            CssClass="text-danger" />
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-5">
                                        <asp:Label ID="lblEndereco" runat="server" Text="Endereço"></asp:Label>
                                        <asp:TextBox ID="txtEndereco" placeholder="Av. do Exemplos,123" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <asp:Label ID="lblTelefone" runat="server" Text="Telefone"></asp:Label>
                                        <asp:TextBox ID="txtTelefone" placeholder="(99) 99999-9999" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvTelefone" runat="server"
                                            ControlToValidate="txtTelefone"
                                            ValidationGroup="Cadastro"
                                            ErrorMessage="* Telefone é obrigatório"
                                            Display="Dynamic"
                                            CssClass="text-danger" />
                                        <br />
                                    </div>
                                    <div class="col-md-3">
                                        <asp:Label ID="lblDataNasc" runat="server" Text="Data Nascimento"></asp:Label>
                                        <asp:TextBox ID="txtDataNasc" placeholder="01/01/1999" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDataNascimento" runat="server"
                                            ControlToValidate="txtDataNasc"
                                            ValidationGroup="Cadastro"
                                            ErrorMessage="* Data de nascimento é obrigatória"
                                            Display="Dynamic"
                                            CssClass="text-danger" />
                                        <asp:RegularExpressionValidator ID="revDataNascimento" runat="server"
                                            ControlToValidate="txtDataNasc"
                                            ValidationGroup="Cadastro"
                                            ValidationExpression="^\d{2}/\d{2}/\d{4}$"
                                            ErrorMessage="* Formato inválido (use dd/mm/aaaa)"
                                            Display="Dynamic"
                                            CssClass="text-danger" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <asp:Label ID="lblCargo" runat="server" Text="Cargo"></asp:Label>
                                        <asp:DropDownList ID="ddlCargo" runat="server" CssClass="form-select">
                                            <asp:ListItem Value=""></asp:ListItem>
                                            <asp:ListItem Value="1">Estagiario</asp:ListItem>
                                            <asp:ListItem Value="2">Tecnico</asp:ListItem>
                                            <asp:ListItem Value="3">Analista</asp:ListItem>
                                            <asp:ListItem Value="4">Coordenador</asp:ListItem>
                                            <asp:ListItem Value="5">Gerente</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvCargo" runat="server"
                                            ControlToValidate="ddlCargo"
                                            ValidationGroup="Cadastro"
                                            InitialValue=""
                                            ErrorMessage="* Cargo é obrigatório"
                                            Display="Dynamic"
                                            CssClass="text-danger" />
                                        <br />
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="modal-footer">
                            <asp:Button ID="btnAdicionar" runat="server" Text="Adicionar" CssClass="btn btn-primary" ValidationGroup="Cadastro" OnClick="btnAdicionar_Click" />
                            <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn btn-success" OnClick="btnEditar_Click" />
                            <button type="button" id="btnModalDelete" class="btn btn-danger" data-bs-target="#modalDeletar" data-bs-toggle="modal">Deletar</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!--- Fim Modal ---->
            <!---- Modal Deletar ---->
            <div class="modal fade" id="modalDeletar" tabindex="-1" role="dialog" aria-labelledby="modalDeletarLabel1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">

                        <div class="modal-header">
                            <h5 class="modal-title" id="modalDeletarLabel">Você tem certeza disso?</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">
                            <div class="container">
                                <p>Ao aceitar o registro será apagado permanentemente.</p>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <asp:Button ID="btnDeletar" runat="server" Text="Deletar" CssClass="btn btn-danger" OnClick="btnDeletar_Click" />
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!--- Fim Modal ---->
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        function AbrirModal(acao, id) {

            $('#modalPessoa').modal('show');

            if (acao === 'Adicionar') {
                LimparModal();
                $('#<%= btnAdicionar.ClientID %>').show();
                $('#<%= btnEditar.ClientID %>').hide();
                $('#btnModalDelete').hide();
            }
            else if (acao === 'Editar') {
                $('#<%= btnAdicionar.ClientID %>').hide();
                $('#<%= btnEditar.ClientID %>').show();
                $('#btnModalDelete').show();

            }

            return false; //evitar postback
        }
        function FecharModal() {
            LimparModal();

            document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
            document.body.classList.remove('modal-open');
            document.body.style.overflow = '';
            document.body.style.paddingRight = '';
        }

        function LimparModal() {
            const meuModal = document.getElementById('modalPessoa');
            meuModal.querySelectorAll('input[type="text"], textarea').forEach(input => { input.value = '' });
            meuModal.querySelectorAll('select').forEach(function (dropdown) {
                dropdown.value = "";
            });

        }

        function FecharMensagem() {
            const alerta = document.getElementById('<%= lblMensagem.ClientID %>');
            if (alerta && alerta.innerText.trim() !== "") {
                alerta.style.display = 'block';

                setTimeout(() => {
                    alerta.style.display = 'none';
                }, 5000);
            }
        }

    </script>
</asp:Content>
