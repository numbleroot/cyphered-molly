MATCH path = (root:Goal {run: #RUN#})-[*0..]->(:Rule {run: #RUN#})-[*1]->(leaf:Goal {run: #RUN#})
WHERE NOT ()-->(root) AND NOT (leaf)-->()
WITH length(path) AS maxLen
ORDER BY maxLen DESC
LIMIT 1
WITH maxLen

MATCH path = (root:Goal {run: #RUN#})-[*0..]->(rule:Rule {run: #RUN#})-[*1]->(leaf:Goal {run: #RUN#})
WHERE NOT ()-->(root) AND NOT (leaf)-->() AND length(path) = maxLen

WITH DISTINCT rule
MATCH (rule)-[*1]->(leaf:Goal {run: #RUN#})

RETURN rule, collect(leaf) AS leaves;
