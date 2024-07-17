# CumbucaCli
![CumbucaCli](https://github.com/franknfjr/cumbuca_cli/actions/workflows/ci.yml/badge.svg)

**A ferramenta de linha de comando dos reis e rainhas de Cumbúquia**

## Dependências
- Elixir: **(~> 1.17.2-otp-27)**
- Erlang: **(~> 27.0.0)**


O projeto utiliza como gerenciador de dependencias o [asdf]('https://asdf-vm.com/pt-br/')

### Rodando a CLI localmente

```bash
git clone git@github.com:franknfjr/cumbuca_cli.git && cd cumbuca_cli
```

Caso não tenha instalado as dependências, execute o comando a seguir dentro do diretório do projeto (opcional):

```sh
asdf install
```

### Executando a CLI

Para executar a CLI basta rodar o seguinte comando a baixo:

```sh
./cumbuca_cli
```

### Executando os testes

Para rodar os testes unitarios rode o seguinte comando a baixo:

```sh
mix test
```
