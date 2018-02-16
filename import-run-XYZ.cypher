USING PERIODIC COMMIT 10000


LOAD CSV WITH HEADERS FROM "file:///molly/#XYZ#_goals.csv" AS csvGoal
MERGE (goal:Goal {id: csvGoal.id})
ON CREATE SET goal.run = #XYZ#,
              goal.label = csvGoal.label,
              goal.table = csvGoal.table;

LOAD CSV WITH HEADERS FROM "file:///molly/#XYZ#_rules.csv" AS csvRule
MERGE (rule:Rule {id: csvRule.id})
ON CREATE SET rule.run = #XYZ#,
              rule.label = csvRule.label,
              rule.table = csvRule.table;

CREATE CONSTRAINT ON (goal:Goal) ASSERT goal.id IS UNIQUE;
CREATE CONSTRAINT ON (rule:Rule) ASSERT rule.id IS UNIQUE;
CREATE INDEX ON :Goal(run);
CREATE INDEX ON :Rule(run);

LOAD CSV WITH HEADERS FROM "file:///molly/#XYZ#_edges.csv" AS edge
MATCH (goal:Goal {id: edge.from}) WHERE (goal.run = #XYZ#)
MATCH (rule:Rule {id: edge.to}) WHERE (rule.run = #XYZ#)
MERGE (goal)-[:DUETO]->(rule);

LOAD CSV WITH HEADERS FROM "file:///molly/#XYZ#_edges.csv" AS edge
MATCH (rule:Rule {id: edge.from}) WHERE (rule.run = #XYZ#)
MATCH (goal:Goal {id: edge.to}) WHERE (goal.run = #XYZ#)
MERGE (rule)-[:DUETO]->(goal);
