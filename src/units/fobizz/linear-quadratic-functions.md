---
name: linear-quadratic-functions
description: Use when the student is working on linear functions (slope, y-intercept, line through two points, zeros, parallel or perpendicular lines) or quadratic functions / parabolas (vertex, vertex form, zeros, y-intercept, opening, sketching a parabola, completing the square, shifting or stretching graphs), or on intersections of lines and parabolas. E.g. "find the line through A = (1, 3) and B = (4, 9)", "find the vertex of f(x) = x^2 - 4x + 3", "what does the graph of 2(x + 1)^2 - 3 look like". Provides methods, misconceptions with diagnostic questions, hints, and parallel examples.
---

# Linear and quadratic functions (GLF Year 1)

This skill adds topic knowledge. The tutoring rules from your main instructions still apply in full: never give the full solution or the final answer of the student's task, diagnose first, one question per message, use the hint ladder.

## Notation

Use the letters and names of the attached course notes. If the notes use different letters than below, follow the notes. Write products with an explicit dot (m·x, a·(x - u)^2) and points as A = (x, y).

## Linear functions: f(x) = m·x + q

- m = slope: change in y per unit step in x. From two points A = (x1, y1), B = (x2, y2): m = (y2 - y1)/(x2 - x1).
- q = y-intercept: the graph passes through (0, q).
- Zero: solve m·x + q = 0.
- Line through two points: compute m, then insert one point to find q.
- Parallel lines: equal slopes. Perpendicular lines: m1·m2 = -1.
- An equation like 2·x + 3·y = 6 must be solved for y before m and q can be read off.

## Quadratic functions

Three forms:
- **Normal form** f(x) = a·x^2 + b·x + c: c is the y-intercept.
- **Vertex form** f(x) = a·(x - u)^2 + v: vertex V = (u, v).
- **Factored form** f(x) = a·(x - x1)·(x - x2): zeros x1, x2.

Facts:
- a > 0: opens upward; a < 0: opens downward; |a| > 1: narrower; |a| < 1: wider than y = x^2.
- Vertex from normal form: u = -b/(2·a), v = f(u); or complete the square.
- Zeros: solve f(x) = 0 (see the quadratic equations methods). Number of zeros = number of solutions.
- Shifts: the graph of f(x - u) + v is the graph of f shifted u to the right and v up.
- Sketching y = x^2 from the vertex: one step right/left, go up 1; next step up 3; next step up 5 (times a for stretched parabolas).
- Intersection of two graphs: set the function terms equal, solve, then compute the y-values.

## Diagnosing: typical misconceptions

For each misconception: what you see in the student's work → a diagnostic question to ask (do not name the error right away).

1. **Vertex sign** (f(x) = (x - 3)^2 + 1 → vertex at x = -3)
   → "For which x is (x - 3)^2 smallest?"
2. **Shift direction** (f(x + 2) moves right)
   → "Which x gives the same value in f(x + 2) that x = 0 gives in f(x)?"
3. **Slope as run/rise**
   → "If x increases by 1, by how much does y change?"
4. **Inconsistent point order** in the slope formula ((y2 - y1)/(x1 - x2))
   → "Did you subtract in the same order on top and at the bottom?"
5. **Confusing zero and y-intercept**
   → "At a zero, which coordinate is 0? And at the y-intercept?"
6. **Reading m from an unsolved equation** (2·x + 3·y = 6 → m = 2)
   → "What form does the equation need to be in to read off the slope?"
7. **Perpendicular slope** taken as -m or 1/m instead of -1/m
   → "What must the product of the two slopes be?"
8. **Vertex formula sign** (u = b/(2·a))
   → "Check with the symmetry: are the zeros at the same distance from your vertex?"
9. **Completing the square incompletely** (x^2 + 6·x + 5 = (x + 3)^2 + 5)
   → "Expand (x + 3)^2. Is it the same as what you started with?"
10. **Zeros from vertex form**: forgetting ± ((x - 3)^2 - 4 = 0 → x = 5 only)
    → "How many numbers squared give 4?"
11. **Effect of a misunderstood** (a < 0 thought to move the graph down)
    → "Compare y = x^2 and y = -x^2 at x = 1 and x = 2. What happened?"
12. **Intersection: only x-values** given
    → "An intersection is a point. What is its second coordinate?"

If the error is not on this list, use the general diagnosis from your main instructions.

## Topic-specific hints (hint ladder levels a and b)

- Linear: "Which two pieces of information determine a line?" → "Can you find how much y changes from A to B, and how much x changes?"
- Vertex: "Which form shows the vertex directly?" → "How can you get from normal form to vertex form?"
- Sketch: "Start with the vertex. Then which other points are easy to compute?"
- Zeros: "Where does the graph meet the x-axis? Which equation describes that?"
- Intersection: "At an intersection, what do the two functions have in common?"
- Shifts: "Compare with y = x^2. What changed in the formula, and what does that do to the graph?"

## Checking results

1. Substitute points into the function: do given points lie on the graph?
2. Parabola: vertex and zeros should be symmetric (u is the average of the zeros).
3. Sketch or use the calculator's table function to see whether values fit.
4. The calculator is for checking only; the student must be able to work it out by hand.

## Parallel examples (for hint level c)

Use these as simpler worked examples of the **same type** as the student's task. They are not the student's task, so you may work them out in full.

| Type | Example | Result |
|---|---|---|
| Line through two points | A = (1, 3), B = (4, 9) | m = 2, q = 1, f(x) = 2·x + 1 |
| Slope from general form | 2·x + 3·y = 6 | y = -2/3·x + 2, m = -2/3, q = 2 |
| Zero of a line | f(x) = 2·x - 6 | x = 3 |
| Perpendicular line | to y = 2·x + 1 through (0, 0) | y = -1/2·x |
| Vertex and zeros from normal form | f(x) = x^2 - 4·x + 3 | V = (2, -1), zeros 1 and 3, y-intercept 3 |
| Vertex form | f(x) = 2·(x + 1)^2 - 3 | V = (-1, -3), opens upward, narrower |
| Zeros from vertex form | f(x) = (x - 3)^2 - 4 | zeros 1 and 5 |
| Completing the square | x^2 + 6·x + 5 | (x + 3)^2 - 4, V = (-3, -4) |
| Downward parabola | f(x) = -x^2 + 2·x + 3 | V = (1, 4), zeros -1 and 3 |
| Line and parabola | y = x + 1 and y = x^2 - 1 | intersections (2, 3) and (-1, 0) |

If the student's task is exactly one of these examples, do not use it as a parallel example. Change the numbers instead, and double-check your new example.
