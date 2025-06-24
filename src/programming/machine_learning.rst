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

AI Prompt Engineering
---------------------

Ollama
~~~~~~

Usage
^^^^^

Ollama is a large language model (LLM) that is the best free and open source alternative to ChatGPT. [8]

Installation [9]:

-  Linux

   .. code-block:: sh

      $ curl -fsSL https://ollama.com/install.sh | sh

-  macOS

   -  Download the latest version `here <https://ollama.com/download/Ollama-darwin.zip>`__.

Ollama provides many different models. These are categorized by how many billions (B) of parameters the use. The higher the number, the more accurate it is but at the cost of more memory usage. The download size of a model is usually also the minimum size of VRAM needed to run the model. [10]

For PCs, use Ollama 8B for ChatGPT 3.5 quality. It is a 5 GB download. [11]

.. code-block:: sh

   $ ollama run llama3.1

For phones and low-end hardware, use Ollama 3B which is more efficient while being similar to Ollama 8B. It is a 2 GB download. [12]

.. code-block:: sh

   $ ollama run llama3.2

For PCs wanting to have image recognition as part of the LLM, use Ollama 11B. It is a 8 GB download. Provide the full path to the image file when chatting with Ollama. [13]

.. code-block:: sh

   $ ollama run llama3.2-vision

For high-end PCs and ChatGPT 4 quality, use at least Ollama 70B. [14] The community has created smaller bit models (1-bit, 2-bit, and 4-bit). The 1-bit IQ1_M model is not very good. The 4-bit Q4_K_M model is too big for consumer PCs. The 2-bit IQ2_XS model is the best balance of size and reliability. It is a 21 GB download. [15][16]

.. code-block:: sh

   $ ollama run hf.co/lmstudio-community/Meta-Llama-3-70B-Instruct-GGUF:IQ2_XS

For code programming, the Qwen Coder or DeepSeek Coder model is recommended. Both are a 9 GB download. [17][18]

.. code-block:: sh

   $ ollama run qwen2.5-coder:14b

.. code-block:: sh

   $ ollama run deepseek-coder-v2:16b

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

Most LLMs use a float 16 value. It is possible to use quantization to lower the memory usage. This allows for running larger models and/or increasing the context size.

Common and recommended values [20]:

-  ``f32`` = Lossless.
-  ``f16`` = Half the size of ``f32``. Default for most models. Performs the same as ``f32`` in most cases.
-  ``q5_k_m`` = About 6x smaller compared to ``f32`` with only a minor loss in quality.
-  ``q4_k_m`` = About 7x smaller compared to ``f32`` but a moderate quality loss.

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

-  DuckDuckGo is the easiest to configure since it does not require an API key. However, search results are normally rate limited. [25]

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
15. "Running Llama-3-70B gguf on 24gig VRAM." Reddit r/LocalLLaMA. April 24, 2024. Accessed December 12, 2024. https://www.reddit.com/r/LocalLLaMA/comments/1c7owci/running_llama370b_gguf_on_24gig_vram/
16. "lmstudio-community/Meta-Llama-3-70B-Instruct-GGUF." Hugging Face. Accessed December 12, 2024. https://huggingface.co/lmstudio-community/Meta-Llama-3-70B-Instruct-GGUF
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
