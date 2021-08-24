# Acoustic model personalisation

1/ Datasets: 

Experiments to train acoustic models were conducted with the TEDLIUM 3 dataset, a large corpus of 452 hours of TED talks. 
The dataset is ready for training ASR systems but also dedicated to speaker adaptation tasks. We processed the dataset in an original way for this set of experiments. We split it into three parts so that the sets of speakers in each part are pairwise disjoints.
The first part is called generic and has been used to train an initial acoustic model for ASR.
The two other parts called perso1 and perso2 are used for 2 distinct trials of model personalization and evaluation.


2/ Methodology:

A - Train a generic acoustic model

B - For all data in perso1 and perso2 FineTune the generic acoustic model using only the 5 first minutes (use the script )

C - 


