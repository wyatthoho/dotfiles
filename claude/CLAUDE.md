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
- If a wrong guess would cost me rework or trust, ask first. Judge by the cost to me, not by how easy the edit is to undo. Typical cases: missing information, unclear scope or definition of done, or several reasonable approaches that differ in ways I may care about.
- To ask: restate your understanding in 1–3 sentences, offer options with a recommended default, then wait for my reply before editing.
- If the request is clear and small, just do it. If I'm only thinking out loud, just talk.
- Stay in scope: suggest unrequested features or refactors instead of making them. Ask before adding a dependency.
- Small commits; keep mechanical changes separate from behavior changes. Conventional Commits, with a body explaining why.
- Run existing tests; don't write new ones unless I ask. For data changes, state the expected output first, then check the result against it.