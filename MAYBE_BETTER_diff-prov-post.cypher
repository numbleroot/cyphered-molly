CALL apoc.export.cypher.query("
    MATCH (n:Goal {run: #RUN#, condition: \"post\"})
    WITH collect(n.label) AS failGoals

    MATCH pathSucc = (m:Goal {run: 0, condition: \"post\"})-[*0..]->(l:Goal {run: 0, condition: \"post\"})
    WHERE NOT m.label IN failGoals AND NOT l.label IN failGoals

    RETURN pathSucc;",
    "/tmp/diff-succ-fail.cypher",
    {format:"plain",cypherFormat:"create"}) YIELD file, source, format, nodes, relationships, properties, time

RETURN file, source, format, nodes, relationships, properties, time;

