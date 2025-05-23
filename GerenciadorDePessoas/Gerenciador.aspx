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
                <div class="col-md-2">
                    <asp:Button ID="btnBuscar" runat="server" CssClass="btn btn-primary w-100" OnClick="btnBuscar_Click" Text="Buscar" />
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnAdicionarPessoa" runat="server" CssClass="btn btn-success w-100" Text="Adicionar Pessoa" />
                </div>
            </div>

            <div class="mensagemErro">
                <asp:Label ID="lblMensagem" runat="server" CssClass="" Visible="false" />
            </div>

            <div>
                <asp:GridView ID="gridPessoas" runat="server" AutoGenerateColumns="false"
                    CssClass="table table-bordered" DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" Visible="false" />
                        <asp:BoundField DataField="Nome" HeaderText="Nome" />
                        <asp:BoundField DataField="Cargo" HeaderText="Cargo" />
                        <asp:BoundField DataField="Salario" HeaderText="Salário" />                        
                    </Columns>
                </asp:GridView>
                <asp:Label ID="lblTarefas" runat="server" Text="Nenhuma pessoa encontrada" Visible="false" CssClass="text-muted"></asp:Label>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
