---
name: linear-systems
description: Use when the student is solving a system of linear equations with 2 or 3 unknowns, e.g. "x + y = 5 and x - y = 1", "y = 2x - 1, 3x + y = 9", or three equations in x, y, z. Also use for questions about substitution, elimination (addition method), equating, how many solutions a system has, or what a 2x2 system means geometrically (two lines). Provides the course methods, typical misconceptions with diagnostic questions, topic-specific hints, and simpler parallel examples.
---

# Systems of linear equations (GLF Year 1)

This skill adds topic knowledge. The tutoring rules from your main instructions still apply in full: never give the full solution or the final answer of the student's task, diagnose first, one question per message, use the hint ladder.

## Scope

- Systems with 2 equations and 2 unknowns, and with 3 equations and 3 unknowns.
- Geometric meaning only for 2x2 systems (two lines in the plane).
- Write products with an explicit dot: 2·x, 3·(x - 1). Write solutions as ordered pairs/triples, e.g. (x, y) = (3, 2), and use the solution-set notation of the attached course notes.

## Standard methods: which one when?

| Situation | Suggested method |
|---|---|
| One equation is already solved for a variable (y = …) | **Substitution**: insert it into the other equation, with parentheses |
| Both equations solved for the same variable | **Equating**: set the right sides equal |
| Coefficients of one variable are equal or opposite (or easy to make so) | **Elimination** (addition method): add or subtract the equations |
| 3x3 system | Eliminate the **same** variable twice to get a 2x2 system, solve it, then substitute back |

All methods give the same result; the choice is about efficiency. Do not insist on one method unless the task does.

### Number of solutions

During the calculation one of three things happens:
- a unique value for each variable → **exactly one solution**
- a false statement such as 0 = 5 → **no solution**
- a true statement such as 0 = 0 (all variables cancel) → **infinitely many solutions**

### Geometric meaning (2x2)

Each equation is a line. One solution = the lines intersect; no solution = parallel lines; infinitely many = identical lines. To compare lines, solve each equation for y and compare slopes and intercepts.

## Diagnosing: typical misconceptions

For each misconception: what you see in the student's work → a diagnostic question to ask (do not name the error right away).

1. **Substituting back into the same equation** the expression came from (gets 0 = 0 and concludes "infinitely many")
   → "Which equation did you solve for y? And into which equation did you substitute it?"
2. **Missing parentheses when substituting** (y = 2·x - 1 into 3·x - 2·y = 4 → 3·x - 2·2·x - 1 = 4)
   → "What exactly are you multiplying by -2? All of y, or only part of it?"
3. **Scaling only part of an equation** (multiplying the left side, or only some terms, by 3)
   → "If you multiply an equation by 3, which terms have to be multiplied?"
4. **Sign errors when subtracting equations** (especially subtracting negative terms)
   → "Let's look only at the y-terms: what is 2·y - (-3·y)?"
5. **Stopping after one variable**
   → "You found x. What does the task ask for?"
6. **Misreading 0 = 0 or 0 = 5** (e.g. "0 = 5, so the solution is 5")
   → "Is the statement 0 = 5 ever true? What does that tell you about the system?"
7. **3x3: eliminating different variables in the two steps** (still three unknowns afterwards)
   → "Which variable did you remove in the first step? And in the second?"
8. **3x3: using the same pair of equations twice** (losing information)
   → "Which equations did you combine each time? Has every equation been used?"
9. **Checking in only one equation**
   → "Does your solution satisfy every equation of the system?"
10. **Mixing up the order in the answer** ((y, x) instead of (x, y))
    → "Which number belongs to x and which to y?"
11. **Geometry: reading the slope directly** from 2·x + 3·y = 6 as 2
    → "What form does the equation need to be in so you can read off the slope?"

If the error is not on this list, use the general diagnosis from your main instructions.

## Topic-specific hints (hint ladder levels a and b)

- Method choice: "Is one of the equations already solved for a variable?" → "Are there coefficients that are equal or opposite?"
- Elimination: "What could you multiply one equation by so that one variable disappears when you add?"
- 3x3: "Which variable is easiest to remove from two different pairs of equations?"
- After solving: "How can you be sure your solution is correct?"
- Geometry: "What do two lines look like if they have no point in common?"

## Checking results

1. Substitute the solution into **every** original equation.
2. For 2x2: optionally sketch both lines or compare slopes to check the number of solutions.
3. Calculator check with the TI-30X Pro system solver. The calculator is for checking only; the student must be able to solve it by hand.

## Parallel examples (for hint level c)

Use these as simpler worked examples of the **same type** as the student's task. They are not the student's task, so you may work them out in full.

| Type | System | Solution |
|---|---|---|
| Elimination, direct | x + y = 5; x - y = 1 | (x, y) = (3, 2) |
| Substitution | y = 2·x - 1; 3·x + y = 9 | (x, y) = (2, 3) |
| Substitution after solving for y | 2·x + 3·y = 12; 4·x - y = 10 | (x, y) = (3, 2) |
| Elimination with scaling | 3·x + 2·y = 7; 2·x - y = 0 | (x, y) = (1, 2) |
| Infinitely many | 3·x - 2·y = 4; 6·x - 4·y = 8 | infinitely many (identical lines) |
| No solution | x + 2·y = 3; 2·x + 4·y = 5 | none (parallel lines) |
| 3x3 | x + y + z = 6; x - y + z = 2; 2·x + y - z = 1 | (x, y, z) = (1, 2, 3) |
| 3x3 | x + y + z = 2; 2·x - y + 3·z = 8; x + 2·y - z = -1 | (x, y, z) = (2, -1, 1) |

If the student's task is exactly one of these examples, do not use it as a parallel example. Change the numbers instead, and double-check your new example by substituting the solution into every equation.
