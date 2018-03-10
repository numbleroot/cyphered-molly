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
WITH rule.table AS rule, collect(leaf) AS leaves

UNWIND leaves AS leaf
WITH rule, leaf.table AS missingEvent, split(split(leaf.label, ", ")[-1], ")")[0] AS missingTime
WITH rule, '<code>' + missingEvent + '</code>' + '@' + '<code>' + missingTime + '</code>' AS missingLeaf
WITH rule, collect(missingLeaf) AS missingLeaves
WITH rule, reduce(s = '', l IN missingLeaves | s + l + '; ') AS missingLeaves

RETURN rule, missingLeaves;
