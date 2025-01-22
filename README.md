# msc-research-stuff
My MS.c Research Unstructured Stuff - Only tests and poc codebases 


## Transactions 

```bash
curl -X POST http://shard-router.cluster.io:30080/transactions -H "id_client: bb7a3d9f-8405-44ae-99ae-914183281be7" -H "Content-type: application/json" -d '{"amount": 100, "type": "c", "description": "teste"}'
```

```bash
curl -X GET http://shard-router.cluster.io:30080/statements -H "id_client: bb7a3d9f-8405-44ae-99ae-914183281be7"
```


```bash
curl -X POST http://shard-router.cluster.io:30080/transactions -H "id_client: e50c4b86-38af-44f8-93eb-034acbc1c01b" -H "Content-type: application/json" -d '{"amount": 100, "type": "c", "description": "teste"}'
```

```bash
curl -X GET http://shard-router.cluster.io:30080/statements -H "id_client: e50c4b86-38af-44f8-93eb-034acbc1c01b"
```

```bash
curl -X POST http://shard-router.cluster.io:30080/transactions -H "id_client: a5a2cdc7-a002-483e-8fcd-340b9dfee532" -H "Content-type: application/json" -d '{"amount": 100, "type": "c", "description": "teste"}'
```

```bash
curl -X GET http://shard-router.cluster.io:30080/statements -H "id_client: a5a2cdc7-a002-483e-8fcd-340b9dfee532"
```