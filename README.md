# Word Prediction App
This project was the final part of a 10 course Data Science track by Johns Hopkins University on Coursera. It was done as an industry/university partnership with SwiftKey. The main goal was to clean and analyze a large corpora of unstructured texts from blogs, news and twitter and build a word prediction model and use it in a web application.

The discipline used to perform this task is Natural Language Processing, also know as NLP, and the chosen modeling technique is N-Gram, which is a special type of wordform that looks (N - n) words into the past and possesses the memory less properties of a Markov model. In other words, it is a contiguous sequence of n items from a given sequence of text or speech.

This project will work on 1-Gram (N: n=1), 2-Gram (N: n=2) and 3-Gram (N: n=3) models. The basic building blocks of the models are unigrams, bigrams, and trigrams. 

For more information, check the report I wrote for the project at [Milestone Report - Data Science Project](https://rpubs.com/marcelo_tibau/252490) 

To predict, I settled to Google's stupid backoff algorithm, a smoothing method, that is inexpensive to train on large data sets and approaches the quality of Kneser-Ney Smoothing as the amount of training data increases.

*Reference: Brants, Thorsten; Popat, Ashok C; Xu, Peng; Och, Franz J; Dean, Jeffrey. “Large language models in machine translation”. EMNLP/CoNLL. 2007.* 
