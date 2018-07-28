#!/bin/sh
curl -i -H accept:application/json -H content-type:application/json --user neo4j:M@nchesterUn7ted -XPOST http://localhost:7474/db/data/transaction/commit -d @movieImport.json
