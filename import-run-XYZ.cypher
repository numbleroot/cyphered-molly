USING PERIODIC COMMIT 10000


LOAD CSV WITH HEADERS FROM "file:///molly/#XYZ#_pre_goals.csv" AS csvGoal
MERGE (goal:Goal {id: csvGoal.id})
ON CREATE SET goal.run = #XYZ#,
              goal.condition = "pre",
              goal.label = csvGoal.label,
              goal.table = csvGoal.table;

LOAD CSV WITH HEADERS FROM "file:///molly/#XYZ#_pre_rules.csv" AS csvRule
MERGE (rule:Rule {id: csvRule.id})
ON CREATE SET rule.run = #XYZ#,
              rule.condition = "pre",
              rule.label = csvRule.label,
              rule.table = csvRule.table;

CREATE CONSTRAINT ON (goal:Goal) ASSERT goal.id IS UNIQUE;
CREATE CONSTRAINT ON (rule:Rule) ASSERT rule.id IS UNIQUE;
CREATE INDEX ON :Goal(run);
CREATE INDEX ON :Rule(run);

LOAD CSV WITH HEADERS FROM "file:///molly/#XYZ#_pre_edges.csv" AS edge
MATCH (goal:Goal {id: edge.from, condition: "pre"}) WHERE (goal.run = #XYZ#)
MATCH (rule:Rule {id: edge.to, condition: "pre"}) WHERE (rule.run = #XYZ#)
MERGE (goal)-[:DUETO]->(rule);

LOAD CSV WITH HEADERS FROM "file:///molly/#XYZ#_pre_edges.csv" AS edge
MATCH (rule:Rule {id: edge.from, condition: "pre"}) WHERE (rule.run = #XYZ#)
MATCH (goal:Goal {id: edge.to, condition: "pre"}) WHERE (goal.run = #XYZ#)
MERGE (rule)-[:DUETO]->(goal);


LOAD CSV WITH HEADERS FROM "file:///molly/#XYZ#_post_goals.csv" AS csvGoal
MERGE (goal:Goal {id: csvGoal.id})
ON CREATE SET goal.run = #XYZ#,
              goal.condition = "post",
              goal.label = csvGoal.label,
              goal.table = csvGoal.table;

LOAD CSV WITH HEADERS FROM "file:///molly/#XYZ#_post_rules.csv" AS csvRule
MERGE (rule:Rule {id: csvRule.id})
ON CREATE SET rule.run = #XYZ#,
              rule.condition = "post",
              rule.label = csvRule.label,
              rule.table = csvRule.table;

LOAD CSV WITH HEADERS FROM "file:///molly/#XYZ#_post_edges.csv" AS edge
MATCH (goal:Goal {id: edge.from, condition: "post"}) WHERE (goal.run = #XYZ#)
MATCH (rule:Rule {id: edge.to, condition: "post"}) WHERE (rule.run = #XYZ#)
MERGE (goal)-[:DUETO]->(rule);

LOAD CSV WITH HEADERS FROM "file:///molly/#XYZ#_post_edges.csv" AS edge
MATCH (rule:Rule {id: edge.from, condition: "post"}) WHERE (rule.run = #XYZ#)
MATCH (goal:Goal {id: edge.to, condition: "post"}) WHERE (goal.run = #XYZ#)
MERGE (rule)-[:DUETO]->(goal);
