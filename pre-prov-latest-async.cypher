MATCH path = (root:Goal {run: #RUN#, condition: "pre"})-[*0..]->(asyncGoal:Goal {run: #RUN#, condition: "pre"})-[*1]->(asyncRule:Rule {run: #RUN#, condition: "pre"})-[*1]->(asyncClock:Goal {run: #RUN#, table: "clock", condition: "pre"})
WHERE NOT ()-->(root) AND NOT asyncClock.label =~ '.*__WILDCARD__.*' AND asyncGoal.table IN #ASYNC_RULES_LIST#
WITH asyncGoal, asyncRule, asyncClock, length(path) AS pLen
ORDER BY pLen ASC
LIMIT 1

WITH split(split(asyncGoal.label, "(")[1], ",")[0] AS node, asyncGoal.table AS rule, split(split(asyncClock.label, ", ")[-2], ")")[0] AS startTime, split(split(asyncClock.label, ", ")[-1], ")")[0] AS endTime, split(split(asyncClock.label, "(")[1], ",")[0] AS sender

RETURN node, rule, startTime, endTime, sender;
