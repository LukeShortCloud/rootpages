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

Ollama is a large language model (LLM) that is the best free and open source alternative to ChatGPT. [54]

Installation [58]:

-  Linux

   .. code-block:: sh

      $ curl -fsSL https://ollama.com/install.sh | sh

-  macOS

   -  Download the latest version `here <https://ollama.com/download/Ollama-darwin.zip>`__.

Ollama provides many different models. These are categorized by how many billions (B) of parameters the use. The higher the number, the more accurate it is but at the cost of more memory usage. The download size of a model is usually also the minimum size of VRAM needed to run the model. [55]

For PCs, use Ollama 8B for ChatGPT 3.5 quality. It is a 5 GB download. [56]

.. code-block:: sh

   $ ollama run llama3.1

For phones and low-end hardware, use Ollama 3B which is more efficient while being similar to Ollama 8B. It is a 2 GB download. [57]

.. code-block:: sh

   $ ollama run llama3.2

For PCs wanting to have image recognition as part of the LLM, use Ollama 11B. It is a 8 GB download. Provide the full path to the image file when chatting with Ollama. [59]

.. code-block:: sh

   $ ollama run llama3.2-vision

For high-end PCs and ChatGPT 4 quality, use at least Ollama 70B. [60] The community has created smaller bit models (1-bit, 2-bit, and 4-bit). The 1-bit IQ1_M model is not very good. The 4-bit Q4_K_M model is too big for consumer PCs. The 2-bit IQ2_XS model is the best balance of size and reliability. It is a 21 GB download. [61][62]

.. code-block:: sh

   $ ollama run hf.co/lmstudio-community/Meta-Llama-3-70B-Instruct-GGUF:IQ2_XS

For code programming, the DeepSeek-Coder model is recommended. This is a 9 GB download. [63]

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
