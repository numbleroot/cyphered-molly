USING PERIODIC COMMIT 10000


// Run 0

LOAD CSV WITH HEADERS FROM "file:///molly/0_goals.csv" AS csvGoal
MERGE (goal:Goal {id: csvGoal.id})
ON CREATE SET goal.run = 0,
              goal.label = csvGoal.label,
              goal.table = csvGoal.table;

LOAD CSV WITH HEADERS FROM "file:///molly/0_rules.csv" AS csvRule
MERGE (rule:Rule {id: csvRule.id})
ON CREATE SET rule.run = 0,
              rule.label = csvRule.label,
              rule.table = csvRule.table;

CREATE CONSTRAINT ON (goal:Goal) ASSERT goal.id IS UNIQUE;
CREATE CONSTRAINT ON (rule:Rule) ASSERT rule.id IS UNIQUE;

LOAD CSV WITH HEADERS FROM "file:///molly/0_edges.csv" AS edge
MATCH (goal:Goal {id: edge.from}) WHERE (goal.run = 0)
MATCH (rule:Rule {id: edge.to}) WHERE (rule.run = 0)
MERGE (goal)-[:DUETO]->(rule);

LOAD CSV WITH HEADERS FROM "file:///molly/0_edges.csv" AS edge
MATCH (rule:Rule {id: edge.from}) WHERE (rule.run = 0)
MATCH (goal:Goal {id: edge.to}) WHERE (goal.run = 0)
MERGE (rule)-[:DUETO]->(goal);
