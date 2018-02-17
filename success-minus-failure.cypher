CALL apoc.export.cypher.query("
    MATCH pathFail = (rootFail:Goal {run: 2})-[*0..]->(:Goal {run: 2})
    WHERE NOT ()-->(rootFail)
    WITH reduce(s = '', n IN NODES(pathFail) | s + '(' + n.label + ');') AS stringFail, length(pathFail) AS lenFail
    ORDER BY lenFail DESC
    WITH collect(stringFail) AS failPaths

    MATCH pathSucc = (rootSucc:Goal {run: 0})-[*0..]->(:Goal {run: 0})
    WHERE NOT ()-->(rootSucc)
    WITH pathSucc, reduce(s = '', n IN NODES(pathSucc) | s + '(' + n.label + ');') AS stringSucc, LENGTH(pathSucc) AS lenSucc, failPaths
    ORDER BY lenSucc DESC

    WITH pathSucc, stringSucc, failPaths, reduce(found = 0, fPath IN failPaths | (CASE WHEN stringSucc CONTAINS fPath THEN found + 1 ELSE found + 0 END)) AS found
    WITH CASE WHEN found = 0 THEN pathSucc ELSE '' END AS path

    WITH filter(p IN collect(path) WHERE NOT p = '') AS diffPaths
    RETURN diffPaths;",
    "/tmp/diff-succ-fail.cypher",
    {format:"plain",cypherFormat:"create"}) YIELD file, source, format, nodes, relationships, properties, time

RETURN file, source, format, nodes, relationships, properties, time;
