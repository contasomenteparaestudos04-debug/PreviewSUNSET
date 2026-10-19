# Sunset - preview no Codespaces

Copia separada do sistema (igual a Pasta 5 do PIM) so para ver o site no navegador, no desktop e no celular, sem rodar nada no computador.

## Como usar

1. Crie um repositorio novo no GitHub (pode ser privado) e suba o conteudo desta pasta.
2. No repositorio: botao verde **Code > Codespaces > Create codespace on main**. Na primeira vez demora uns minutos (baixa o .NET e o SQL Server e cria o banco).
3. No terminal do Codespace: `bash rodar-web.sh`
4. Aba **Ports (Portas)**: clique no globo da porta **5157** para abrir o site.

## Ver no celular

- Na aba Ports, clique com o botao direito na porta 5157 > **Port Visibility > Public** (ou Private e abrir logado na mesma conta pelo celular) e abra o link no celular.
- Ou, no desktop, abra o site e aperte F12 > icone de celular (modo dispositivo).

## Logins

- Cliente: `bruno.os@outlook.com` / `Senha1234`
- Admin: `admin@sunset.com` / `Admin@1234`

## Observacoes

- Quando o Codespace desligar, o site sai do ar. Ao ligar de novo, rode `bash rodar-web.sh`.
- A connection string vem da variavel de ambiente do `devcontainer.json`; o codigo nao foi alterado.
- O app Flutter (`sunset_app/`) nao e executado aqui.

## Diferenca em relacao a Pasta 5

Somente `Sunset.Web/Program.cs`: o login e o acesso negado redirecionam por caminho relativo (bloco `Events` do cookie). Isso e necessario porque o proxy do Codespaces entrega o pedido com o endereco `localhost`. Nao copie essa mudanca para as pastas do PIM.
