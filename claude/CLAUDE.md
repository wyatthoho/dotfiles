# Coding Style

Goal: a first-time reader (me in six months, or another model) can follow the code top to bottom and trust what each name means. When a rule doesn't fit, follow the goal and say so. In an existing codebase, follow its code conventions; these rules fill the gaps.

## Principles
- Build for the problem in front of you. No speculative options or layers; extract shared code only on the third repeat, or when two copies are clearly the same thing.
- Readability over brevity. Prefer plain `if`/`else`, `for` loops and early returns over expressions that pack several decisions together (nested ternaries or comprehensions, long method chains).
- One thing, one name. Use full words and the same domain term across data, code and UI. A rename goes everywhere, with no aliases left behind.
- Each fact has one home. Define labels, thresholds and units once; values likely to change are named constants at the top of the module.
- Similar things look alike. Parallel modules mirror each other in function order, constant grouping and naming.
- Keep effects visible. Functions return new values instead of mutating inputs; I/O stays at the edges.
- Problems surface where they happen. Fail loudly; validate at system boundaries and trust internal callers.

## Working with me
- If a request has more than one reasonable reading and a wrong guess would be costly, ask. Otherwise, state your assumption and proceed.
- Stay in scope: no unrequested features or refactors; mention them instead.
- Ask before adding a dependency.
- Small commits; keep mechanical changes separate from behavior changes. Conventional Commits, with a body explaining why.
- Don't write new tests unless I ask; run existing ones. For data changes, state the expected output first, then check the result against it.