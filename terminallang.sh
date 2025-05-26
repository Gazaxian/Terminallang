#!/bin/bash

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

# Defina aqui o arquivo fixo de anotações
ARQUIVO="$HOME/anotacoes.txt"

# Verifica se o arquivo existe
if [[ ! -f "$ARQUIVO" ]]; then
    echo -e "${VERMELHO}Arquivo não encontrado: $ARQUIVO${RESET}"
    exit 1
fi

echo -e "${AZUL}Arquivo usado: $ARQUIVO${RESET}"

# Função para exibir o menu principal
mostrar_menu() {
    clear
    echo -e "\n📚 ${BRANCO}Terminallang - Anotações de Frases Ilimitadas${RESET}\n"
    echo -e "${AZUL}1) ✏️ Adicionar frases${RESET}"
    echo -e "${VERDE}2) 📖 Ver todas as frases${RESET}"
    echo -e "${AMARELO}3) 🔍 Pesquisar frases${RESET}"
    echo -e "${VERMELHO}4) ❌ Sair${RESET}"
    read -p "Escolha uma opção: " opcao
}

# Adicionar frases ao arquivo
adicionar_frases() {
    echo -e "${AZUL}Digite frases (inclua a pronúncia entre () e a tradução entre [])."
    echo -e "Pressione Enter sem digitar nada para sair.${RESET}"

    while true; do
        read -p "Frase: " frase
        [[ -z "$frase" ]] && break
        if grep -Fxq "$frase" "$ARQUIVO"; then
            echo -e "${VERMELHO}⚠️ Frase já cadastrada!${RESET}"
        else
            echo "$frase" >> "$ARQUIVO"
            echo -e "${VERDE}✅ Frase salva!${RESET}"
        fi
    done
}

# Exibir frases salvas com paginação e ir para página
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
            [[ $fim -gt $total ]] && fim=$total

            echo -e "📖 ${BRANCO}Frases salvas:${RESET}\n"
            for ((i=inicio; i<fim; i++)); do
                linha="${frases[i]}"
                frase=$(echo "$linha" | sed -E 's/\(.*\)//' | sed -E 's/\[.*\]//' | awk '{$1=$1;print}')
                pronuncia=$(echo "$linha" | grep -oP '\(.*?\)')
                traducao=$(echo "$linha" | grep -oP '\[.*?\]')

                echo -e "${BRANCO}Frase: $frase${RESET}"
                [[ -n "$pronuncia" ]] && echo -e "${AZUL}Pronúncia: $pronuncia${RESET}"
                [[ -n "$traducao" ]] && echo -e "${VERDE}Tradução: $traducao${RESET}"
                echo -e "----------------------------------"
            done

            echo -e "${AZUL}Página $((pagina + 1))/$total_paginas${RESET}"
            echo -e "[N] Próxima | [P] Anterior | [L] Limite | [G] Ir para página | [Q] Sair"
            read -n 1 -s resposta
            case "$resposta" in
                n|N) [[ $pagina -lt $((total_paginas - 1)) ]] && ((pagina++)) ;;
                p|P) [[ $pagina -gt 0 ]] && ((pagina--)) ;;
                l|L) alterar_limite ;;
                g|G)
                    echo -e "\n${LARANJA}Digite o número da página (1 a $total_paginas):${RESET}"
                    read pagina_desejada
                    if [[ "$pagina_desejada" =~ ^[0-9]+$ ]] && (( pagina_desejada >= 1 && pagina_desejada <= total_paginas )); then
                        pagina=$((pagina_desejada - 1))
                    else
                        echo -e "${VERMELHO}Número inválido!${RESET}"
                        sleep 1
                    fi
                    ;;
                q|Q) clear; break ;;
            esac
        done
    else
        echo -e "${VERMELHO}Nenhuma frase adicionada ainda.${RESET}"
    fi
}

# Pesquisar frases
pesquisar_frases() {
    echo -e "${AZUL}Digite o termo de busca:${RESET}"
    read termo

    mapfile -t resultados < <(grep -i -E "(^|[^a-zA-Z])$termo([^a-zA-Z]|$)" "$ARQUIVO" 2>/dev/null)

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
            [[ $fim -gt $total ]] && fim=$total

            echo -e "🔎 ${BRANCO}Resultados encontrados: $total${RESET}\n"
            for ((i=inicio; i<fim; i++)); do
                linha="${resultados[i]}"
                frase=$(echo "$linha" | sed -E 's/\(.*\)//' | sed -E 's/\[.*\]//' | awk '{$1=$1;print}')
                pronuncia=$(echo "$linha" | grep -oP '\(.*?\)')
                traducao=$(echo "$linha" | grep -oP '\[.*?\]')

                echo -e "${BRANCO}Frase: $frase${RESET}"
                [[ -n "$pronuncia" ]] && echo -e "${AZUL}Pronúncia: $pronuncia${RESET}"
                [[ -n "$traducao" ]] && echo -e "${VERDE}Tradução: $traducao${RESET}"
                echo -e "----------------------------------"
            done

            echo -e "${AZUL}Página $((pagina + 1))/$total_paginas${RESET}"
            echo -e "[N] Próxima | [P] Anterior | [L] Limite | [G] Ir para página | [Q] Sair"
            read -n 1 -s resposta
            case "$resposta" in
                n|N) [[ $pagina -lt $((total_paginas - 1)) ]] && ((pagina++)) ;;
                p|P) [[ $pagina -gt 0 ]] && ((pagina--)) ;;
                l|L) alterar_limite ;;
                g|G)
                    echo -e "\n${LARANJA}Digite o número da página (1 a $total_paginas):${RESET}"
                    read pagina_desejada
                    if [[ "$pagina_desejada" =~ ^[0-9]+$ ]] && (( pagina_desejada >= 1 && pagina_desejada <= total_paginas )); then
                        pagina=$((pagina_desejada - 1))
                    else
                        echo -e "${VERMELHO}Número inválido!${RESET}"
                        sleep 1
                    fi
                    ;;
                q|Q) clear; break ;;
            esac
        done
    fi
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

# Loop principal
while true; do
    mostrar_menu
    case $opcao in
        1) adicionar_frases ;;
        2) exibir_frases ;;
        3) pesquisar_frases ;;
        4) echo -e "${VERMELHO}Saindo...${RESET}"; exit 0 ;;
        *) echo -e "${VERMELHO}Opção inválida!${RESET}" ;;
    esac
done
