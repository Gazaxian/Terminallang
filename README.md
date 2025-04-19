# Terminallang

**Terminallang** é uma ferramenta prática e eficaz para o aprendizado de idiomas diretamente no terminal. Com este script, você pode registrar, revisar e organizar frases em diferentes idiomas, ajudando a melhorar seu vocabulário e fluência. Ideal para quem prefere utilizar o terminal para manter suas anotações e revisões de maneira simples e rápida.

## Funcionalidades

- **Adicionar frases**: Adicione frases com pronúncia e tradução, evitando duplicatas.
- **Revisar frases**: Exiba as frases salvas com paginação, facilitando a navegação e revisão.
- **Pesquisar frases**: Localize frases rapidamente por palavras-chave.
- **Limpar o terminal**: Mantenha o terminal organizado com uma opção para limpar a tela.

## Como Usar

### 1. Menu Principal
Após iniciar o script, você verá um menu com as seguintes opções:

- `1) ✏️ Adicionar frases`: Para adicionar novas frases.
- `2) 📖 Ver todas as frases`: Para visualizar todas as frases salvas com paginação.
- `3) 🔍 Pesquisar frases`: Para buscar frases com base em uma palavra-chave.
- `4) 🧹 Limpar terminal`: Para limpar a tela e manter o ambiente de trabalho limpo.
- `5) ❌ Sair`: Para sair do script.

Escolha uma opção digitando o número correspondente.

### 2. Adicionar Frases
Para adicionar uma frase, digite a frase em inglês, seguida pela pronúncia entre parênteses e a tradução entre colchetes. Exemplo:

```
I am learning English. (ai ãm lêrning inglix) [Eu estou aprendendo inglês.]
```

O script verifica automaticamente se a frase já foi adicionada anteriormente, evitando duplicação de entradas. Se a frase for nova, ela será salva no arquivo.

### 3. Ver Todas as Frases
Você pode visualizar todas as frases salvas, com a opção de navegar pelas páginas. O número de frases por página pode ser alterado a qualquer momento dentro do menu de páginas, facilitando a navegação, especialmente se você tiver muitas frases.

### 4. Pesquisar Frases
Digite um termo de busca para localizar rapidamente as frases que contêm esse termo. Por exemplo, se você quer encontrar todas as frases que mencionam "learning", basta digitar:

```
learning
```

O script irá exibir as frases relevantes com o termo encontrado.

### 5. Limpar o Terminal
Use esta opção para limpar a tela do terminal e manter o ambiente de trabalho organizado.

## Personalizações

### Alterando o Local de Armazenamento
As frases são armazenadas no arquivo `~/anotacoes.txt`. Caso deseje mudar o local ou nome do arquivo, edite a variável `ARQUIVO` no início do script:

```bash
ARQUIVO="$HOME/minhas_anotacoes.txt"
```

## Como Rodar o Script

1. **Clone o Repositório**:
   ```bash
   git clone https://github.com/Gazaxian/Terminallang.git
   ```

2. **Dê Permissão de Execução ao Script**:
   ```bash
   chmod +x terminallang.sh
   ```

3. **Execute o Script**:
   ```bash
   ./terminallang.sh
   ```

## Exemplo de Uso

Aqui está um exemplo de como você pode adicionar uma frase:

1. Execute o script.
2. No menu principal, selecione `1) ✏️ Adicionar frases`.
3. Digite uma frase com a pronúncia e tradução. Exemplo:
   ```
   I love programming. (ai lóv prógrãming) [Eu amo programar.]
   ```
4. O script irá confirmar que a frase foi salva, e você pode continuar adicionando ou sair pressionando `Enter` sem digitar nada.

### Pesquisar por Termo:
1. No menu principal, selecione `3) 🔍 Pesquisar frases`.
2. Digite o termo que deseja buscar (por exemplo, "programming").
3. O script exibirá todas as frases que contêm o termo "programming".

## Requisitos

- **Linux, macOS ou Windows** com suporte a Bash.
- **Bash**: O script utiliza comandos padrões do Bash como `grep`, `sed`, `mkdir` e `echo`.
- **Editor de texto** (opcional, para editar o arquivo de anotações).

## Licença

Este projeto está licenciado sob a **MIT License**. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
