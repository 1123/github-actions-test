# /bin/bash

set -u -e

TOKEN=$(./get-token.sh | jq -r .access_token)
echo "Retrieved token: $TOKEN"

curl --request POST ${SCHEMA_REGISTRY_URL}/subjects/dummy-topic-value/versions \
  --header 'Confluent-Identity-Pool-Id: '${IDENTITY_POOL_ID} \
  --header 'target-sr-cluster: '${SR_LOGICAL_CLUSTER_ID} \
  --header 'Authorization: Bearer '${TOKEN} \
  --header 'Accept: application/vnd.schemaregistry.v1+json, application/vnd.schemaregistry+json, application/json' \
  --header 'Content-Type: application/vnd.schemaregistry.v1+json' \
  --data '{"schema": "{\"type\": \"string\"}"}' 
