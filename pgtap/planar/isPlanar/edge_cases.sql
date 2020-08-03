\i setup.sql

SELECT plan(10);



-- 0 edge, 0 vertex tests

PREPARE q1 AS
SELECT id, source, target, cost, reverse_cost
FROM edge_table
WHERE id > 18;

-- Graph is empty - it has 0 edge and 0 vertex
SELECT is_empty('q1', 'q1: Graph with 0 edge and 0 vertex');

-- 0 edge, 0 vertex tests

PREPARE isPlanar1 AS
SELECT *
FROM pgr_isPlanar('q1');

SELECT set_eq('isPlanar1',$$VALUES('f'::bool) $$, '2: Graph with 0 edge and 0 vertex -> Empty row is returned');


-- vertex not present in graph test

PREPARE q3 AS
SELECT id, source, target, cost, reverse_cost
FROM edge_table WHERE source = 50;

SELECT is_empty('q3','3: Vertex 50 does not exist in sample data');

PREPARE vertexNotPresent4 AS
SELECT *
FROM pgr_isPlanar('q3');

SELECT set_eq('vertexNotPresent4',$$VALUES('f'::bool) $$, '4: Vertex not present in graph');

-- 1 vertex test

PREPARE q5 AS
SELECT id, source, 6 AS target, cost, reverse_cost
FROM edge_table
WHERE id = 9;

-- Graph with only vertex 9
SELECT set_eq('q5', $$VALUES (9, 6, 6, 1, 1)$$, 'q5: Graph with only vertex 6');

PREPARE oneVertexTest6 AS
SELECT *
FROM pgr_isPlanar('q5');

SELECT set_eq('oneVertexTest6',$$VALUES('t'::bool) $$, '6: Graph with only vertex 6');

PREPARE q7 AS
SELECT id, source, 3 AS target, cost, reverse_cost
FROM edge_table
WHERE id = 3;

-- Graph with only vertex 3
SELECT set_eq('q7', $$VALUES (3, 3, 3, -1, 1)$$, 'q7: Graph with only vertex 3');

PREPARE oneVertexTest8 AS
SELECT *
FROM pgr_isPlanar('q7');

SELECT set_eq('oneVertexTest8',$$VALUES('t'::bool) $$, '8: Graph with only vertex 3');




-- 2 vertices tests

PREPARE q9 AS
SELECT id, source, target, cost, reverse_cost
FROM edge_table
WHERE id = 1;

SELECT set_eq('q9', $$VALUES (1, 1, 2, 1, 1)$$, 'q9: Graph with two vertices 1 and 2');

PREPARE twoVerticesTest10 AS
SELECT *
FROM pgr_isPlanar('q9');

SELECT set_eq('twoVerticesTest10',$$VALUES('t'::bool) $$, '10: Graph with two vertices 1 and 2');


SELECT * FROM finish();
ROLLBACK;