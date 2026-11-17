# LLM Learning Roadmap

Goal: understand how LLMs work from the ground up, then **build and train a tiny GPT on a book** in PyTorch on a Mac.

Based on the LearnHarness plan (see `notes/LLMs.md`). Nodes marked **(+)** are additions suggested on top of it; nodes marked **[build]** are hands-on checkpoints.

## Map

```mermaid
flowchart BT
    %% ---------- Roots ----------
    R1["Slope = rise / run"]
    R2["Vectors = arrays of numbers"]
    R3["Probabilities sum to 1"]
    R4["Model = function with tunable knobs"]

    %% ---------- Math chains ----------
    R2 --> M1["Dot product"]
    M1 --> M2["Matrices"]
    M2 --> M3["Matrix multiplication"]
    M3 --> M4["(+) Tensor shapes and broadcasting"]

    R1 --> D1["Derivative"]
    D1 --> D2["(+) Chain rule"]
    D1 --> D3["(+) Partial derivatives"]
    D3 --> D4["Gradient"]

    R3 --> P0["(+) exp and log"]
    P0 --> P1["Softmax"]
    R3 --> P2["(+) Mean and variance"]

    %% ---------- ML basics ----------
    R4 --> L1["Training vs inference"]
    P0 --> L2["Loss: cross-entropy"]
    P1 --> L2
    L1 --> L2
    D4 --> L3["Gradient descent"]
    L2 --> L3
    L3 --> B1["[build] Fit a line with NumPy"]
    L3 --> L4["Optimizers: SGD, Adam"]
    D2 --> L5["Backpropagation"]
    L3 --> L5
    L5 --> B2["[build] micrograd autograd engine"]
    L3 --> L6["Overfitting, train/val split,<br/>learning rate, batch size, epochs"]

    %% ---------- Neural networks ----------
    M3 --> N1["Neuron = dot product + nonlinearity"]
    N1 --> N2["Activations: ReLU, GELU"]
    N2 --> N3["Layers, forward and backward pass"]
    L5 --> N3
    N3 --> N4["MLP"]

    %% ---------- Text ----------
    N4 --> T1["Tokenization: char vs BPE"]
    T1 --> T2["Vocabulary and token IDs"]
    T2 --> T3["Embeddings = lookup table"]
    T3 --> T4["Positional embeddings"]
    T3 --> T5["Next-token prediction"]
    L2 --> T5
    T5 --> B3["[build] Bigram model on the book"]

    %% ---------- Transformer ----------
    T5 --> A1["Self-attention: Q, K, V"]
    M1 --> A1
    P1 --> A1
    A1 --> A2["Causal masking"]
    A2 --> A3["Multi-head attention"]
    A3 --> A4["Feed-forward layer"]
    A4 --> A5["Residuals + LayerNorm"]
    P2 --> A5
    A5 --> A6["Transformer block, stacked N times"]
    T4 --> A6
    A6 --> A7["Context window"]

    %% ---------- Generation ----------
    A6 --> G1["Logits -> softmax -> sampling"]
    G1 --> G2["Temperature, top-k, top-p"]
    G2 --> G3["Autoregressive generation"]

    %% ---------- Tools ----------
    M4 --> TL1["PyTorch: tensors, autograd,<br/>nn.Module, training loop, MPS"]
    B2 --> TL1

    %% ---------- Goal ----------
    G3 --> GOAL(["[build] Tiny GPT on a book"])
    TL1 --> GOAL
    B3 --> GOAL

    %% ---------- After the build ----------
    GOAL --> X1["Pretraining, fine-tuning, SFT, RLHF"]
    GOAL --> X2["Scaling laws, hallucination"]
    GOAL --> X3["Embeddings + vector DB -> RAG"]
    GOAL --> X4["Quantization, Ollama, KV cache"]

    classDef root fill:#e8f0fe,stroke:#4a6fa5
    classDef build fill:#fff4e0,stroke:#d08a00
    classDef added stroke-dasharray: 4 3
    classDef goal fill:#e3f6e8,stroke:#2e8b57,stroke-width:2px
    class R1,R2,R3,R4 root
    class B1,B2,B3 build
    class M4,D2,D3,P0,P2 added
    class GOAL goal
```

## What each part teaches

### Roots
| Node | What it teaches | Why it matters for the GPT |
|---|---|---|
| Slope = rise / run | How fast output changes per unit of input | Training asks "if I nudge this knob, how fast does the error change?" |
| Vectors | A list of numbers that represents something | Every token becomes a vector |
| Probabilities sum to 1 | What a probability distribution is | The model outputs a distribution over the next token |
| Model = function with knobs | Parameters are just numbers you tune | A GPT is a function with millions of knobs |

### Math chains
| Node | What it teaches | Why it matters |
|---|---|---|
| Dot product | Multiply element-wise, then sum; measures similarity | Attention scores are dot products |
| Matrices / matmul | Many dot products at once | Every layer is a matrix multiplication |
| (+) Tensor shapes, broadcasting | How (batch, seq, dim) arrays combine | Where most PyTorch bugs happen |
| Derivative | Slope of a curve at one point | Tells which direction reduces the error |
| (+) Chain rule | Derivative of a function inside a function | Backpropagation *is* the chain rule |
| (+) Partial derivatives | Slope for one knob while holding others fixed | Each parameter gets its own slope |
| Gradient | All the partial derivatives together | The direction to update every knob |
| (+) exp and log | Exponentials and logarithms | Softmax uses exp; cross-entropy uses log |
| Softmax | Turns any numbers into probabilities | Turns model scores into next-token odds |
| (+) Mean and variance | Average and spread of numbers | LayerNorm uses them |

### Machine learning basics
| Node | What it teaches |
|---|---|
| Training vs inference | Learning the knobs vs using them |
| Cross-entropy loss | A single number for "how wrong was the prediction" |
| Gradient descent | Step the knobs a little against the gradient, repeat |
| **[build] Fit a line with NumPy** | ~20 lines: gradient descent end to end |
| SGD, Adam | Smarter ways to take those steps |
| Backpropagation | Computing gradients for every knob efficiently |
| **[build] micrograd** | Write a tiny autograd engine yourself |
| Overfitting, train/val, LR, batch, epochs | The practical dials of training |

### Neural networks
| Node | What it teaches |
|---|---|
| Neuron | Dot product + bias + nonlinearity |
| ReLU, GELU | Why nonlinearity lets networks learn curves |
| Layers, forward/backward | Data flows forward, gradients flow back |
| MLP | Stacked layers; the "feed-forward" part of a transformer |

### Working with text
| Node | What it teaches |
|---|---|
| Tokenization | Splitting text into characters or sub-word pieces (BPE) |
| Vocabulary, token IDs | Each token gets an integer ID |
| Embeddings | A lookup table: ID → vector (like a DB index → row) |
| Positional embeddings | Telling the model *where* each token is |
| Next-token prediction | The one task GPT is trained on |
| **[build] Bigram model** | Predict the next character of your book from the current one |

### The Transformer
| Node | What it teaches |
|---|---|
| Self-attention (Q, K, V) | Each token does a soft, weighted lookup over other tokens |
| Causal masking | A token can't look at future tokens |
| Multi-head attention | Several lookups in parallel, each learning different patterns |
| Feed-forward layer | Per-token MLP after attention |
| Residuals + LayerNorm | What keeps deep stacks trainable |
| Transformer block × N | The repeating unit of a GPT |
| Context window | How many tokens the model can see at once |

### Generation
| Node | What it teaches |
|---|---|
| Logits → softmax → sampling | Picking the next token from the model's output |
| Temperature, top-k, top-p | Controlling how random or focused the output is |
| Autoregressive generation | Generate one token, append it, repeat |

### Tools
| Node | What it teaches |
|---|---|
| Python + NumPy | Arrays and the math by hand |
| PyTorch | Tensors, autograd, `nn.Module`, training loop, MPS (Mac GPU) |
| Hugging Face, tiktoken | Ready-made tokenizers, datasets, pretrained models |

### Goal
**[build] Tiny GPT on a book**: a ~10M-parameter character- or BPE-level transformer, trained on a Project Gutenberg book on the Mac GPU, generating text in the book's style.

### After the build (lighter, read later)
| Node | What it teaches |
|---|---|
| Pretraining, fine-tuning, SFT, RLHF | How ChatGPT-style models are made to answer questions |
| Scaling laws, hallucination | Why bigger works, and why models make things up |
| Embeddings + vector DB → RAG | How to actually ask questions about the book |
| Quantization, Ollama, KV cache | Running real models locally and fast |
