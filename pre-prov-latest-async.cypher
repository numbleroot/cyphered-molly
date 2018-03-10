MATCH path = (root:Goal {run: #RUN#, condition: "pre"})-[*0..]->(asyncGoal:Goal {run: #RUN#, condition: "pre"})-[*1]->(asyncRule:Rule {run: #RUN#, condition: "pre"})-[*1]->(:Goal)
WHERE NOT ()-->(root) AND asyncGoal.table IN #ASYNC_RULES_LIST#
WITH path, asyncGoal, asyncRule, length(path) AS pLen
ORDER BY pLen ASC
LIMIT 1
WITH path, asyncGoal, asyncRule, pLen

MATCH resPath = (asyncGoal)-[*1]->(asyncRule)-[*1]->(:Goal)
RETURN resPath;
