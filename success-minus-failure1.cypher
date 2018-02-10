MATCH (pre0:Goal {run:0})-[:DUETO]-(r0:Rule {run:0})-[:DUETO]-(post0:Goal {run:0})
WHERE NOT EXISTS(({run:1,label:pre0.label})-[:DUETO]-({run:1,label:r0.label})-[:DUETO]-({run:1,label:post0.label}))
RETURN pre0, r0, post0
