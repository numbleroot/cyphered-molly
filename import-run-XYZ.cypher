USING PERIODIC COMMIT 10000



LOAD CSV WITH HEADERS FROM "file:///molly/#RUN#_pre_goals.csv" AS csvPreGoal
MERGE (goal:Goal {id: csvPreGoal.id})
ON CREATE SET goal.run = #RUN#,
              goal.condition = "pre",
              goal.label = csvPreGoal.label,
              goal.table = csvPreGoal.table;

LOAD CSV WITH HEADERS FROM "file:///molly/#RUN#_pre_rules.csv" AS csvPreRule
MERGE (rule:Rule {id: csvPreRule.id})
ON CREATE SET rule.run = #RUN#,
              rule.condition = "pre",
              rule.label = csvPreRule.label,
              rule.table = csvPreRule.table;

CREATE CONSTRAINT ON (goal:Goal) ASSERT goal.id IS UNIQUE;
CREATE CONSTRAINT ON (rule:Rule) ASSERT rule.id IS UNIQUE;
CREATE INDEX ON :Goal(run);
CREATE INDEX ON :Rule(run);

LOAD CSV WITH HEADERS FROM "file:///molly/#RUN#_pre_edges.csv" AS preEdgeGoal
MATCH (goal:Goal {id: preEdgeGoal.from, condition: "pre"}) WHERE (goal.run = #RUN#)
MATCH (rule:Rule {id: preEdgeGoal.to, condition: "pre"}) WHERE (rule.run = #RUN#)
MERGE (goal)-[:DUETO]->(rule);

LOAD CSV WITH HEADERS FROM "file:///molly/#RUN#_pre_edges.csv" AS preEdgeRule
MATCH (rule:Rule {id: preEdgeRule.from, condition: "pre"}) WHERE (rule.run = #RUN#)
MATCH (goal:Goal {id: preEdgeRule.to, condition: "pre"}) WHERE (goal.run = #RUN#)
MERGE (rule)-[:DUETO]->(goal);



LOAD CSV WITH HEADERS FROM "file:///molly/#RUN#_post_goals.csv" AS csvPostGoal
MERGE (goal:Goal {id: csvPostGoal.id})
ON CREATE SET goal.run = #RUN#,
              goal.condition = "post",
              goal.label = csvPostGoal.label,
              goal.table = csvPostGoal.table;

LOAD CSV WITH HEADERS FROM "file:///molly/#RUN#_post_rules.csv" AS csvPostRule
MERGE (rule:Rule {id: csvPostRule.id})
ON CREATE SET rule.run = #RUN#,
              rule.condition = "post",
              rule.label = csvPostRule.label,
              rule.table = csvPostRule.table;

LOAD CSV WITH HEADERS FROM "file:///molly/#RUN#_post_edges.csv" AS postEdgeGoal
MATCH (goal:Goal {id: postEdgeGoal.from, condition: "post"}) WHERE (goal.run = #RUN#)
MATCH (rule:Rule {id: postEdgeGoal.to, condition: "post"}) WHERE (rule.run = #RUN#)
MERGE (goal)-[:DUETO]->(rule);

LOAD CSV WITH HEADERS FROM "file:///molly/#RUN#_post_edges.csv" AS postEdgeRule
MATCH (rule:Rule {id: postEdgeRule.from, condition: "post"}) WHERE (rule.run = #RUN#)
MATCH (goal:Goal {id: postEdgeRule.to, condition: "post"}) WHERE (goal.run = #RUN#)
MERGE (rule)-[:DUETO]->(goal);
