#!/bin/bash

OUTPUT="deployment-all-prod.yaml"
NAMESPACE="default"

echo "# Финальный манифест для ПРОДа" > $OUTPUT

cat <<EOF >> $OUTPUT
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: minio-pvc
  namespace: $NAMESPACE
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
EOF

RESOURCES="deployments statefulsets svc configmap ingress secrets middleware"
echo "Экспортируем ресурсы..."

for res in $RESOURCES; do
  names=$(kubectl get $res -n $NAMESPACE -o name | grep -v "kubernetes" | grep -v "cert-manager")

  for name in $names; do
    echo "---" >> $OUTPUT
    kubectl get $name -n $NAMESPACE -o yaml >> $OUTPUT
  done
done

echo "Чистим мусор и правим домены..."

sed -i '/uid:/d; /resourceVersion:/d; /creationTimestamp:/d; /generation:/d; /selfLink:/d' $OUTPUT
sed -i '/managedFields:/,/^[^ ]/ { /^[^ ]/!d }' $OUTPUT
sed -i '/status:/,/^[^ ]/ { /^[^ ]/!d }' $OUTPUT

sed -i '/type: kubernetes.io\/tls/,/---/d' $OUTPUT

sed -i '/hostPath:/,/path: \/var\/lib\/minio/c\        persistentVolumeClaim:\n          claimName: minio-pvc' $OUTPUT
sed -i '/type: DirectoryOrCreate/d' $OUTPUT

sed -i 's/test-api\.prof-stankin\.ru/api.prof-stankin.ru/g' $OUTPUT
sed -i 's/\.test\.prof-stankin\.ru/.prof-stankin.ru/g' $OUTPUT
sed -i 's/\btest\.prof-stankin\.ru/prof-stankin.ru/g' $OUTPUT
sed -i 's/minio\.test\.prof-stankin\.ru/minio.prof-stankin.ru/g' $OUTPUT

echo "Готово! Проверяй файл $OUTPUT"
