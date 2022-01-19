# Acoustic model personalisation

1/ Datasets: 

Experiments to train acoustic models were conducted with the TEDLIUM 3 dataset (https://lium.univ-lemans.fr/ted-lium3/), a large corpus of 452 hours of TED talks. 
The dataset is ready for training ASR systems but also dedicated to speaker adaptation tasks. We processed the dataset in an original way for this set of experiments. We split it into three parts so that the sets of speakers in each part are pairwise disjoints.
The first part is called generic and has been used to train an initial acoustic model for ASR.
The two other parts called perso1 and perso2 are used for 2 distinct trials of model personalization and evaluation.

More details of TEDLIUM3 dataset are given in this paper:
François Hernandez, Vincent Nguyen, Sahar Ghannay, Natalia Tomashenko, and Yannick Estève, “TED-LIUM 3: twice as much data and corpus repartition for experiments on speaker adaptation”, submitted to the 20th International Conference on Speech and Computer (SPECOM 2018), September 2018, Leipzig, Germany


2/ Methodology:

A - Train a generic acoustic model (use the TEDLIUM Kaldi recipe) with changing the data (use only the data in the file Files_Names_Generic_model)

B - For all data in perso1 and perso2 : FineTune the generic acoustic model using only the 5 first minutes (use the script FineTuning.sh)


Salima Mdhaffar, Marc Tommasi, and Yannick Estève, "Study on acoustic model personalization in a ontext of collaborative learning constrained by privacy preservation", 23th International Conference on Speech and Computer (SPECOM 2021), September 2021, ST. PETERSBURG, RUSSIA

3/ Acoustic models with ivectors:

Acoustic models for perso1/session1: [[Models_perso1_sessions2_with_ivectors]](https://github.com/mdhaffar/Acoustic_model_personalisation/releases/tag/V.0.4.0)

Acoustic models for perso1/session2: [[Models_perso1_sessions2_with_ivectors]](https://github.com/mdhaffar/Acoustic_model_personalisation/releases/tag/V.0.2.0)

Acoustic models for perso2/session1: [[Models_perso2_sessions1_with_ivectors]](https://github.com/mdhaffar/Acoustic_model_personalisation/releases/tag/V0.0.1).

Acoustic models for perso2/session2: [[Models_perso2_sessions2_with_ivectors]](https://github.com/mdhaffar/Acoustic_model_personalisation/releases/tag/V.0.1.0).

4/ Acoustic models without ivectors:

Acoustic models for perso1/session1 [[Models_perso1_sessions2_without_ivectors]](https://github.com/mdhaffar/Acoustic_model_personalisation/releases/tag/V.0.4.0)

Acoustic models for perso1/session2 [[Models_perso1_sessions2_without_ivectors]](https://github.com/mdhaffar/Acoustic_model_personalisation/releases/tag/V.0.2.0)

Acoustic models for perso2/session1 [[Models_perso2_sessions1_without_ivectors]](https://github.com/mdhaffar/Acoustic_model_personalisation/releases/tag/V0.0.1)

Acoustic models for perso2/session2 [[Models_perso2_sessions2_without_ivectors]](https://github.com/mdhaffar/Acoustic_model_personalisation/releases/tag/V.0.7.0).

5/ Generic acoustic model:

Generic acoustic model with i-vectors: [[Generic_model_with_ivectors]](https://github.com/mdhaffar/Acoustic_model_personalisation/releases/tag/V.0.5.0)

Generic acoustic model without i-vectors:[[Generic_model_without_ivectors]](https://github.com/mdhaffar/Acoustic_model_personalisation/releases/tag/V.0.6.0)

To extract textual informations (weights/parameters) from mdl files, please run this Kaldi command: nnet3-am-copy --raw=true --binary=false file_input.mdl file_output.mdl

Personnalized Acoustic models can also be genereted using the following script: [[script]](https://github.com/mdhaffar/Acoustic_model_personalisation/blob/main/FineTuning.sh) by using the generic acoustic model with ivectors [[here]](https://github.com/mdhaffar/Acoustic_model_personalisation/releases/tag/V.0.5.0) or without-ivectors [[here]](https://github.com/mdhaffar/Acoustic_model_personalisation/releases/tag/V.0.6.0)
