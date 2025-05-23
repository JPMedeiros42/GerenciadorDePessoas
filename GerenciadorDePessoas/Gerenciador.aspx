<%@ Page Title="Gerenciador" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Gerenciador.aspx.cs" Inherits="GerenciadorDePessoas.Gerenciador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="row mb-3">
                <h2>Lista de Pessoas</h2>
                <div class="col-md-2">
                    <asp:DropDownList ID="filterCargo" runat="server" CssClass="form-select">
                        <asp:ListItem Value="">Todos</asp:ListItem>
                        <asp:ListItem Value="1">Estagiario</asp:ListItem>
                        <asp:ListItem Value="2">Tecnico</asp:ListItem>
                        <asp:ListItem Value="3">Analista</asp:ListItem>
                        <asp:ListItem Value="4">Coordenador</asp:ListItem>
                        <asp:ListItem Value="5">Gerente</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-1">
                    <asp:Button ID="btnBuscar" runat="server" CssClass="btn btn-primary w-100" OnClick="btnBuscar_Click" Text="Buscar" />
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnAdicionarPessoa" runat="server" CssClass="btn btn-success w-100" OnClientClick="return AbrirModal('Adicionar');" Text="Adicionar Pessoa" />
                </div>
                <div class="col-md-3">
                    <asp:Button ID="btnCalcularSalarios" runat="server" CssClass="btn btn-warning w-100" Text="Calcular/Recalcular Salários" />
                </div>
            </div>

            <div class="mensagemErro">
                <asp:Label ID="lblMensagem" runat="server" CssClass="" Visible="false" />
            </div>

            <div class="table-responsive">
                <asp:GridView ID="gridPessoas" runat="server" AutoGenerateColumns="false"
                    CssClass="table table-bordered" DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" Visible="false" />
                        <asp:BoundField DataField="Nome" HeaderText="Nome" />
                        <asp:BoundField DataField="Cargo" HeaderText="Cargo" />
                        <asp:BoundField DataField="Valor" HeaderText="Salário" />
                        <asp:BoundField DataField="Descricao" HeaderText="Salário" />
                    </Columns>
                </asp:GridView>
                <asp:Label ID="lblPessoas" runat="server" Text="Nenhuma pessoa encontrada" Visible="false" CssClass="text-muted"></asp:Label>
            </div>

            <!--- Modal p/ adicionar ---->
            <div class="modal fade" id="modalAdicionar" tabindex="-1" role="dialog" aria-labelledby="modalAdicionarLabel1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                    <div class="modal-content">

                        <div class="modal-header">
                            <h5 class="modal-title" id="modalAdicionarLabel">Adicionar Pessoa</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">
                            <div class="container">
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <asp:Label ID="lblNome" runat="server" Text="Nome Completo"></asp:Label>
                                        <asp:TextBox ID="txtNome" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                                        <asp:TextBox ID="txtEmail" placeholder="exemplo@gmail.com" 
                                            runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <asp:Label ID="lblUsuario" runat="server" Text="Nome de Usuario"></asp:Label>
                                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-3">
                                        <asp:Label ID="lblPais" runat="server" Text="Pais"></asp:Label>
                                        <asp:DropDownList ID="ddlPais" runat="server" CssClass="form-select">
                                            <asp:ListItem Value=""></asp:ListItem>
                                            <asp:ListItem Value="1">Brasil</asp:ListItem>
                                            <asp:ListItem Value="2">Estados Unidos</asp:ListItem>
                                            <asp:ListItem Value="3">Argentina</asp:ListItem>
                                            <asp:ListItem Value="4">Australia</asp:ListItem>
                                            <asp:ListItem Value="5">Colombia</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-3">
                                        <asp:Label ID="lblCep" runat="server" Text="CEP"></asp:Label>
                                        <asp:TextBox ID="txtCep" placeholder="12345678"
                                            runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-md-6">
                                        <asp:Label ID="Cidade" runat="server" Text="Cidade"></asp:Label>
                                        <asp:DropDownList ID="ddlCidade" runat="server" CssClass="form-select">
                                            <asp:ListItem Value=""></asp:ListItem>
                                            <asp:ListItem Value="1">Rio Grande do Norte</asp:ListItem>
                                            <asp:ListItem Value="2">Estados Unidos</asp:ListItem>
                                            <asp:ListItem Value="3">Argentina</asp:ListItem>
                                            <asp:ListItem Value="4">Australia</asp:ListItem>
                                            <asp:ListItem Value="5">Colombia</asp:ListItem>
                                        </asp:DropDownList>
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
                                    </div>
                                    <div class="col-md-3">
                                        <asp:Label ID="lblDataNasc" runat="server" Text="Data Nascimento"></asp:Label>
                                        <asp:TextBox ID="txtDataNasc" placeholder="01/01/1999" runat="server" CssClass="form-control"></asp:TextBox>
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
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="modal-footer">
                            <asp:Button ID="btnAdicionar" runat="server" Text="Adicionar" CssClass="btn btn-success" />
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
            $('#modal' + acao).modal('show');

            return false; //evitar postback
        }
    </script>
</asp:Content>
