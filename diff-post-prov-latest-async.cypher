MATCH (roots:Goal {run: #RUN#})
WHERE NOT ()-->(roots)
WITH size(collect(roots)) AS numRoots

MATCH path = (root:Goal {run: #RUN#})-[*0..]->(asyncGoal:Goal {run: #RUN#})-[*1]->(asyncRule:Rule {run: #RUN#})-[*1]->(asyncClock:Goal {table: "clock", run: #RUN#})
WHERE NOT ()-->(root) AND NOT asyncClock.label =~ '.*__WILDCARD__.*' AND asyncGoal.table IN #ASYNC_RULES_LIST#
WITH asyncGoal, asyncRule, asyncClock, length(path) AS pLen, numRoots
ORDER BY pLen ASC
LIMIT 1

WITH split(split(asyncGoal.label, "(")[1], ",")[0] AS node, asyncGoal.table AS rule, split(split(asyncGoal.label, ", ")[-1], ")")[0] AS eventTime, split(split(asyncClock.label, "(")[1], ",")[0] AS sender, numRoots

RETURN node, rule, eventTime, sender, numRoots;
