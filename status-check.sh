#!/bin/bash

echo "=== AppMonitor - Verificação de Status ==="
echo "Data/Hora: $(date)"
echo ""

apps=("api-alunos" "api-professores" "frontend-infnet" "dashboard-infnet")

status_codes=(200 200 200 200 404 500 400 408)

for app in "${apps[@]}"; do
    random_index=$((RANDOM % ${#status_codes[@]}))
    status_code=${status_codes[$random_index]}
    
    case $status_code in
        200)
            echo "[OK] $app: ONLINE (Status: $status_code)"
            ;;
        404)
            echo "[ERROR] $app: NÃO ENCONTRADO (Status: $status_code)"
            ;;
        500)
            echo "[ERROR] $app: ERRO INTERNO DO SERVIDOR (Status: $status_code)"
            ;;
        400)
            echo "[ERROR] $app: REQUISIÇÃO INVÁLIDA (Status: $status_code)"
            ;;
        408)
            echo "[ERROR] $app: TIMEOUT (Status: $status_code)"
            ;;
        *)
            echo "[ERROR] $app: STATUS DESCONHECIDO (Status: $status_code)"
            ;;
    esac
done

echo ""
echo "Verificação Finalizada!"