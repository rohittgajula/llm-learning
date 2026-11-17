# Progress & practice map

Every concept in [ROADMAP.md](ROADMAP.md) and how it gets practised. LearnHarness teaches the concept; Claude Code (opened in this repo) helps you practise it here.

**Practice types**
| Type | What it is | Where | Time |
|---|---|---|---|
| Quiz | LearnHarness's end-of-lesson questions only, no code | none | — |
| Problem | One small, focused exercise with a check you can run | `problems/<node>/` | 15–45 min |
| BUILD | A Part A checkpoint that puts several concepts together | `builds/<name>/` | 2–10 h |
| P1 / P2 | A step inside one of the two Part B portfolio projects | `projects/p1-ask-the-book/`, `projects/p2-agent-mcp/` | varies |

**Status:** ⬜ not started · 📖 taught in LearnHarness · ✅ practised (problem/build/project step done) · ➖ quiz only, nothing to build

**Next up:** finish the Slope quiz in LearnHarness, then *Derivative* (Problem).

---

## Part A: LLM internals

### Roots
| Concept | Practice | Status |
|---|---|---|
| Slope = rise/run | Quiz | 📖 (quiz pending) |
| Vectors = ordered lists of numbers | Quiz | ⬜ |
| Probabilities sum to 1 | Quiz | ⬜ |
| Model = function with tunable params | Quiz | ⬜ |
| exp and log | Quiz | ⬜ |

### Math
| Concept | Practice | Status |
|---|---|---|
| Derivative = slope at a point | Problem: numerical derivative, compare with the exact one | ⬜ |
| Chain rule | Problem: derivative of a nested function by hand, check numerically | ⬜ |
| Partial derivatives | Quiz | ⬜ |
| Gradient = vector of partials | Problem: numerical gradient of f(x, y) | ⬜ |
| Dot product | Problem: write dot product and cosine similarity, compare with NumPy | ⬜ |
| Matrices | Quiz | ⬜ |
| Mean and variance | Quiz (used later in the layer-norm problem) | ⬜ |
| Matrix multiplication | Problem: matmul with loops, compare with `@`, predict output shapes | ⬜ |
| Tensor shapes and broadcasting | Problem: shape puzzles (predict, then run) | ⬜ |
| Softmax | Problem: write softmax, then the numerically stable version | ⬜ |

### Training
| Concept | Practice | Status |
|---|---|---|
| Training vs inference | Quiz | ⬜ |
| Loss / cross-entropy | Problem: write cross-entropy, check against PyTorch | ⬜ |
| Gradient descent | Covered by BUILD: line fit | ⬜ |
| **BUILD: fit a line (NumPy)** | BUILD `builds/line-fit/` (~2h) | ⬜ |
| Backpropagation | Quiz (built in the mini micrograd) | ⬜ |
| **BUILD: mini micrograd** | BUILD `builds/micrograd/` (~3h, single neuron) | ⬜ |
| Optimizers: SGD, Adam | Problem: SGD vs Adam on the line fit, compare loss curves | ⬜ |
| Overfitting / train-val split | Quiz | ⬜ |
| LR, batch size, epochs | Problem: learning-rate sweep on the line fit, watch it diverge | ⬜ |

### Neural networks and PyTorch
| Concept | Practice | Status |
|---|---|---|
| PyTorch tensors + autograd | Problem: redo the line fit in PyTorch | ⬜ |
| Neuron | Quiz | ⬜ |
| Layer = matmul + bias | Problem: manual matmul + bias equals `nn.Linear` | ⬜ |
| Activations: ReLU, GELU | Quiz | ⬜ |
| MLP: forward + backward | Problem: tiny MLP learns XOR | ⬜ |
| nn.Module + training loop | Problem: refactor the XOR MLP into `nn.Module` + a training loop | ⬜ |

### Text
| Concept | Practice | Status |
|---|---|---|
| Tokenization: char vs BPE | Problem: char tokenizer on the book, compare token counts with tiktoken | ⬜ |
| Vocabulary / token IDs | Same problem as tokenization | ⬜ |
| Embeddings = lookup table | Problem: `nn.Embedding` equals one-hot @ matrix | ⬜ |
| Positional embeddings | Quiz | ⬜ |
| Next-token prediction | Quiz (built in the bigram) | ⬜ |
| **BUILD: char-level bigram on your book** | BUILD `builds/bigram/` (~2h) | ⬜ |

### Transformer
| Concept | Practice | Status |
|---|---|---|
| Self-attention: Q, K, V | Problem: attention by hand on 3 tokens in NumPy | ⬜ |
| Causal masking | Problem: add the mask to the attention problem | ⬜ |
| Multi-head attention | Quiz (built in the tiny GPT) | ⬜ |
| Feed-forward layer | Quiz | ⬜ |
| Residual connections | Quiz | ⬜ |
| Layer normalization | Problem: write layer norm, compare with `nn.LayerNorm` | ⬜ |
| Stacking blocks | Quiz (built in the tiny GPT) | ⬜ |
| Context window | Quiz | ⬜ |

### Generation
| Concept | Practice | Status |
|---|---|---|
| Logits | Quiz | ⬜ |
| Sampling: temperature, top-k/p | Problem: apply each to one logits vector, compare the distributions | ⬜ |
| Autoregressive generation loop | Quiz (built in the tiny GPT) | ⬜ |
| **BUILD: tiny GPT on your book** | BUILD `builds/tiny-gpt/` (~10h, code-along) | ⬜ |

### After the build
| Concept | Practice | Status |
|---|---|---|
| Pretraining, Fine-tuning/SFT, RLHF, Scaling laws, Hallucination, KV cache (brief) | Quiz | ⬜ |
| Quantization (brief) | Quiz | ⬜ |
| Running locally: Ollama (brief) | Problem: run a local model with Ollama and call its API | ⬜ |
| HF transformers/datasets/tiktoken | Problem: load a pretrained tokenizer + model, generate a few tokens | ⬜ |
| Prompting, Embeddings + vector DB, RAG | Practised in Part B (pillars 1–2, P1) | ⬜ |

---

## Part B: Applied AI engineer

**P1: Ask the book** (weeks 9–12) — question answering over your book (and other documents) with citations. FastAPI + PostgreSQL/pgvector + Redis, streaming answers, hybrid search + reranking, an eval suite in CI, tracing.
**P2: Agent with MCP tools** (weeks 13–17) — an agent that uses your own MCP server (P1's search plus a notes database) with step limits, checkpoints, human approval for risky actions, and injection defenses.

### Pillar 1: LLM APIs & context engineering
| Concept | Practice | Status |
|---|---|---|
| Structured outputs | Problem: extract typed fields with Pydantic, handle invalid output | ⬜ |
| Context & memory, prompt caching | Problem: chat with summary memory; measure cache hits and cost | ⬜ |
| Model selection & capabilities | Problem: same task on 3 models, compare cost / latency / quality | ⬜ |
| Multimodal inputs | Problem: extract data from a PDF and a screenshot | ⬜ |
| Production API patterns (streaming, retries, rate limits, routing) | P1 | ⬜ |
| Provider fallback & gateways (light) | P1 | ⬜ |
| Async & batch workloads | P1 (document ingestion as a background job) | ⬜ |

### Pillar 2: Production RAG
| Concept | Practice | Status |
|---|---|---|
| Long context vs RAG | P1 (whole book in the prompt as the baseline to beat) | ⬜ |
| Ingestion & chunking | P1 | ⬜ |
| Vector DBs & indexing | P1 (pgvector) | ⬜ |
| Query-side retrieval | P1 | ⬜ |
| Hybrid search & reranking | P1 | ⬜ |
| Grounded citations & refusal | P1 | ⬜ |

### Pillar 3: Agents, tool calling & MCP
| Concept | Practice | Status |
|---|---|---|
| Function / tool calling | Problem: one tool, strict schema, handle bad arguments | ⬜ |
| MCP | P2 (build your own MCP server) | ⬜ |
| Stateful agent orchestration | P2 | ⬜ |
| Agent context management | P2 | ⬜ |

### Pillar 4: Evals & observability
| Concept | Practice | Status |
|---|---|---|
| Error analysis | P1 | ⬜ |
| Automated eval harness in CI | P1 | ⬜ |
| Synthetic eval data | P1 | ⬜ |
| RAG-specific metrics | P1 | ⬜ |
| Online evals & feedback loops | P2 | ⬜ |
| Tracing & telemetry | P1 + P2 (Langfuse or OpenTelemetry) | ⬜ |

### Pillar 5: Guardrails, security & governance
| Concept | Practice | Status |
|---|---|---|
| Prompt injection & jailbreak defense | P1 (a poisoned document) + P2 (tool misuse) | ⬜ |
| OWASP Top 10 for LLM apps | P2 (check the agent against the list) | ⬜ |
| Access control & PII protection | P1 (per-user filters in vector search, PII redaction) | ⬜ |
| Compliance basics (light) | Quiz / reading | ⬜ |

### Pillar 6: Post-training & local serving (secondary)
| Concept | Practice | Status |
|---|---|---|
| Fine-tune vs prompt + RAG decision | Quiz | ⬜ |
| LoRA / QLoRA | Problem (optional): LoRA on a small classifier | ⬜ |
| Open-weight serving | Same problem as Part A's Ollama | ⬜ |

### Pillar 7: AI product UX
| Concept | Practice | Status |
|---|---|---|
| Showing AI output well | P1 (streaming UI, citations) | ⬜ |
| Designing for failure | P2 (approve / cancel / correct) | ⬜ |

---

## Log
Newest first. One line per practice session: date, what was built, where.

- 2026-11-17: repo set up for practice (this file, `CLAUDE.md`, folders). Slope taught in LearnHarness, quiz pending.
