#!/bin/bash
# This script is used to seed data from mongodb/ to a mongodb docker image.
# Used for tests to ensure things work as intended.

for filename in /docker-entrypoint-initdb.d/mongodb/*.json; do
    [ -e "$filename" ] || continue

    mongoimport -d ${MONGO_INITDB_DATABASE} --drop $filename
done
