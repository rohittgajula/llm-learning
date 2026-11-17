# I am a backend developer (comfortable with APIs, databases, distributed…

### Learner

I am a backend developer (comfortable with APIs, databases, distributed systems, and programming), but I have zero background in machine learning. I want to understand how Large Language Models (LLMs) like GPT actually work, so that I can later build a tiny GPT-style transformer from scratch in PyTorch on my Mac and train it on a book.

Teach me step by step, in this order, and do not move to the next topic until I have understood the current one:

1. Math foundations (only what LLMs need): vectors, matrices, matrix multiplication, dot product, derivatives/gradients, probability, softmax.
2. Machine learning basics: what a model and parameters are, training vs inference, loss functions (cross-entropy), gradient descent, optimizers (SGD, Adam), backpropagation, overfitting, train/validation split, learning rate, batch size, epochs.
3. Neural networks: neurons, layers, weights and biases, activation functions (ReLU, GELU), forward and backward pass, MLP.
4. Working with text: tokenization (character-level vs BPE), vocabulary, token IDs, embeddings, positional embeddings, next-token prediction.
5. The Transformer: self-attention (Query, Key, Value), causal masking, multi-head attention, feed-forward layer, residual connections, layer normalization, stacking blocks, context window.
6. Text generation: logits, softmax, sampling, temperature, top-k, top-p, autoregressive generation.
7. How big LLMs are built: pretraining, fine-tuning, instruction tuning (SFT), RLHF, scaling laws, hallucination.
8. Using LLMs in applications: prompting, system prompts, embeddings and vector databases, RAG, quantization, running models locally (Ollama), KV cache and inference performance.
9. Tools: Python, NumPy, PyTorch (tensors, autograd, nn.Module, training loop, MPS on Mac), Hugging Face (transformers, datasets, tokenizers), tiktoken.

How to teach me:
- Use analogies from backend engineering wherever possible (e.g., compare embeddings to indexes, attention to a weighted lookup/join, training to an optimization loop).
- Start every concept with intuition first, then a small worked example with real numbers, then a tiny code snippet (Python/NumPy or PyTorch).
- Use simple ASCII diagrams to show data flow and tensor shapes.
- Keep each lesson short. End each one with 2-3 quiz questions and wait for my answers before continuing.
- Explicitly tell me how each concept connects to the final goal: building and training a tiny GPT on a book.
- If I ask "why", go deeper; if I say "skip", move on.

Start by giving me a one-page big-picture overview of how an LLM goes from raw text to answering a question, then begin with topic 1.

### Tool

*list_sessions result delivered*

### Probe

**Q:** You have two vectors: $\mathbf{a} = (1, 2, 3)$ and $\mathbf{b} = (4, 5, 6)$. What is their dot product $\mathbf{a} \cdot \mathbf{b}$?

The learner did not know.

### Probe

**Q:** A vector like $(1, 2, 3)$ is best thought of as which of these?

The learner answered correctly.

### Probe

**Q:** Suppose you have two arrays `a = [1, 2, 3]` and `b = [4, 5, 6]`. You multiply them element-by-element and then sum all the results: `1*4 + 2*5 + 3*6`. What's the result?

The learner answered correctly.

### Probe

**Q:** If $f(x) = x^2$, what does the derivative $f'(x)$ tell you at a given point $x$?

The learner did not know.

### Probe

**Q:** A weighted die has these probabilities for landing on each face: $P(1)=0.1, P(2)=0.1, P(3)=0.1, P(4)=0.1, P(5)=0.1, P(6)=0.5$. What must be true about these numbers?

The learner answered correctly.

### Tool

*probe_done result delivered*

### Teacher

Probe complete. Your goal is concrete and your software background is solid, but your math floor is lower than typical — no retained vocabulary for vectors/dot products, no calculus recall, shaky-but-present probability intuition. The teaching phase will build everything from your array/table intuition upward, starting with topic 1, math foundations, at true ground level.

### Teacher

Probe phase complete — handing off to teaching.

### Teacher

Here's the shape of the arc.

Everything rests on four roots you can accept at face value right away: **rise/run** (slope of a line), **arrays as ordered lists of numbers** (vectors), **probabilities summing to 1**, and **a model is just a function with tunable knobs** (parameters) — all things your programmer intuition already half-holds. From there, three short math chains build up: arrays → dot product → matrices → matrix multiplication (the engine of every neural net layer); rise/run → derivative → gradient (the engine of training); and probabilities → softmax (how a model expresses "how likely is each option"). Nothing in ML gets taught until its math prerequisite is solid.

From there the path is one motivated chain: a model + a way to score wrongness (loss) + a way to know which direction reduces it (gradient descent via backprop) gives you training. A neuron is just "dot product + nonlinearity"; stack them into layers via matmul and you have an MLP — but it can't yet read text, so we build the text pipeline (tokens → IDs → embeddings, which are literally a lookup table, your "index" analogy made exact). The actual task is next-token prediction, which is exactly what makes attention necessary: tokens need to look up *relevant other tokens* before predicting, which is Query/Key/Value — a soft, weighted join built directly from dot product + softmax. Wrap that in causal masking, multiple heads, a feed-forward layer, residuals and layer norm, stack it N times, and you have a transformer block. Decoding (sampling, temperature, top-k/p) turns its output back into text. Everything after that — pretraining/fine-tuning/RLHF, scaling laws, hallucination, and the applied layer (prompting, RAG, quantization, KV cache, Ollama) — is "now that you understand the engine, here's how the industry runs and deploys it." PyTorch tools (tensors, autograd, `nn.Module`, the training loop) get introduced as the engine is built, and the final node assembles everything into the actual tiny-GPT-on-a-book project.

Take a look at the map — it's large because the curriculum genuinely is, but each node is one landmark, not one lesson.

### Tool

*plan_init result delivered*

### Teacher

Map's up. Four roots at the bottom (slope, vectors, probability, model-with-parameters), three math chains built off them, then one continuous motivated climb through training → neural nets → text → transformer → generation → the production/applied layer, ending at **Build tiny GPT on a book**.

Confirm this and we'll start at the first root — slope — or tell me what you want changed.

### Teacher

Waiting on your go-ahead (or requested changes) before starting the first node.

### Learner

go ahead.

### Teacher

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