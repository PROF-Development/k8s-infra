#!/bin/bash

POD_NAME=$(kubectl get pods -l app=minio -o name | awk -F/ '{print $2}' | head -n 1)
BACKUP_FILE="./backups/minio_data.tar"

mkdir -p ./backups

echo "Упаковываем и копируем данные из MinIO ($POD_NAME)..."

if kubectl exec $POD_NAME -- which tar > /dev/null 2>&1; then
    kubectl exec $POD_NAME -- tar cf - /data > $BACKUP_FILE
else
    echo "Tar не найден. Используем обходной путь через потоковую передачу файлов..."

    echo "Попробуем создать архив с помощью встроенного busybox (если есть):"
    kubectl exec $POD_NAME -- busybox tar cf - /data > $BACKUP_FILE
fi

if [ -s "$BACKUP_FILE" ]; then
    echo "Архив сохранен в $BACKUP_FILE (размер: $(du -h $BACKUP_FILE | cut -f1))"
else
    echo "ОШИБКА: Не удалось создать архив данных."
fi
