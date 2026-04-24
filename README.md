# AIFREE

**Free as in freedom. Free as in beer. Free as in no API keys.**

Local AI coding assistant that runs entirely on your machine. Zero cloud dependency, zero cost, zero data leaving your computer. Connects [aider-chat](https://github.com/paul-gauthier/aider) to [Ollama](https://ollama.com) for GPU-accelerated pair programming.

Built by [FCG-builds](https://github.com/FCG-builds) (Fairy Circle Garden).

## Why AIFREE?

Most AI coding tools require API keys, subscriptions, and send your code to the cloud. AIFREE runs 100% locally on your own GPU -- your code never leaves your machine.

- **$0/month** -- no subscriptions, no API usage fees
- - **Private** -- your code stays on your hardware
  - - **Fast** -- GPU-accelerated inference, no network latency
    - - **Customizable** -- swap models, edit system prompts, configure for any project
      - - **Works offline** -- no internet required after setup
       
        - ## Requirements
       
        - - Windows 10/11
          - - Python 3.10+
            - - [Ollama](https://ollama.com/download)
              - - NVIDIA GPU recommended (works on CPU too, just slower)
               
                - | GPU VRAM | Recommended Model | Performance |
                - |----------|-------------------|-------------|
                - | 12GB+ | deepseek-coder-v2:16b | Excellent |
                - | 6-8GB | deepseek-coder-v2:16b | Great |
                - | 4GB | codellama:7b | Good |
                - | CPU only | tinyllama | Usable |
               
                - ## Quick Start
               
                - ```
                  git clone https://github.com/FCG-builds/aifree.git
                  cd aifree
                  setup.bat       # one-time: installs aider, pulls models
                  aifree.bat      # launch the AI assistant
                  ```

                  ## Configuration

                  Copy `config.env.example` to `config.env` and edit:

                  ```env
                  PROJECT_NAME=MyCompany        # your org name in the banner
                  MODEL=codellama:7b            # pick a model for your GPU
                  OLLAMA_HOST=http://127.0.0.1:11434  # remote Ollama? change this
                  ```

                  ## Custom System Prompt

                  Edit `system-prompt.md` with your project conventions, tech stack, and coding standards. Loaded into every aider session via the `--read` flag.

                  ## For Your Business

                  AIFREE is designed to be adopted by any team or solo dev:

                  1. Fork this repo
                  2. 2. Edit `config.env` with your org name and preferred model
                     3. 3. Customize `system-prompt.md` with your project context
                        4. 4. Every developer runs `setup.bat` once, then `aifree.bat` daily
                          
                           5. No shared API keys to manage, no per-seat licensing, no vendor lock-in.
                          
                           6. ## License
                          
                           7. MIT
