<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GerenciadorDePessoas._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <div style="max-width: 900px; margin: 20px auto; font-family: Arial, sans-serif; line-height: 1.6;">
        <h1 style="color: #2c3e50;">Gerenciador de Pessoas</h1>
        <p>Este projeto é um sistema web em <strong>ASP.NET Web Forms (.NET Framework 4.8)</strong> para gerenciar pessoas, permitindo cadastro, edição, exclusão e busca de registros em um banco de dados Oracle.</p>

        <h2>Funcionalidades Principais</h2>
        <ol>
            <li><strong>Listagem de Pessoas</strong><br />
                Exibe uma tabela com todas as pessoas cadastradas, mostrando informações como nome, cargo, salário bruto, descontos e salário líquido.<br />
                Permite filtrar a lista por cargo e nome, facilitando a busca por registros específicos.
            </li>
            <li><strong>CRUD completo de Pessoas</strong><br />
                Possibilita adicionar, alterar e remover colaboradores, garantindo dados atualizados e corretos.
            </li>
            <li><strong>Cálculo/Recalculo de Salários</strong><br />
                Botão dedicado para calcular ou recalcular salários dos colaboradores, considerando descontos e regras de negócio.
            </li>
            <li><strong>Mensagens de Feedback</strong><br />
                Exibe mensagens de sucesso ou erro para informar o usuário sobre os resultados das operações.
            </li>
            <li><strong>Interface Responsiva</strong><br />
                Utiliza componentes como UpdatePanel para navegação fluida e adaptação a diferentes tamanhos de tela.
            </li>
        </ol>

        <h2>Tecnologias Utilizadas</h2>
        <ul>
            <li>ASP.NET Web Forms (.NET Framework 4.8)</li>
            <li>C# 7.3</li>
            <li>Oracle Managed Data Access (ODP.NET)</li>
            <li>HTML, CSS, JavaScript</li>
        </ul>

        <h2>Estrutura Principal</h2>
        <ul>
            <li><strong>ControleDePessoas.aspx.cs</strong>: Lógica para manipulação de pessoas.</li>
            <li><strong>Gerenciador.aspx.cs</strong>: Lógica para cálculo dos vencimentos.</li>
            <li><strong>Pessoa</strong>: Classe modelo representando a entidade Pessoa.</li>
            <li><strong>DbHelper e BaseDbHelper</strong>: Auxiliares para acesso ao banco Oracle.</li>
        </ul>

        <h2>Programas Instalados</h2>
        <ul>
            <li>Visual Studio 2019 ou superior</li>
            <li>.NET Framework 4.8</li>
            <li>Oracle Database (pode usar imagem Docker)</li>
            <li>Oracle SQL Developer ou cliente Oracle</li>
            <li>Navegador Web</li>
        </ul>

        <h2>Configuração Banco de Dados</h2>
        <p>Será necessário criar as tabelas e procedures que estão em:</p>
        <pre style="background:#f4f4f4; padding:10px; border-radius:4px;">-- scripts/tabelas/  
-- scripts/procedures/</pre>

        <h2>Como Executar</h2>
        <ol>
            <li>Configure a string de conexão com Oracle no arquivo de configuração.</li>
            <li>Compile o projeto no Visual Studio.</li>
            <li>Execute o projeto (F5) e acesse via navegador.</li>
        </ol>

        <h2>Resumo</h2>
        <p>O sistema foi projetado para ser uma solução completa de gerenciamento de pessoas, focando na praticidade, segurança e clareza das informações.</p>
    </div>
    </main>

</asp:Content>
