CALL apoc.export.cypher.query("
    MATCH path1 = (root1:Goal {run: 1})-[*0..]->(leaf1:Goal {run: 1})
    WHERE NOT ()-->(root1)
    WITH reduce(s = '', n IN NODES(path1) | s + '(' + n.label + ');') AS string1, length(path1) AS len1
    ORDER BY len1 DESC
    WITH collect(string1) AS failPaths

    MATCH path0 = (root0:Goal {run:0})-[*0..]->(leaf0:Goal {run:0})
    WHERE NOT ()-->(root0)
    WITH path0, reduce(s = '', n IN NODES(path0) | s + '(' + n.label + ');') AS string0, LENGTH(path0) AS len0, failPaths
    ORDER BY len0 DESC

    WITH path0, string0, failPaths, reduce(found = 0, fPath IN failPaths | (CASE WHEN string0 CONTAINS fPath THEN found + 1 ELSE found + 0 END)) AS found
    WITH CASE WHEN found = 0 THEN path0 ELSE '' END AS path

    WITH filter(p IN collect(path) WHERE NOT p = '') AS diffPaths
    RETURN diffPaths",
    "/tmp/diff-succ-fail1.cypher",
    {format:"plain",cypherFormat:"create"}) YIELD file, source, format, nodes, relationships, properties, time

RETURN file, source, format, nodes, relationships, properties, time;
