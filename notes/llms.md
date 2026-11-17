# LLMs

### Learner

I'm continuing an existing learning session from another device. The attached file is the full transcript so far: the learner profile, the probe results, the roadmap, and the lessons completed.

Do not restart or re-probe me. Use ROADMAP.md in the repo as the exact roadmap (it is newer than the map inside the transcript): rebuild that map, mark everything already taught as done, and continue exactly where the last lesson stopped.

First, so this session holds the whole course so far, reproduce from the transcript, word for word and in order: your big-picture overview and every lesson already taught, with all explanations, worked examples, formulas, diagrams, code, quiz questions and my answers. Skip tool calls and probe lines. Don't summarise or shorten them.

Then give a 3-line recap of the last lesson and one quick check question, then carry on with the next step. `/Users/vigorusai/lms-learning/`

### Tool

*ls result delivered*

### Tool

*read result delivered*

### Tool

*read result delivered*

### Tool

*ls result delivered*

### Tool

*read result delivered*

### Tool

*read result delivered*

### Teacher

## Transcript so far (`notes/LLMs.md`)

Omitted per your instructions: the opening learner brief, the probe questions and answers, and tool entries. The map is rebuilt from `ROADMAP.md`, which is newer than the transcript's map.

**Teacher:**

Probe complete. Your goal is concrete and your software background is solid, but your math floor is lower than typical — no retained vocabulary for vectors/dot products, no calculus recall, shaky-but-present probability intuition. The teaching phase will build everything from your array/table intuition upward, starting with topic 1, math foundations, at true ground level.

**Teacher:**

Probe phase complete — handing off to teaching.

**Teacher:**

Here's the shape of the arc.

Everything rests on four roots you can accept at face value right away: **rise/run** (slope of a line), **arrays as ordered lists of numbers** (vectors), **probabilities summing to 1**, and **a model is just a function with tunable knobs** (parameters) — all things your programmer intuition already half-holds. From there, three short math chains build up: arrays → dot product → matrices → matrix multiplication (the engine of every neural net layer); rise/run → derivative → gradient (the engine of training); and probabilities → softmax (how a model expresses "how likely is each option"). Nothing in ML gets taught until its math prerequisite is solid.

From there the path is one motivated chain: a model + a way to score wrongness (loss) + a way to know which direction reduces it (gradient descent via backprop) gives you training. A neuron is just "dot product + nonlinearity"; stack them into layers via matmul and you have an MLP — but it can't yet read text, so we build the text pipeline (tokens → IDs → embeddings, which are literally a lookup table, your "index" analogy made exact). The actual task is next-token prediction, which is exactly what makes attention necessary: tokens need to look up *relevant other tokens* before predicting, which is Query/Key/Value — a soft, weighted join built directly from dot product + softmax. Wrap that in causal masking, multiple heads, a feed-forward layer, residuals and layer norm, stack it N times, and you have a transformer block. Decoding (sampling, temperature, top-k/p) turns its output back into text. Everything after that — pretraining/fine-tuning/RLHF, scaling laws, hallucination, and the applied layer (prompting, RAG, quantization, KV cache, Ollama) — is "now that you understand the engine, here's how the industry runs and deploys it." PyTorch tools (tensors, autograd, `nn.Module`, the training loop) get introduced as the engine is built, and the final node assembles everything into the actual tiny-GPT-on-a-book project.

Take a look at the map — it's large because the curriculum genuinely is, but each node is one landmark, not one lesson.

**Teacher:**

Map's up. Four roots at the bottom (slope, vectors, probability, model-with-parameters), three math chains built off them, then one continuous motivated climb through training → neural nets → text → transformer → generation → the production/applied layer, ending at **Build tiny GPT on a book**.

Confirm this and we'll start at the first root — slope — or tell me what you want changed.

**Teacher:**

Waiting on your go-ahead (or requested changes) before starting the first node.

**Learner:**

go ahead.

**Teacher:**

## Root 1: Slope = rise / run

Picture a straight line on a graph. Pick any two points on it. **Slope** is just:

$$
\text{slope} = \frac{\text{rise}}{\text{run}} = \frac{\Delta y}{\Delta x} = \frac{y_2 - y_1}{x_2 - x_1}
$$

It answers one question: *for every 1 unit you move right, how many units does the line move up (or down)?*

**Worked example.** Line passes through $(1, 2)$ and $(3, 8)$.

$$
\text{slope} = \frac{8 - 2}{3 - 1} = \frac{6}{2} = 3
$$

Move right 1, the line goes up 3. Every time, anywhere on that line — that's what "straight" means: constant rate of change.

```
y
8 |            * (3,8)
  |         ,-'
  |      ,-'
2 | *--'
  | (1,2)
  +----------------- x
    1        3
```

This is the one thing you need to accept here, no caveats: **slope is just "how fast does output change per unit of input."** Nothing exotic — you've used this idea every time you've thought about rate (requests/sec, cost per item, etc.).

Why we need it at all: soon we'll ask "if I nudge a model's parameter a tiny bit, does its error go up or down, and how fast?" That question is *exactly* "what's the slope, here, right now" — just applied to a curve instead of a straight line. That's the whole reason this is step one.

---

## Recap of the last lesson (Root 1: Slope)

- Slope = rise/run = $\frac{\Delta y}{\Delta x}$: how much output moves per unit of input.
- Worked case: through $(1,2)$ and $(3,8)$ gives slope $3$, constant along the line.
- This is the seed of the derivative, which asks the same question on a curve.

**Note:** the transcript ends after the Root 1 explanation. Its 2–3 end-of-lesson quiz questions were never asked, so that step is still open. Quick check first:

### Probe

**Q:** A straight line passes through the points $(2, 3)$ and $(5, 12)$. What is its slope?

The learner answered correctly.

### Teacher

Your answer of $3$ was correct, but you rated it 50% confidence, so treat it as shaky for now. Here is the meaning of the 3 in plain terms.

**What the calculation solves:** "How steep is this line?" You can't see the steepness from the points alone, so you measure it. Going from $(1,2)$ to $(3,8)$:

- Up: $8 - 2 = 6$
- Right: $3 - 1 = 2$
- Steepness: $\frac{6}{2} = 3$

**What the 3 means:** for every 1 step right, the line goes up 3. Picture a staircase where each step forward climbs 3 units. A steeper line has a bigger number; a flat line has 0.

**Why it matters later:** replace "line" with "model's error" and "step right" with "nudge one of its parameters." The slope then tells you how much the error changes per nudge. That is the whole reason for learning it.

### Probe

**Q:** A line has slope $3$. Starting at some point on the line, you move 2 steps to the right. How far does the line go up?

The learner answered correctly.

### Teacher

Correct, at 70% confidence. Root 1 (slope) is done. Next node: **vectors**.

## Root 2: Vectors = ordered lists of numbers

You already use this without the name. A database row like `(price=9.5, qty=3, rating=4)` is an ordered list of numbers, and the order is the meaning: position 1 is always price, position 2 is always qty. A **vector** is that idea with only numbers:

$$
\mathbf{a} = (1, 2, 3)
$$

- **Dimension** = how many entries. $\mathbf{a}$ is 3-dimensional.
- **Order matters.** $(1,2,3)$ and $(3,2,1)$ are different vectors.

In code it is an array:

```python
import numpy as np
a = np.array([1, 2, 3])
a.shape   # (3,)  -> one axis, 3 entries
```

**Why this matters for the goal:** later, each token in your text becomes a vector of numbers (an embedding), and a whole sentence becomes a table of such vectors. Everything in the model moves through these lists.

Quick check: which of these is a vector of dimension 4?


<invoke name="probe">
<parameter name="question">Which of these is a vector with dimension 4?

### Probe

**Q:** Which of these is a vector with dimension 4?

The learner answered correctly.

### Teacher

Correct, at 70% confidence. Vectors: dimension is the count of ordered entries, so $(7,2,9,4)$ is 4-dimensional.

Correction to my previous message: a malformed tool-call fragment was printed as text in that message. It was not a real question. The check above was recorded properly, and it is the only quiz for this node so far.

Next step: a second quick check on vectors, to see whether order matters to you.

### Teacher

Your answer to the slope check was correct, but you rated it 50% confidence, so I treated it as shaky. I then explained what the 3 means (for every 1 step right, the line goes up 3) and asked a follow-up. You answered 6 at 70% confidence, which is correct. Root 1 (slope) is done.

I started Root 2 (vectors). My earlier message contained a malformed tool-call fragment printed as text. It was not a real question, and I've flagged it. The vector check (which 4-entry list is 4-dimensional?) came back correct at 70% confidence.

Next is a second vector check on whether order matters to you. Tell me if you want it now or want to go straight to the next node.

### Learner

Read ROADMAP.md and PROGRESS.md in ~/llm-learning (the repo was renamed from lms-learning). From now on:

1. Use Part A of ROADMAP.md as the map. Teach at the depth in its "4-month plan": math and training at intuition level (one worked example each if not confident can give another example, no drills - if the concept is not clear you can add more drills), backprop conceptually, shorter BUILDs (mini micrograd for one neuron, a small bigram, the tiny GPT as a code-along), and the transformer and generation nodes at full depth. Keep every node; don't drop any.
2. Part B is practised with Claude Code, not taught here. Explain a Part B concept only when I ask.
3. At the end of each lesson, tell me the concept's practice type from PROGRESS.md (Quiz, Problem, BUILD or project) so I know whether to go to Claude Code next.
4. Don't create or edit any files in the repo. I write all practice code myself.

### Tool

*read result delivered*

### Tool

*read result delivered*

### Teacher

Acknowledged. I've read ROADMAP.md and PROGRESS.md and will work to these rules:

1. **Map:** Part A of ROADMAP.md, every node kept. Math and training at intuition level with one worked example each, plus extra drills where a concept isn't clear. Backprop conceptual. BUILDs shortened (line fit, mini micrograd for one neuron, small bigram, tiny GPT as a code-along). Transformer and generation at full depth.
2. **Part B:** not taught here. I'll explain a Part B concept only when you ask.
3. **End of each lesson:** I'll state the concept's practice type from PROGRESS.md (Quiz, Problem, BUILD or project).
4. **Repo:** I won't create or edit files. You write all practice code.

Status: Slope is taught and checked. Vectors is in progress: one check passed, and the order check is still open. Vectors is a **Quiz** node in PROGRESS.md, so no Claude Code step follows it.

Order check:

### Probe

**Q:** Are $(1, 2, 3)$ and $(3, 2, 1)$ the same vector?

The learner answered correctly.

### Teacher

Correct, at 90% confidence. Vectors is done: order matters, so $(1,2,3)$ and $(3,2,1)$ are different vectors.

## Root 3: Probabilities sum to 1

A probability distribution assigns each possible outcome a number between 0 and 1, and all the numbers together add to exactly 1. Each outcome is one of the options, and the total must cover every case.

**Worked example.** A fair die: each face has $P = \frac{1}{6}$.

$$
\frac{1}{6}+\frac{1}{6}+\frac{1}{6}+\frac{1}{6}+\frac{1}{6}+\frac{1}{6} = 1
$$

Your earlier weighted die (five faces at $0.1$, one at $0.5$) also sums to 1: $5(0.1)+0.5 = 1$.

**Why it matters later:** a language model's output for the next token is exactly this: one probability for each token in the vocabulary, summing to 1. Softmax is the step that forces the model's raw scores into such a list.

**Practice type:** Quiz (no code).

Check:

### Probe

**Q:** A three-sided spinner has probabilities $P(A)=0.2$, $P(B)=0.5$, and $P(C)=x$. What must $x$ be?

The learner answered correctly.

### Teacher

Correct, at 90% confidence. Probabilities over all outcomes must sum to 1, so $x=0.3$.

## Root 4: A model is a function with tunable parameters

A model is a function that takes inputs and produces an output. The function has numbers inside it that we can change; those are the **parameters**. Training means adjusting the parameters until the outputs match what we want.

**Worked example.** Take

$$
f(x) = w \cdot x + b
$$

- $x$ is the input you supply.
- $w$ and $b$ are the knobs (parameters). Set $w=2$, $b=1$: $f(3)=7$. Set $w=0.5$, $b=0$: $f(3)=1.5$. Same input, different output, because the knobs changed.

**Why it matters later:** an LLM is this same idea with billions of knobs instead of two. Training is the process of turning those knobs.

**Practice type:** Quiz (no code).

Check: in $f(x)=w\cdot x+b$, which symbols are the parameters?

### Probe

**Q:** In the model $f(x) = w \cdot x + b$, which symbols are the parameters?

The learner did not know.

### Teacher

Let's slow down. The question is only: which parts can I change, and which parts do I feed in?

Use a pricing formula from your backend world:

$$
\text{cost} = \text{rate} \cdot \text{hours} + \text{fee}
$$

- **hours** is what a caller passes in each time. It is the input.
- **cost** is what the function returns. It is the output.
- **rate** and **fee** are settings in the code. Someone can change them to reprice the service. These are the parameters.

Now map the same roles onto $f(x)=w\cdot x+b$:

- $x$ is the input, like hours.
- $f(x)$ is the output, like cost.
- $w$ and $b$ are the settings, like rate and fee.

Quick check on the same idea with different letters:

### Probe

**Q:** In $\text{total} = \text{price} \cdot \text{count} + \text{tax}$, which parts are the parameters (the settings you could change)?

The learner answered correctly.

### Teacher

Correct, at 70% confidence. Your reading is right: changing the settings tunes the output.

Mapped back to the model: in $f(x)=w\cdot x+b$, $w$ and $b$ are the parameters. Changing them changes the output for the same input, and training is the process of finding good values for them.

**Status:**
- Slope: done
- Vectors: done
- Probabilities sum to 1: done
- Model with tunable parameters: done

**Next node:** Derivative = slope at a point. **Practice type: Problem** (numerical derivative, compared with the exact one, in `problems/derivative/`). I'll teach it at intuition level with one worked example and then give you the check.

### Teacher

Understood. I'll follow your four rules from here on.

**Status**
- Slope = rise/run: done (taught, checked twice; the second check was 6 at 70% confidence)
- Vectors = ordered lists of numbers: done (the order check was correct at 90%)
- Probabilities sum to 1: done (checked correctly at 90%)
- Model = function with tunable parameters: done (the first attempt was "don't know"; after a pricing analogy, the second check was correct at 70%)

**Next node:** Derivative = slope at a point. Practice type: **Problem**, which will go in `problems/derivative/` in Claude Code. I'll teach it at intuition level with one worked example, then give you a check before anything goes to Claude Code.

I haven't created or edited any files in the repo.