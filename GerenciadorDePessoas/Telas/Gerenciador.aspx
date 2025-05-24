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
                <div class="col-md-3">
                    <asp:Button ID="btnCalcularSalarios" runat="server" CssClass="btn btn-warning w-100" OnClick="btnCalcular_Click" Text="Calcular/Recalcular Salários" />
                </div>
            </div>

            <div class="mensagemErro row d-flex justify-content-center">
                <div class="col" align="center">
                    <asp:Label ID="lblMensagem" runat="server" CssClass="" Visible="true" />
                </div>
            </div>

            <div class="table-responsive">
                <asp:GridView ID="gridVencimentos" runat="server" AutoGenerateColumns="false"
                    CssClass="table table-bordered" DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" Visible="false" />
                        <asp:BoundField DataField="Nome" HeaderText="Nome" />
                        <asp:BoundField DataField="Cargo" HeaderText="Cargo" />
                        <asp:BoundField DataField="SalarioBruto" HeaderText="Salário Bruto" 
                            DataFormatString="R$ {0:N2}" HtmlEncode="false" ItemStyle-HorizontalAlign="Right"/>
                        <asp:BoundField DataField="Descontos" HeaderText="Descontos" 
                            DataFormatString="R$ {0:N2}" HtmlEncode="false" ItemStyle-HorizontalAlign="Right"/>
                        <asp:BoundField DataField="SalarioLiquido" HeaderText="Salário Liquido" 
                            DataFormatString="R$ {0:N2}" HtmlEncode="false" ItemStyle-HorizontalAlign="Right"/>
                    </Columns>
                </asp:GridView>
                <asp:Label ID="lblPessoas" runat="server" Text="Nenhuma pessoa encontrada" Visible="false" CssClass="text-muted"></asp:Label>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
