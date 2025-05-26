# Gerenciador de Pessoas

Este projeto é um sistema web em ASP.NET Web Forms (.NET Framework 4.8) para gerenciar pessoas, permitindo cadastro, edição, exclusão e busca de registros em um banco de dados Oracle.

## Funcionalidades Principais

### 1. Listagem de Pessoas
- Exibe uma tabela com todas as pessoas cadastradas, mostrando informações como nome, cargo, salário bruto, descontos e salário líquido.
- Permite filtrar a lista por cargo e nome, facilitando a busca por registros específicos.

### 2. CRUD completo de Pessoas
- Possibilita adicionar novos colaboradores ao sistema, preenchendo dados como nome, cargo, e informações de contato.
- Garante que todos os campos obrigatórios sejam preenchidos corretamente.
- Permite alterar os dados de um colaborador já cadastrado.
- Assegura que as informações estejam sempre atualizadas.
- Remove um registro de colaborador do sistema de forma segura.
- Ajuda a manter a base de dados limpa e atualizada.

### 5. Cálculo/Recalculo de Salários
- Botão dedicado para calcular ou recalcular salários dos colaboradores, considerando descontos e regras de negócio.
- Atualiza automaticamente os valores exibidos na tabela.

### 6. Mensagens de Feedback
- Exibe mensagens de sucesso ou erro para informar o usuário sobre o resultado das operações realizadas (cadastro, edição, exclusão, cálculo).
- Melhora a experiência do usuário ao fornecer feedback imediato.

### 7. Interface Responsiva
- Utiliza componentes como UpdatePanel para uma navegação fluida e responsiva.
- Permite o uso eficiente em diferentes tamanhos de tela.

## Tecnologias Utilizadas

- ASP.NET Web Forms (.NET Framework 4.8)
- C# 7.3
- Oracle Managed Data Access (ODP.NET)
- HTML, CSS, JavaScript

## Estrutura Principal

- `ControleDePessoas.aspx.cs`: Code-behind com toda a lógica de manipulação de pessoas.
- `Gerenciador.aspx.cs`: Code-behind com toda a lógica para calculo dos vencimentos.
- `Pessoa`: Classe modelo representando a entidade Pessoa.
- `DbHelper` e `BaseDbHelper`: Classe auxiliar para acesso ao banco de dados Oracle.

## Programas instalados

- Visual Studio 2019 ou superior.
- .NET Framework 4.8.
- Oracle Database (Pode-se utilizar imagem no Docker)
- Oracle SQL Developer ou outro cliente para gerenciar o banco de dados Oracle.
- Navegador Web

## Configuração Banco de Dados

- Será necessário criar as tabelas e as procedures para utilização.
- Elas estão presentes em:
-- scripts/tabelas/
-- scripts/procedures/

## Como Executar

1. Configure a string de conexão com o Oracle no arquivo de configuração.
2. Compile o projeto no Visual Studio.
3. Execute o projeto (F5) e acesse via navegador.

## Resumo

O sistema foi projetado para ser uma solução completa de gerenciamento de pessoas, focando na praticidade, segurança e clareza das informações.


