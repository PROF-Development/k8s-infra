#!/bin/bash

mkdir -p ./backups

POSTGRES_PODS=(
    "postgres-personal-0:personal"
    "postgres-prof-assistant-0:prof-assistant"
    "postgres-schedule-api-0:schedule-api"
)

echo "--- Начинаем дамп баз данных ---"

for entry in "${POSTGRES_PODS[@]}"; do
    POD="${entry%%:*}"
    NAME="${entry#*:}"

    echo "Dumping $POD..."

    kubectl exec $POD -- env PGPASSWORD=pass pg_dump -U user -d postgres > "./backups/${NAME}_backup.sql"

    if [ $? -eq 0 ]; then
        echo "Успешно: ./backups/${NAME}_backup.sql"
    else
        echo "ОШИБКА при дампе $POD"
    fi
done

echo "--- Все дампы готовы ---"
