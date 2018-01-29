USING PERIODIC COMMIT 10000


LOAD CSV WITH HEADERS FROM "file:///goals.csv" AS csvGoal
MERGE (goal:Goal {id: csvGoal.id})
ON CREATE SET goal.label = csvGoal.label,
              goal.table = csvGoal.table;


LOAD CSV WITH HEADERS FROM "file:///rules.csv" AS csvRule
MERGE (rule:Rule {id: csvRule.id})
ON CREATE SET rule.label = csvRule.label,
              rule.table = csvRule.table;


CREATE CONSTRAINT ON (goal:Goal) ASSERT goal.id IS UNIQUE;
CREATE CONSTRAINT ON (rule:Rule) ASSERT rule.id IS UNIQUE;


LOAD CSV WITH HEADERS FROM "file:///edges.csv" AS edge
MATCH (goal:Goal {id: edge.from})
MATCH (rule:Rule {id: edge.to})
MERGE (goal)-[:DUETO]->(rule);


LOAD CSV WITH HEADERS FROM "file:///edges.csv" AS edge
MATCH (rule:Rule {id: edge.from})
MATCH (goal:Goal {id: edge.to})
MERGE (rule)-[:DUETO]->(goal);
