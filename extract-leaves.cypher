MATCH path = (root:Goal {run: 999})-[*0..]->(rule:Rule {run: 999})-[*1]->(leaf:Goal {run: 999})
WHERE NOT ()-->(root) AND NOT (leaf)-->()
WITH path, rule, length(path) AS pLen
ORDER BY pLen DESC

WITH DISTINCT rule
MATCH (rule)-[*1]->(leaf:Goal {run: 999})

RETURN rule, collect(leaf) AS leaves;
