#doc https://github.com/jo/couchdb-best-practices#basics

#build docker admin image

#add database
docker run --net=host --rm couchdb-admin couchdb-ensure http://localhost:5984/test

