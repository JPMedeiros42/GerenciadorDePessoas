using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace GerenciadorDePessoas.Telas
{
    public class Pessoa
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "O campo Nome é obrigatório.")]
        [StringLength(100,MinimumLength = 6, ErrorMessage = "O campo Nome deve ter entre 6 e 100 caracteres.")]
        public string Nome { get; set; }

        public string Cidade { get; set; }

        [EmailAddress(ErrorMessage = "O campo Email deve ser um endereço de e-mail válido.")]
        public string Email { get; set; }

        public string Cep { get; set; }

        public string Endereco { get; set; }

        public string Pais { get; set; }

        [StringLength(100, MinimumLength = 6, ErrorMessage = "O campo Nome deve ter entre 6 e 100 caracteres.")]
        public string Usuario { get; set; }

        [Phone]
        public string Telefone { get; set; }

        [DataType(DataType.Date)]
        public DateTime DataNascimento { get; set; }
        public int CargoId { get; set; }
    }
}