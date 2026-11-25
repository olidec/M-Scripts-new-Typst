---
name: quadratic-equations
description: Use when the student is working on a quadratic equation or an equation that can be turned into one, e.g. x^2 = 9, x^2 - 5x = 0, (x - 2)(x + 3) = 0, x^2 - 5x + 6 = 0, 2x^2 + 3x - 1 = 0, x^4 - 5x^2 + 4 = 0, x + 2/x = 3, or sqrt(x + 2) = x. Also use when the student asks about the quadratic formula, the discriminant, or how many solutions a quadratic equation has. Provides the course methods, typical misconceptions with diagnostic questions, topic-specific hints, and simpler parallel examples.
---

# Quadratic equations (GLF Year 1)

This skill adds topic knowledge. The tutoring rules from your main instructions still apply in full: never give the full solution or the final answer of the student's task, diagnose first, one question per message, use the hint ladder.

## Scope

- Real solutions only. If the discriminant is negative, the equation has **no real solution** (empty solution set). Do not mention complex numbers.
- Write products with an explicit dot: 2·x, a·x^2, 3·(x - 1), (x - 2)·(x + 3).
- Use the solution-set notation and the method names from the attached course notes.

## Standard methods: which one when?

Before choosing a method, the equation should be in **standard form** a·x^2 + b·x + c = 0 (or already in product form = 0).

| Form | Method |
|---|---|
| a·x^2 + c = 0 (no x-term) | Isolate x^2, then take the square root: **two** solutions ±, one solution (x = 0), or none |
| a·x^2 + b·x = 0 (no constant) | Factor out x: x·(a·x + b) = 0, then zero-product rule. **Never divide by x.** |
| (…)·(…) = 0 | Zero-product rule directly. Do not expand first. |
| Recognizable binomial formula, e.g. x^2 - 6·x + 9 = 0 | Write as (x - 3)^2 = 0 |
| General a·x^2 + b·x + c = 0 | Quadratic formula: x = (-b ± sqrt(D)) / (2·a) with discriminant D = b^2 - 4·a·c |

Number of solutions from the discriminant: D > 0 → two, D = 0 → one, D < 0 → none (no real solution).

### Equations that can be turned into quadratic equations

- **Biquadratic** (a·x^4 + b·x^2 + c = 0): substitute u = x^2, solve for u, then **substitute back**: x^2 = u for each u. Negative u gives no x.
- **Equations with fractions** (variable in a denominator): first state which values are excluded (denominator = 0). Multiply **every** term by the common denominator. At the end, discard any excluded value.
- **Root equations** (if covered in the notes): isolate the root, square both sides, solve, then **check every candidate in the original equation**. Squaring can produce false solutions.
- **Other substitutions**, e.g. (x - 1)^2 - 3·(x - 1) = 0: notice the repeated expression and substitute u = x - 1.

## Diagnosing: typical misconceptions

For each misconception: what you see in the student's work → a diagnostic question to ask (do not name the error right away).

1. **Dividing by x** (x^2 = 5·x → x = 5)
   → "What happens if x = 0? Is it a solution of the original equation?"
2. **Forgetting the negative root** (x^2 = 9 → x = 3)
   → "Try x = -3 in the original equation. What do you get?"
3. **Square root of a negative number** (x^2 = -4 → x = ±2 or x = -2)
   → "Can a number squared ever be negative?"
4. **Zero-product rule when the right side is not 0** ((x - 2)·(x + 3) = 6 → x - 2 = 6 or x + 3 = 6)
   → "Why does the rule work when the product is 0? Does that also work for 6?"
5. **Reading a, b, c before reaching standard form** (3·x^2 = 2·x + 1 → a = 3, b = 2, c = 1)
   → "What does the right side of the equation need to be before you read off a, b and c?"
6. **Sign of b in the quadratic formula** (x^2 - 5·x + 6 = 0 → b = 5)
   → "What exactly is the coefficient of x, including its sign?"
7. **Evaluating b^2 for negative b** ((-5)^2 typed as -5^2 = -25)
   → "What is (-5)·(-5)? What did your calculator give for b^2?"
8. **Dividing only part of the numerator by 2·a**
   → "Which part of the expression does the fraction bar apply to?"
9. **Wrong binomial expansion** ((x + 3)^2 = x^2 + 9)
   → "Write (x + 3)^2 as (x + 3)·(x + 3) and multiply it out. What do you get?"
10. **Biquadratic: stopping after u** (x^4 - 5·x^2 + 4 = 0 → x = 1, x = 4)
    → "You found u. What was u in terms of x?"
11. **Fractions: forgetting excluded values**, or multiplying only some terms by the denominator
    → "Is there a value of x for which the original equation is not defined?" / "Did every term get multiplied?"
12. **Root equations: not checking** (keeping a false solution)
    → "Substitute each candidate into the original equation. Do both work?"
13. **Sign errors when moving terms** or expanding -(a - b)
    → "Let's check just this one line: what happens to a term when it moves to the other side?"
14. **Expanding a product form = 0 unnecessarily** (not wrong, just slow)
    → After the student finishes: "Could you have seen the solutions without expanding?"

If the error is not on this list, use the general diagnosis from your main instructions.

## Topic-specific hints (hint ladder levels a and b)

- Method choice: "Is the equation in the form … = 0?" → "Which of the three terms (x^2, x, constant) are present?"
- Stuck at the start: "Can you bring everything to one side?"
- Product form: "When is a product equal to 0?"
- Quadratic formula: "What are a, b and c? Write them down before using the formula."
- Number of solutions: "What does the discriminant tell you before you calculate the solutions?"
- Substitution: "Do you see an expression that appears more than once?"

## Checking results

Encourage the student to check, in this order:
1. Substitute each solution back into the **original** equation (not into a transformed one).
2. Plausibility: the number of solutions should match the discriminant.
3. Calculator check with the TI-30X Pro equation solver. The calculator is for checking only; the student must be able to solve it by hand.

## Parallel examples (for hint level c)

Use these as simpler worked examples of the **same type** as the student's task. They are not the student's task, so you may work them out in full. Pick one that matches the student's equation type and difficulty.

| Type | Example | Solutions |
|---|---|---|
| No x-term | x^2 - 16 = 0 | x = 4, x = -4 |
| No x-term | 3·x^2 - 12 = 0 | x = 2, x = -2 |
| No x-term, none | x^2 + 4 = 0 | no real solution |
| No constant | x^2 - 6·x = 0 | x = 0, x = 6 |
| No constant | 2·x^2 + 8·x = 0 | x = 0, x = -4 |
| Product form | (x - 1)·(x + 5) = 0 | x = 1, x = -5 |
| Product ≠ 0 | (x - 2)·(x + 3) = 6 | x = 3, x = -4 (expand: x^2 + x - 12 = 0) |
| General, D > 0 | x^2 - 5·x + 6 = 0 | x = 2, x = 3 |
| General, D > 0 | x^2 + 2·x - 8 = 0 | x = 2, x = -4 |
| General, a ≠ 1 | 2·x^2 - 3·x - 2 = 0 | x = 2, x = -1/2 |
| D = 0 | x^2 - 6·x + 9 = 0 | x = 3 |
| D < 0 | x^2 + x + 1 = 0 | D = -3, no real solution |
| Biquadratic | x^4 - 5·x^2 + 4 = 0 | u = 1, u = 4 → x = ±1, x = ±2 |
| Biquadratic, one u negative | x^4 - 3·x^2 - 4 = 0 | u = 4, u = -1 → x = ±2 only |
| Fraction | x + 2/x = 3 (x ≠ 0) | x^2 - 3·x + 2 = 0 → x = 1, x = 2 |
| Root equation | sqrt(x + 2) = x | candidates x = 2, x = -1; check → only x = 2 |

If the student's task is exactly one of these examples, do not use it as a parallel example. Change the numbers instead, and double-check your new example by substituting the solutions back in.
