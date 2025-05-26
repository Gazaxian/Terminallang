# Terminallang

**Terminallang** é uma ferramenta prática e eficaz para o aprendizado de idiomas diretamente no terminal. Com este script, você pode registrar, revisar e organizar frases em diferentes idiomas, ajudando a melhorar seu vocabulário e fluência. Ideal para quem prefere utilizar o terminal para manter suas anotações e revisões de maneira simples e rápida.

Existem duas versões do script para diferentes necessidades:

* **Versão 1:** Arquivo fixo de anotações configurado no script.
* **Versão 2:** Seleção interativa do arquivo de anotações usando `fzf`.

---

## Funcionalidades Comuns

* **Adicionar frases:** Adicione frases com pronúncia e tradução, evitando duplicatas.
* **Revisar frases:** Exiba as frases salvas com paginação, facilitando a navegação e revisão.
* **Pesquisar frases:** Localize frases rapidamente por palavras-chave.
* **Alterar limite de frases por página:** Ajuste quantas frases aparecem por página na visualização e pesquisa.
* **Sair:** Encerre o programa de forma segura.

---

## Diferenças entre as versões

| Funcionalidade        | Versão 1 (Arquivo fixo)                                  | Versão 2 (Seleção com fzf)                             |
| --------------------- | -------------------------------------------------------- | ------------------------------------------------------ |
| Seleção do arquivo    | Não, arquivo fixo definido no script (`~/anotacoes.txt`) | Sim, você escolhe o arquivo `.txt` com interface `fzf` |
| Simplicidade          | Mais simples e direta                                    | Mais flexível e poderosa                               |
| Requisitos adicionais | Não precisa de `fzf`                                     | Precisa do `fzf` instalado                             |

---

## Como Usar

### Menu Principal

Após iniciar o script, você verá um menu com as seguintes opções:

* `1) ✏️ Adicionar frases`: Para adicionar novas frases.
* `2) 📖 Ver todas as frases`: Para visualizar todas as frases salvas com paginação.
* `3) 🔍 Pesquisar frases`: Para buscar frases com base em uma palavra-chave.
* `4) 📊 Alterar limite de frases por página`: Ajuste quantas frases aparecem por página.
* `5) ❌ Sair`: Para sair do script.

Digite o número correspondente para escolher.

---

### 1. Adicionar Frases

Digite uma frase com a pronúncia entre parênteses e a tradução entre colchetes, por exemplo:

```
I am learning English. (ai ãm lêrning inglix) [Eu estou aprendendo inglês.]
```

O script verifica se a frase já existe para evitar duplicatas e salva apenas frases novas.

---

### 2. Ver Todas as Frases

Visualize todas as frases paginadas. Navegue entre páginas com as opções:

* `N` Próxima página
* `P` Página anterior
* `L` Alterar limite de frases por página
* `G` Ir para uma página específica
* `Q` Sair da visualização

---

### 3. Pesquisar Frases

Digite um termo para buscar. As frases contendo esse termo serão exibidas paginadas, com as mesmas opções de navegação da exibição geral.

---

### 4. Alterar Limite de Frases por Página

Digite um número positivo para definir quantas frases quer visualizar por página nas funções de revisão e pesquisa.

---

### 5. Sair

Encerra o script.

---

## Personalizações

### Alterando o Local de Armazenamento (Versão 1)

As frases são armazenadas no arquivo `~/anotacoes.txt` por padrão. Para alterar o arquivo, modifique a variável `ARQUIVO` no início do script:

```bash
ARQUIVO="$HOME/minhas_anotacoes.txt"
```

---

## Como Rodar o Script

### Para a Versão 1 (arquivo fixo)

1. Clone o repositório:

   ```bash
   git clone https://github.com/Gazaxian/Terminallang.git
   cd Terminallang
   ```

2. Dê permissão de execução:

   ```bash
   chmod +x terminallang.sh
   ```

3. Execute:

   ```bash
   ./terminallang.sh
   ```

---

### Para a Versão 2 (com fzf)

1. Certifique-se que o `fzf` está instalado no seu sistema.

2. Clone o repositório:

   ```bash
   git clone https://github.com/Gazaxian/Terminallang.git
   cd Terminallang
   ```

3. Dê permissão de execução:

   ```bash
   chmod +x terminallang+fzf.sh
   ```

4. Execute:

   ```bash
   ./terminallang+fzf.sh
   ```

---

## Exemplo de Uso

### Adicionando uma frase

* Execute o script.
* No menu principal, escolha `1) ✏️ Adicionar frases`.
* Digite:

```
I love programming. (ai lóv prógrãming) [Eu amo programar.]
```

* O script confirmará que a frase foi salva.

### Pesquisando por um termo

* Escolha `3) 🔍 Pesquisar frases`.
* Digite a palavra-chave, por exemplo: `programming`.
* Veja as frases que a contém.

### Navegando entre páginas

* Use as teclas indicadas para avançar, retroceder ou ir para uma página específica.

---

## Requisitos

* Sistema operacional Linux, macOS ou Windows com suporte a Bash.
* Bash e comandos comuns (`grep`, `sed`, `mkdir`, `echo`).
* Para a Versão 2, o utilitário `fzf` instalado (ex: `sudo apt install fzf`).

---

## Licença

Este projeto está licenciado sob a **MIT License**. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
