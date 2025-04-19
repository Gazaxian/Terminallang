#!/bin/bash

# Função para escolher o arquivo de anotações usando fzf
escolher_arquivo() {
    # Diretório onde os arquivos de anotações estão armazenados
    diretorio="$HOME/Documentos/terminallang"

    # Usando fzf para selecionar um arquivo
    ARQUIVO=$(find "$diretorio" -type f -name "*.txt" | fzf)

    # Verifica se foi selecionado um arquivo
    if [[ -z "$ARQUIVO" ]]; then
        echo -e "${VERMELHO}Nenhum arquivo selecionado.${RESET}"
        exit 1
    fi
    echo -e "${AZUL}Arquivo selecionado: $ARQUIVO${RESET}"
}

# Cores
BRANCO="\e[97m"
AZUL="\e[34m"
VERDE="\e[32m"
VERMELHO="\e[31m"
AMARELO="\e[33m"
LARANJA="\e[38;5;214m"
RESET="\e[0m"

# Variável para o limite de frases por página
limite=5

# Escolher o arquivo automaticamente ao iniciar o script
escolher_arquivo

# Função para exibir o menu principal
mostrar_menu() {
    clear
    echo -e "\n📚 ${BRANCO}Terminallang - Anotações de Frases Ilimitadas${RESET}\n"
    echo -e "${AZUL}1) ✏️ Adicionar frases${RESET}"
    echo -e "${VERDE}2) 📖 Ver todas as frases${RESET}"
    echo -e "${AMARELO}3) 🔍 Pesquisar frases${RESET}"
    echo -e "${CINZA}4) 🗂️ Escolher arquivo de anotações${RESET}"  # Cor da opção de escolher arquivo
    echo -e "${VERMELHO}5) 🧹 Limpar terminal${RESET}"
    echo -e "${VERMELHO}6) ❌ Sair${RESET}"
    read -p "Escolha uma opção: " opcao
}

# Adicionar frases ao arquivo (evitando duplicatas)
adicionar_frases() {
    echo -e "${AZUL}Digite frases (inclua a pronúncia entre () e a tradução entre [])."
    echo -e "Pressione Enter sem digitar nada para sair.${RESET}"

    while true; do
        read -p "Frase: " frase
        [[ -z "$frase" ]] && break  # Sai do loop se a entrada estiver vazia
        
        # Verifica se a frase já existe no arquivo
        if grep -Fxq "$frase" "$ARQUIVO"; then
            echo -e "${VERMELHO}⚠️ Frase já cadastrada!${RESET}"
        else
            echo "$frase" >> "$ARQUIVO"
            echo -e "${VERDE}✅ Frase salva!${RESET}"
        fi
    done
}

# Exibir frases salvas com paginação
exibir_frases() {
    if [[ -s "$ARQUIVO" ]]; then
        mapfile -t frases < "$ARQUIVO"
        total=${#frases[@]}
        pagina=0
        total_paginas=$(( (total + limite - 1) / limite ))

        while true; do
            clear
            inicio=$((pagina * limite))
            fim=$((inicio + limite))
            if [[ $fim -gt $total ]]; then
                fim=$total
            fi

            echo -e "📖 ${BRANCO}Frases salvas:${RESET}\n"
            for ((i=inicio; i<fim; i++)); do
                linha="${frases[i]}"
                frase=$(echo "$linha" | sed -E 's/\(.*\)//' | sed -E 's/\[.*\]//')
                pronuncia=$(echo "$linha" | grep -oP '\(.*?\)')
                traducao=$(echo "$linha" | grep -oP '\[.*?\]')

                echo -e "${BRANCO}Frase: $frase${RESET}"
                [[ -n "$pronuncia" ]] && echo -e "${AZUL}Pronúncia: $pronuncia${RESET}"
                [[ -n "$traducao" ]] && echo -e "${VERDE}Tradução: $traducao${RESET}"
                echo -e "----------------------------------"
            done

            echo -e "${AZUL}Página $((pagina + 1))/$total_paginas${RESET}"
            echo -e "[N] Próxima página | [P] Página anterior | [L] Alterar limite | [Q] Sair"
            read -n 1 -s resposta
            case "$resposta" in
                n|N) [[ $pagina -lt $((total_paginas - 1)) ]] && ((pagina++)) ;;
                p|P) [[ $pagina -gt 0 ]] && ((pagina--)) ;;
                l|L) alterar_limite ;;  # Chama a função para alterar o limite
                q|Q) clear; break ;;
            esac
        done
    else
        echo -e "${VERMELHO}Nenhuma frase adicionada ainda.${RESET}"
    fi
}

# Pesquisar frases por palavra-chave
pesquisar_frases() {
    echo -e "${AZUL}Digite o termo de busca:${RESET}"
    read termo

    # Usa uma expressão regular para garantir que o termo seja isolado (não parte de outra palavra)
    mapfile -t resultados < <(grep -i -E "\b$termo\b" "$ARQUIVO" 2>/dev/null)
    
    if [[ ${#resultados[@]} -eq 0 ]]; then
        echo -e "${VERMELHO}Nenhuma frase encontrada.${RESET}"
    else
        total=${#resultados[@]}
        pagina=0
        total_paginas=$(( (total + limite - 1) / limite ))
        
        while true; do
            clear
            inicio=$((pagina * limite))
            fim=$((inicio + limite))
            if [[ $fim -gt $total ]]; then
                fim=$total
            fi
            
            echo -e "🔎 ${BRANCO}Resultados encontrados: $total${RESET}\n"
            for ((i=inicio; i<fim; i++)); do
                linha="${resultados[i]}"
                frase=$(echo "$linha" | sed -E 's/\(.*\)//' | sed -E 's/\[.*\]//')
                pronuncia=$(echo "$linha" | grep -oP '\(.*?\)')
                traducao=$(echo "$linha" | grep -oP '\[.*?\]')

                echo -e "${BRANCO}Frase: $frase${RESET}"
                [[ -n "$pronuncia" ]] && echo -e "${AZUL}Pronúncia: $pronuncia${RESET}"
                [[ -n "$traducao" ]] && echo -e "${VERDE}Tradução: $traducao${RESET}"
                echo -e "----------------------------------"
            done
            
            echo -e "${AZUL}Página $((pagina + 1))/$total_paginas${RESET}"
            echo -e "[N] Próxima página | [P] Página anterior | [L] Alterar limite | [Q] Sair"
            read -n 1 -s resposta
            case "$resposta" in
                n|N) [[ $pagina -lt $((total_paginas - 1)) ]] && ((pagina++)) ;;
                p|P) [[ $pagina -gt 0 ]] && ((pagina--)) ;;
                l|L) alterar_limite ;;  # Chama a função para alterar o limite
                q|Q) clear; break ;;
            esac
        done
    fi
}

# Limpar terminal
limpar_terminal() {
    clear
    echo -e "${VERDE}Terminal limpo!${RESET}"
}

# Alterar limite de frases por página
alterar_limite() {
    echo -e "${LARANJA}Digite o novo limite de frases por página (número positivo):${RESET}"
    read novo_limite
    if [[ "$novo_limite" =~ ^[0-9]+$ ]] && [ "$novo_limite" -gt 0 ]; then
        limite=$novo_limite
        echo -e "${VERDE}Limite de frases por página alterado para $limite!${RESET}"
    else
        echo -e "${VERMELHO}Valor inválido! Por favor, insira um número positivo.${RESET}"
    fi
}

# Menu principal
while true; do
    mostrar_menu  # Exibe o menu
    case $opcao in
        1) adicionar_frases ;;
        2) exibir_frases ;;
        3) pesquisar_frases ;;
        4) escolher_arquivo ;;  # Chama a função para escolher o arquivo
        5) limpar_terminal ;;  # Chama a função para limpar o terminal
        6) echo -e "${VERMELHO}Saindo...${RESET}"; exit 0 ;;
        *) echo -e "${VERMELHO}Opção inválida!${RESET}" ;;
    esac
done
