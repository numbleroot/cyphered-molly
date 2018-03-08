MATCH path = (root:Goal {run: 999})-[*0..]->(:Rule {run: 999})-[*1]->(leaf:Goal {run: 999})
WHERE NOT ()-->(root) AND NOT (leaf)-->()
WITH length(path) AS maxLen
ORDER BY maxLen DESC
LIMIT 1
WITH maxLen

MATCH path = (root:Goal {run: 999})-[*0..]->(rule:Rule {run: 999})-[*1]->(leaf:Goal {run: 999})
WHERE NOT ()-->(root) AND NOT (leaf)-->() AND length(path) = maxLen

WITH DISTINCT rule
MATCH (rule)-[*1]->(leaf:Goal {run: 999})

RETURN rule, collect(leaf) AS leaves;
