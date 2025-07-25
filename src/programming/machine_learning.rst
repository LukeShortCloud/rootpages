Machine Learning
================

.. contents:: Table of Contents

Use Cases
---------

Machine learning (ML) is a subset of artificial intelligence (AI). It is great for making predictions based on historical data. [1]

Use-cases:

-  Image recognition

   -  Identifying objects in an image.

-  Natural language processing (NLP)

   -  Understanding written or vocal speech.

-  Recommendation engines

   -  Predicting what similar products a user might like.

Mathematics
-----------

Machine learning does not always require having a deep knowledge of math. When it is needed, these are the most relevant mathematical subjects a machine learning expert should be familiar with [2][3]:

-  Linear algebra
-  Statistics
-  Differential calculus
-  Integral calculus

Programming Languages
---------------------

More than half of all machine learning programs are built using Python. [4] Here are the top 3 programming languages used [4][5]:

1.  Python
2.  R
3.  Java

Graphics Card Vendors
---------------------

NVIDIA provides the best support for machine learning with its proprietary CUDA library. It is possible to use AMD and Intel graphics cards by using the open source OpenCL library [7] but NVIDIA provides the best performance and compatibility. [6]

Resources
---------

Mathematics [2][3]:

- Books:

   -  `Deep Learning <https://www.deeplearningbook.org/>`__
   -  `Hands-On Mathematics for Deep Learning <https://www.packtpub.com/product/hands-on-mathematics-for-deep-learning/9781838647292>`__
   -  `Mathematics for Machine Learning <https://mml-book.github.io/>`__

-  Videos:

   -  `Khan Academy Math <https://www.khanacademy.org/math>`__

Large Language Models (LLMs)
----------------------------

Ollama
~~~~~~

Usage
^^^^^

Ollama is a service that allows interacting with locally downloaded large language model (LLM). It is the best free and open source alternative to ChatGPT for the CLI. [8]

Installation [9]:

-  Linux

   .. code-block:: sh

      $ curl -fsSL https://ollama.com/install.sh | sh

-  macOS

   -  `Download the latest macOS version <https://ollama.com/download/Ollama-darwin.zip>`__.

-  Windows

   -  `Download the latest Windows version <https://ollama.com/download/OllamaSetup.exe>`__.

Uninstall:

-  Linux [49]

   .. code-block:: sh

      $ sudo systemctl disable --now ollama
      $ sudo rm --force /etc/systemd/system/ollama.service
      $ sudo rm --force /usr/local/bin/ollama
      $ sudo rm --recursive --force /usr/local/lib/ollama/

-  macOS [50][51]

   .. code-block:: sh

      $ killall Ollama ollama
      $ rm /usr/local/bin/ollama
      $ rm --recursive --force ~/Library/Application\ Support/Ollama

Upgrade:

-  Uninstall and then install Ollama again.

Ollama provides many different models. These are categorized by how many billions (B) of parameters the use. The higher the number, the more accurate it is but at the cost of more memory usage. [10] Refer to the `models section <#models>`__ for the top models. Refer to the `quantization section <#quantization>`__ for more information about the size and accuracy of models.

Starter models to try:

-  For desktops, use Ollama 8B [11]:

   .. code-block:: sh

      $ ollama run llama3.1

-  For phones and low-end hardware, use Ollama 3B [12]:

   .. code-block:: sh

      $ ollama run llama3.2

-  For image recognition on desktops, use Ollama 11B with vision. Provide the full path to the image file when chatting with Ollama. [13]

   .. code-block:: sh

      $ ollama run llama3.2-vision

Save a conversation to revisit later by using ``/save <SAVE_NAME>``. It will be stored as a new model which can be viewed with ``/list`` or the CLI command ``ollama list``. Load the conversation by using ``/load <SAVE_NAME>``.

Exit the LLM instance by typing ``/bye``.

List installed models.

.. code-block:: sh

    $ ollama list

Delete a model.

-  Linux or macOS

   .. code-block:: sh

      $ ollama rm <OLLAMA_MODEL>

Delete all models.

-  Linux

   .. code-block:: sh

      $ sudo rm -r -f /usr/share/ollama/.ollama/models/blobs/
      $ sudo rm -r -f /usr/share/ollama/.ollama/models/manifests/

-  macOS

   .. code-block:: sh

      $ rm -r -f ~/.ollama/models/*

Models
^^^^^^

Top local LLMs for literature as of 2025 [28]:

-  32B or less:

   1.  QwQ 32B (Q4_K_M) = Although quantized models normally perform worse the more they are shrunk, this performs better at INT4 than it does with INT5, INT8, or even FP16. [36]

      -  ``ollama run qwq:32b``

   2.  Gemma 3 12B

      -  ``ollama run gemma3:12b-it-qat``

   3.  Gemma 3 4B

      -  ``ollama run gemma3:4b-it-qat``

   4.  Mistral Nemo 2407 Instruct 12B

      -  ``ollama run mistral-nemo:12b-instruct-2407-fp16``

   5.  Gemma 2 9B

      -  ``ollama run gemma2:9b``

   6.  Llama 3.1 8B

      - ``ollama run llama3.1``

Top local LLms for programming that are 32B or smaller as of 2025:

-  32B or less:

   1.  Qwen Coder 32B (Q8_0) [18][29][30]

      -  ``ollama run qwen2.5-coder:32b-instruct-q8_0``

   2.  DeepSeek Coder v2 Lite 16B [17]

      -  ``ollama run deepseek-coder-v2:16b``

   3.  Codestral 22B [31][32]

      -  ``ollama run codestral:22b``

-  10B or less:

   1.  Ministral Instruct 8B

      -  ``ollama run cas/ministral-8b-instruct-2410_q4km``

   2.  Qwen2.5 Coder Instruct 7B [32][33]

      -  ``ollama run qwen2.5-coder:7b-instruct``

   3.  DeepSeek Coder Base 7B [34][35]

      -  ``ollama run deepseek-coder:6.7b``

Top local multimodal LLMs for examining images as of 2024. [16] Ollama added support for multimodal LLMs in version 0.7.0 in 2025. [15]

1.  Qwen-VL-Max
2.  InternLM-XComposer2-VL (based on InternLM2-7B)
3.  MiniCPM-V 2.6 (based on Qwen2-8B)
4.  Qwen-VL-Plus
5.  InfMLLM (based on Vicuna-13B)
6.  ChatTruth-7B (based on Qwen-7B)
7.  InternVL-Chat-V1.5 (based on InternLM2-20B)
8.  WeMM (based on InternLM-7B)
9.  PureMM (based on Vicuna-13B)
10.  InternVL-Chat-V1.1 (based on LLaMA2-13B)
11.  LLaVA-1.6 (based on Vicuna-34B)
12.  MiniCPM-Llama3-V 2.5 (based on LLaMA3-8B)

Distrobox
^^^^^^^^^

Introduction
''''''''''''

`distrobox <https://distrobox.it/>`__ can be used to run Ollama on immutable operating systems such as Fedora Atomic Desktop and openSUSE MicroOS. This guide focuses on systems using an AMD graphics device. For NVIDIA support, either (1) use the ``--nvidia`` argument with ``distrobox create`` or (2) use the option ``nvidia=true`` with ``distrobox-assemble create``.

Fedora Atomic Desktop
'''''''''''''''''''''

Create and enter a distrobox container for Fedora.

.. code-block:: sh

   $ distrobox create --volume /dev/dri:/dev/dri --volume /dev/kfd:/dev/kfd --additional-packages "pciutils" --init --image quay.io/fedora/fedora:latest --name ollama-fedora
   $ distrobox enter ollama-fedora

openSUSE MicroOS
''''''''''''''''

Allow ROCm to be used by non-root users.

.. code-block:: sh

   $ sudo -E ${EDITOR} /etc/udev/rules.d/90-rocm.rules
   KERNEL=="kfd", GROUP=="video", MODE="0660"
   SUBSYSTEM=="kfd", KERNEL=="kfd", TAG+="uaccess", GROUP="video"
   $ sudo udevadm control --reload-rules
   $ sudo udevadm trigger

Find the existing UID and GID mappings. If none exist, create one using the same name for both the user and group.

.. code-block:: sh

   $ cat /etc/subuid
   $ cat /etc/subgid

.. code-block:: sh

   $ sudo -E ${EDITOR} /etc/subuid
   <NAME>:100000:65536
   $ sudo -E ${EDITOR} /etc/subgid
   <NAME>:100000:65536

Find the GID for the ``render`` and ``video`` group.

.. code-block:: sh

   $ grep render /etc/group
   $ grep video /etc/group

Create a Distrobox build configuration file. Replace the ``subuid``, ``subgid``, and ``nogroup`` values with the related starting value. Also replace the GIDs for the ``render`` and ``video`` group.

.. code-block:: sh

   $ ${EDITOR} distrobox-ollama-ubuntu.ini

.. code-block:: ini

   [ollama-ubuntu]
   image=docker.io/rocm/dev-ubuntu-24.04:latest
   init=true
   additional_packages = "pciutils"
   additional_flags="--device=/dev/kfd --device=/dev/dri"
   subuid=100000
   subgid=100000
   init_hooks="export ROCM_PATH=/opt/rocm;"
   init_hooks="addgroup --gid 486 render"
   init_hooks="addgroup --gid 483 video"
   init_hooks="addgroup --gid 100000 nogroup"
   init_hooks="usermod -aG render,video,nogroup $LOGNAME;"
   nvidia=false
   pull=false
   root=false
   replace=true
   start_now=false

Create and enter the Distrobox container. [19]

.. code-block:: sh

   $ distrobox-assemble create --file distrobox-ollama-ubuntu.ini
   $ distrobox enter ollama-ubuntu

LLM Tuning
^^^^^^^^^^

Quantization
''''''''''''

Most LLMs available to download use, at most, a floating-point value of 16. It is possible to use quantization to lower the memory usage. This allows for running larger models and/or increasing the context size. Some models have downloads that already include it being quantized which also lowers the download size. Other models require configuring your LLM service to quantize it.

.. csv-table::
   :header: Quantization, GB Size Per Billion Parameters [37][38], Notes
   :widths: 20, 20, 20

   FP32, 4, Lossless.
   FP16, 2, Identicial to FP32. Most models are published at this size.
   INT8 (Q8_0), 1, "'Extremely low quality loss.'"
   INT5 (Q5_K/Q5_K_M), 0.6, "'Very low quality loss.'"
   INT4 (Q4_K/Q4_K_M), 0.5, "'Balanced quality.' [20][27]"

Anything below INT4 results in a huge loss in quality and is not usable. [20] If a model cannot fit into VRAM, then the extra size is placed into system RAM which can be up to 100x slower. [39]

Configure a quantization value.

-  Linux:

   .. code-block:: sh

      $ sudo -E ${EDITOR} /etc/systemd/system/ollama.service
      [Service]
      Environment="OLLAMA_KV_CACHE_TYPE=<QUANTIZATION_VALUE>"
      Environment="OLLAMA_FLASH_ATTENTION=1"
      $ sudo systemctl daemon-reload
      $ sudo systemctl restart ollama

-  macOS [9][21]:

   .. code-block:: sh

      $ launchctl setenv OLLAMA_KV_CACHE_TYPE <QUANTIZATION_VALUE>
      $ launchctl setenv OLLAMA_FLASH_ATTENTION 1

Open WebUI
^^^^^^^^^^

Installation
''''''''''''

Open WebUI provides a simple web interface to interact with LLMs similar to ChatGPT. It supports using offline Ollama models, doing web searches, user accounts, and more.

Run it with default settings (it will be accessible at ``http://127.0.0.1:3000`` after the container finishes starting):

.. code-block:: sh

   $ podman run --detach --publish 3000:8080 --volume open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main

Run it with Ollama as an integrated service:

.. code-block:: sh

   $ podman run --detach --publish 3000:8080 --volume open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:ollama

Run it with Ollama as an integrated service and with access to NVIDIA GPUs (only AMD and Intel GPUs are accessible by default):

.. code-block:: sh

   $ podman run --detach --publish 3000:8080 --gpus all --volume open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:cuda

Run it with access to a local Ollama service:

.. code-block:: sh

   $ podman run --detach --network=host --env PORT=3000 --volume open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main

Run it with access to a remote Ollama service [22]:

.. code-block:: sh

   $ podman run --detach --publish 3000:8080 --env OLLAMA_BASE_URL=<OLLAMA_BASE_URL> --volume open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main

Run it with authentication disabled (autologin enabled):

.. code-block:: sh

   $ podman run --detach --publish 3000:8080 --env WEBUI_AUTH=False --volume open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main

Run it with search engine support. [23][24]

-  `Brave has a free service <https://brave.com/search/api/>`__ that allows for 1 query a second and 2000 queries a month. It requires an account with a credit card on file.

   .. code-block:: sh

      $ podman run --detach --publish 3000:8080 --env ENABLE_WEB_SEARCH=true --env WEB_SEARCH_CONCURRENT_REQUESTS=1 --env ENABLE_SEARCH_QUERY_GENERATION=False --env WEB_SEARCH_ENGINE=brave --env BRAVE_SEARCH_API_KEY=<BRAVE_SEARCH_API_KEY> --volume open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main

-  DuckDuckGo is the easiest to configure since it does not require an API key. However, search results are normally rate limited unless Open WebUI is configured to do less searches at a time. [25][26]

   .. code-block:: sh

      $ podman run --detach --publish 3000:8080 --env ENABLE_WEB_SEARCH=true --env WEB_SEARCH_CONCURRENT_REQUESTS=1 --env ENABLE_SEARCH_QUERY_GENERATION=False --env WEB_SEARCH_ENGINE=duckduckgo --volume open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main

-  `Google Programmable Search Engine (PSE) has a free service <https://developers.google.com/custom-search/v1/overview>`__ that allows for 100 queries every day. It requires an account with a credit card on file.

   .. code-block:: sh

      $ podman run --detach --publish 3000:8080 --env ENABLE_WEB_SEARCH=true --env WEB_SEARCH_ENGINE=google_pse --env GOOGLE_PSE_API_KEY=<GOOGLE_PSE_API_KEY> --env GOOGLE_PSE_ENGINE_ID=<GOOGLE_PSE_ENGINE_ID> --volume open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main

-  `Tavily offers has a free service <https://www.tavily.com/#pricing>`__ that allows for 1000 queries every month. No credit card required.

   .. code-block:: sh

      $ podman run --detach --publish 3000:8080 --env ENABLE_WEB_SEARCH=true --env WEB_SEARCH_ENGINE=tavily --env TAVILY_API_KEY=<TAVILY_API_KEY> --volume open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main

Verify if a search engine rate limit is being reached:

.. code-block:: sh

   $ podman logs open-webui | grep -i ratelimit

Configuration
'''''''''''''

Change the Ollama URL:

-  User > Admin Panel > Settings > Connections > Manage Ollama API Connections

Change the search engine settings:

-  User > Admin Panel > Settings > Web Search

Disable query generation to prevent rate limiting of most search engines with free tiers of access. Search engine results may become less useful. [26]

-  User > Admin Panel > Settings > Interface > Web Search Query Generation: Off > Save

Modelfile
^^^^^^^^^

A Modelfile allows customizing an existing model for use with Ollama. The syntax for instructions is similar to a Containerfile.

View a human-friendly overview of a model.

.. code-block:: sh

   $ ollama show ${model}:${tag}

Save a model as a Modelfile to use as a starting point.

.. code-block:: sh

   $ ollama list
   $ ollama show ${model}:${tag} --modelfile > ${model}.modelfile
   $ less ${model}.modelfile

Modelfile instructions [46][47]:

-  **FROM** ``<MODEL>:<TAG>`` = Required. The model to use.
-  ADAPTER = The LoRA adapters to use.
-  LICENSE = The license to use.
-  MESSAGE ``<ROLE>`` = One or more existing messages. These will appear as chat history when a user runs the model. This can be used for simple training. Role can be ``system`` (or use the ``SYSTEM`` instruction intead), ``user`` (the end-user), or ``assistant`` (the AI). For long multi-line messages, use triple quotes ``"""`` to start and end the message.
-  **PARAMETER** = Configure model runtime settings.

   -  min_p (float) = Use instead of top_p. Minimum probability of taking into account different but similar tokens. Default is 0.0.
   -  **num_ctx (int)** = Context size. The higher the number, the more the model will remember. Default is 2048.
   -  num_predict (int) = Predict how many tokens (how much processing) maximum is required to respond to the prompt. Default is -1 for infinity.
   -  repeat_last_n (int) = How many messages a model can refer back to. Default is 64.
   -  repeat_penalty (float) = Lower will be more repetitive. Higher will be less repetitive. Default is 1.1.
   -  seed (int) = Configure a seed to get consistent output. Otherwise, Ollama will generate a random seed every time the model is loaded. Default is 0 for random.
   -  **temperature (float)** = Higher will be more creative but less accurate. Default is 0.8.
   -  stop (string) = One or more stop sequences that define when the AI should stop generating text.
   -  top_k (int) = Higher will provide more varied output. Lower will be more focused. Default is 40.
   -  top_p (float) = Use instead of min_p. Optionally use with top_k. Higher will provide more varied output. Lower will be more focused. Default is 0.9.

-  **SYSTEM** = The persona the AI should have.
-  TEMPLATE = The prompt template.

Create a new model from the Modefile.

.. code-block:: sh

   $ ollama create <NEW_MODEL> --file <NEW_MODEL>.modelfile

Example Modelfile [48]:

::

   FROM llama3.1:latest
   PARAMETER num_ctx 4096
   PARAMETER repeat_last_n 96
   PARAMETER temperature 0.5
   SYSTEM You are the world-class paleontologist Dr. Alan Grant from Jurassic Park.
   MESSAGE user Tell me about yourself in two sentences.
   MESSAGE assistant """My name is Dr. Alan Grant.
   I'm a world-class plaeontologist who specializes in the study of velociraptors."""

Training
^^^^^^^^

There are two types of quantization training strategies to lower the memory usage of a LLM [40]:

-  Post-training quantization (PTQ) = Easier but less accurate. Any existing LLM can be quantized and cached. Refer to the `quantization section <#quantization>`__.
-  Quantization-aware training (QAT) = Harder but more accurate. The LLM must be specifically trained knowing that the data is quantized. For example, Gemma 3 models have QAT variants. [41]

The easiest way to train an existing LLM is to run it with Ollama, provide it with the information and instructions on what to do, and then save the model. Alternatively, use a `Modefile <#modelfile>`__ to define ``MESSAGE`` instructions. When a user loads the model, the will see the message history.

.. code-block:: sh

   $ ollama run <MODEL>
   /save <NEW_MODEL>
   /bye
   $ ollama list
   $ ollama run <NEW_MODEL>

Prompt Engineering
~~~~~~~~~~~~~~~~~~

Prompt engineering is a focus on getting the best answers from LLMs. [42]

A good prompt will usually have the following [43]:

-  Instruction = Explain in detail exactly what task you want to happen.
-  Context = Provide examples.
-  Input data = Information unique to instruction.
-  Output indicator

   -  Provide the education level that the answer should be in. For example, pre-school, middle school, college undergraduate, or PHD.
   -  Provide the tone. For example, academic, lighthearted, serious, etc.
   -  Provide the format of the output. For example, how many sentences, JSON or YAML, C or Rust code, etc.
   -  Provide a persona. For example, customer support, game master, teacher, etc.

The more instruction, context, input data, and output indicator, the higher chance of the answer being what is expected. Avoid being vague.

Shot-based prompts usually follow a simple question and answer format. Leave the answer field empty and then the LLM will try to fill it in.

Types of shot-based prompts:

-  Zero-shot = Provide an instruction with no examples.
-  One-shot = Provide an instruction with exactly 1 example.
-  Few-shot = Provide an instruction with 2 or more examples.

Few-shot prompting provides the best results compared to zero-shot and one-shot. [44]

::

   Question: Who is the captain?
   Asnwer: Jean-Luc Picard
   Question: Who is the doctor?
   Answer: Beverly Crusher
   Question: Who is the engineer?
   Answer:

::

   Answer: Geordi La Forge

The LLM can be told to roleplay to both think and provide answers in a different way. It is important to specify (1) the role it should play and (2) the tone it should use. [45]

::

   You are the new overly confident captain of the original U.S.S. Enterprise. You are on a peaceful mission to explore space. A Klingon Bird-of-Prey just de-cloaked near the port-bow which starts to divert power to their weapons. This is the first time your crew has experienced a real threat. What is the first order you give to the crew? Use only 1 sentence.

::

   "Raise shields, Sulu, and let's give these Klingons a cordial reminder that the Federation doesn't take kindly to unannounced visits!"

History
-------

-  `Latest <https://github.com/LukeShortCloud/rootpages/commits/main/src/programming/machine_learning.rst>`__

Bibliography
------------

1. "Classification, regression, and prediction - what's the difference?" Towards Data Science. December 11, 2020. Accessed November 7, 2022. https://towardsdatascience.com/classification-regression-and-prediction-whats-the-difference-5423d9efe4ec
2. "A beginner’s guide to the math that powers machine learning." TNW The heart of tech. October 2, 2022. Accessed November 7, 2022. https://thenextweb.com/news/a-beginners-guide-to-the-math-that-powers-machine-learning-syndication
3. "Math for Machine Learning: 14 Must-Read Books." Machine Learning Techniques. June 13, 2022. Accessed November 7, 2022. https://mltechniques.com/2022/06/13/math-for-machine-learning-12-must-read-books/
4. "What is the best programming language for Machine Learning?" Towards Data Science. May 5, 2017. Accessed November 7, 2022. https://towardsdatascience.com/what-is-the-best-programming-language-for-machine-learning-a745c156d6b7
5. "7 Top Machine Learning Programming Languages." Codeacademy. October 20, 2021. Accessed November 7, 2022. https://www.codecademy.com/resources/blog/machine-learning-programming-languages/
6. "How to Pick the Best Graphics Card for Machine Learning." Towards Data Science. September 19, 2022. Accessed November 7, 2022. https://towardsdatascience.com/how-to-pick-the-best-graphics-card-for-machine-learning-32ce9679e23b
7. "Does TensorFlow Support OpenCL?" IndianTechWarrior. Accessed November 7, 2022. https://indiantechwarrior.com/does-tensorflow-support-opencl/
8. "Chatbot Arena LLM Leaderboard: Community-driven Evaluation for Best LLM and AI chatbots." Chatobt Arena. Accessed December 4, 2024. https://lmarena.ai/
9. "FAQ." GitHub ollama/ollama. April 28, 2025. Accessed May 27, 2025. https://github.com/ollama/ollama/blob/main/docs/faq.md
10. "What does 7b, 8b and all the b’s mean on the models and how are each models different from one another?" Reddit r/LocalLLaMA. May 23, 2024. Accessed December 4, 2024. https://www.reddit.com/r/LocalLLaMA/comments/1cylwmd/what_does_7b_8b_and_all_the_bs_mean_on_the_models/
11. "Running Llama 3.1 Locally with Ollama: A Step-by-Step Guide." Medium - Paulo Batista. July 25, 2024. Accessed December 4, 2024. https://medium.com/@paulocsb/running-llama-3-1-locally-with-ollama-a-step-by-step-guide-44c2bb6c1294
12. "LLaMA 3.2 vs. LLaMA 3.1 vs. Gemma 2: Finding the Best Open-Source LLM for Content Creation." Medium - RayRay. October 2, 2024. Accessed December 4, 2024. https://byrayray.medium.com/llama-3-2-vs-llama-3-1-vs-gemma-2-finding-the-best-open-source-llm-for-content-creation-1f6085c9f87a
13. "Llama 3.2 Vision." Ollama. November 6, 2024. Accessed December 4, 2024. https://ollama.com/blog/llama3.2-vision
14. "I can now run a GPT-4 class model on my laptop." Simon Willison's Weblog. December 9, 2024. Accessed December 12, 2024. https://simonwillison.net/2024/Dec/9/llama-33-70b/
15. "v0.7.0." GitHub ollama/ollama. May 12, 2025. Accessed  June 26, 2025. https://github.com/ollama/ollama/releases/tag/v0.7.0
16. "MME: A Comprehensive Evaluation Benchmark for Multimodal Large Language Models." GitHub BradyFU/Awesome-Multimodal-Large-Language-Models. November 26, 2024. Accessed June 26, 2025. https://github.com/BradyFU/Awesome-Multimodal-Large-Language-Models/tree/Evaluation?tab=readme-ov-file
17. "deepseek-coder-v2." Ollama. September, 2024. Accessed December 13, 2024. https://ollama.com/library/deepseek-coder-v2
18. "Best LLM Model for coding." Reddit r/LocalLLaMA. November 6, 2024. Accessed February 4, 2025. https://www.reddit.com/r/LocalLLaMA/comments/1gkewyp/best_llm_model_for_coding/
19. "OpenSUSE MicroOS Howto with AMDGPU / ROCm - To run CUDA AI Apps like Ollama." GitHub Gist torsten-online. February 10, 2025. Accessed March 7, 2025. https://gist.github.com/torsten-online/22dd2746ddad13ebbc156498d7bc3a80
20. "Difference in different quantization methods #2094." GitHub ggml-org/llama.cpp. October 27, 2024. Accessed May 27, 2025. https://github.com/ggml-org/llama.cpp/discussions/2094
21. "Configuring Your Ollama Server." ShinChven's Blog. January 15, 2025. Accessed May 27, 2025. https://atlassc.net/2025/01/15/configuring-your-ollama-server
22. "Open WebUI." GitHub open-webui/open-webui. June 10, 2025. Accessed June 23, 2025. https://github.com/open-webui/open-webui
23. "Web Search." Open WebUI. Accessed June 23, 2025. https://docs.openwebui.com/category/-web-search/
24. "Environment Variable Configuration." Open WebUI. June 22, 2025. Accessed June 23, 2025. https://docs.openwebui.com/getting-started/env-configuration
25. "duckduckgo_search.exceptions.RatelimitException: 202 Ratelimit #6624." GitHub open-webui/open-webui. June 6, 2025. Accessed June 23, 2025. https://github.com/open-webui/open-webui/discussions/6624
26. "issue: Too Many Requests #14244." GitHub open-webui/open-webui. June 14, 2025. Accessed June 23, 2025. https://github.com/open-webui/open-webui/discussions/14244
27. "A Visual Guide to Quantization." Exploring Language Models. July 22, 2024. Accessed June 26, 2025. https://newsletter.maartengrootendorst.com/p/a-visual-guide-to-quantization
28. "Creative Writing v3." EQ-Bench Creative Writing v3 Leaderboard. Accessed June 24, 2025. https://eqbench.com/creative_writing.html
29. "Qwen-2.5-Coder 32B – The AI That's Revolutionizing Coding! - Real God in a Box?" Reddit r/LocalLLaMA. March 14, 2025. Accessed June 24, 2025. https://www.reddit.com/r/LocalLLaMA/comments/1gp84in/qwen25coder_32b_the_ai_thats_revolutionizing/
30. "So what is now the best local AI for coding?" Reddit r/LocalLLaMA. February 25, 2025. Accessed June 24, 2025. https://www.reddit.com/r/LocalLLaMA/comments/1ia0j9o/so_what_is_now_the_best_local_ai_for_coding/
31. "Codestral 22B, Owen 2.5 Coder B, and DeepSeek V2 Coder: Which AI Coder Should You Choose?" Deepgram. October 10, 2024. Accessed June 24, 2025. https://deepgram.com/learn/best-local-coding-llm
32. "In Feb 2025, what’s your LLM stack for productivity?" Reddit r/LocalLLaMA. February 8, 2025. Accessed June 24, 2025. https://www.reddit.com/r/LocalLLaMA/comments/1ik6fy3/in_feb_2025_whats_your_llm_stack_for_productivity/
33. https://symflower.com/en/company/blog/2025/dev-quality-eval-v1.0-anthropic-s-claude-3.7-sonnet-is-the-king-with-help-and-deepseek-r1-disappoints/
34. "Stable Code 3B: Coding on the Edge." Hacker News. January 20, 2025. Accessed June 24, 2025. https://news.ycombinator.com/item?id=39019532
35. "DeepSeek Coder". GitHub deepseek-ai/DeepSeek-Coder. March 6, 2024. Accessed June 24, 2025. https://github.com/deepseek-ai/deepseek-coder
36. "Comparing quants of QwQ Preview in Ollama." December 17, 2024. Accessed June 24, 2025. leikareipa.github.io. https://leikareipa.github.io/blog/comparing-quants-of-qwq-preview-in-ollama/
37. "Question on model sizes vs. GPU." Reddit r/ollama. September 4, 2024. Accessed June 26, 2025. https://www.reddit.com/r/ollama/comments/1d4ofem/question_on_model_sizes_vs_gpu/
38. "How much VRAM do I need for LLM model fine-tuning?" Modal Blog. September 1, 2024. Accessed June 26, 2025. https://modal.com/blog/how-much-vram-need-fine-tuning
39. "Tech Primer: What hardware do you need to run a local LLM?" Puget Systems. August 12, 2024. Accessed June 26, 2025. https://www.pugetsystems.com/labs/articles/tech-primer-what-hardware-do-you-need-to-run-a-local-llm/
40. "A Guide to Quantization in LLMs." Symbl.ai. February 21, 2025. Accessed June 27, 2025. https://symbl.ai/developers/blog/a-guide-to-quantization-in-llms/
41. "gemma3:27b." Ollama. April 18, 2025. Accessed June 27, 2025. `https://ollama.com/library/gemma3:27b <https://ollama.com/library/gemma3:27b>`__
42. "What is Prompt Engineering?" AWS Cloud Computing Concepts Hub. Accessed June 30, 2025. https://aws.amazon.com/what-is/prompt-engineering/
43. "Elements of a Prompt." Prompt Engineering Guide. April 24, 2025. Accessed June 30, 2025. https://www.promptingguide.ai/introduction/elements
44. "Technique #3: Examples in Prompts: From Zero-Shot to Few-Shot." Learn Prompting. March 6, 2025. Accessed June 30, 2025. https://learnprompting.org/docs/basics/few_shot
45. "Mastering Persona Prompts: A Guide to Leveraging Role-Playing in LLM-Based Applications like ChatGPT or Google Gemini." Medium Ankit Kumar. February 16, 2025. Accessed June 30, 2025. https://architectak.medium.com/mastering-persona-prompts-a-guide-to-leveraging-role-playing-in-llm-based-applications-1059c8b4de08
46. "Ollama Model File." GitHub ollama/ollama. July 11, 2025. Accessed July 22, 2025. https://github.com/ollama/ollama/blob/main/docs/modelfile.md
47. "How to Customize LLM Models with Ollama’s Modelfile?" Collabnix. March 20, 2025. https://collabnix.com/how-to-customize-llm-models-with-ollamas-modelfile/
48. "Ollama - Building a Custom Model." Unmesh Gundecha. October 22, 2023. Accessed July 22, 2025. https://unmesh.dev/post/ollama_custom_model/
49. "How to uninstall Ollama." Collabnix. April 15, 2024. Accessed July 22, 2025. https://collabnix.com/how-to-uninstall-ollama/
50. "Stop Ollama #690." GitHub ollama/ollama. July 20, 2025. Accessed July 22, 2025. https://github.com/ollama/ollama/issues/690
51. "how to remove ollama from macos? #2028." GitHub ollama/ollama. June 26, 2025. Accessed July 22, 2025. https://github.com/ollama/ollama/issues/2028
