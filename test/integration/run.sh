#/bin/bash
set -x
set -e

GOOS=linux GOARCH=amd64 go build ./cmd/clickhouse-backup
docker-compose -f test/integration/${COMPOSE_FILE:-docker-compose_storage-policy.yml} down
docker-compose -f test/integration/${COMPOSE_FILE:-docker-compose_storage-policy.yml} up -d

# To run integration tests including GCS tests set GCS_TESTS environment variable:
# GCS_TESTS=true go test -tags=integration -v
go test -tags=integration -v test/integration/integration_test.go
# docker-compose -f docker-compose.yml down
