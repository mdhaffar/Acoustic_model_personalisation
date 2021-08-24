#!/usr/bin/env bash
#author: Salima Mdhaffar (Monday 2 Nov 23:06)

#before runing this script run:
#/nnet3-am-copy --raw=true ../s5_r3/exp/chain_cleaned_1d/tdnn1d_sp/final.mdl nnet_final.raw
#nnet3-init Funetining/configs/init.config Funetining/configs/init.raw
#to convert generic acoustic model to .raw

source path.sh
stm_file=$(ls ./stm_div/) #
 for dset in $stm_file; do
    #prepare data
    utils/data/modify_speaker_info.sh --seconds-per-spk-max 180 data/${dset}.orig $rep_out/data/${dset}
    rm -r data/${dset}.orig
    #Make mfcc
    dir=$rep_out/data/$dset
    steps/make_mfcc.sh --nj 1 --cmd "run.pl" $dir
    #compute cmvn
    steps/compute_cmvn_stats.sh $dir
    #Align
    steps/align_fmllr.sh --nj 1 $rep_out/data/$dset ./data/lang ./exp/tri3 $rep_out/exp/tri3_speaker/tri3_ali_$dset
    #Clean data
    steps/cleanup/clean_and_segment_data.sh $rep_out/data/$dset ./data/lang $rep_out/exp/tri3_speaker/tri3_ali_$dset/ $rep_out/data/f_ir2_$dset $rep_out/data/train_cleaned_$dset
    #Alignement for clean data
    steps/align_fmllr.sh --nj 1 $rep_out/data/train_cleaned_$dset/ ./data/lang ./exp/tri3 $rep_out/exp/tri3_ali_cleaned_$dset
    #Perturb data
    utils/data/perturb_data_dir_speed_3way.sh $rep_out/data/train_cleaned_$dset $rep_out/data/train_cleaned_${dset}_sp
    #Copie from sp to sp_hires
    utils/copy_data_dir.sh $rep_out/data/train_cleaned_${dset}_sp $rep_out/data/train_cleaned_${dset}_sp_hires
    #Extract Mfcc for sp data
    steps/make_mfcc.sh --nj 1 $rep_out/data/train_cleaned_${dset}_sp
    #compute cmvn for sp data
    steps/compute_cmvn_stats.sh $rep_out/data/train_cleaned_${dset}_sp/
    # makes sure that only the segments present in all of "feats.scp", "wav.scp" [if present], segments [if present] text, and utt2spk are present in any of them.
    utils/fix_data_dir.sh $rep_out/data/train_cleaned_${dset}_sp/
    #Alignement for sp data
    steps/align_fmllr.sh $rep_out/data/train_cleaned_${dset}_sp/ ./data/lang ./exp/tri3_cleaned $rep_out/exp/tri3_ali_cleaned_${dset}_sp
    #perturb the volume of data
    utils/data/perturb_data_dir_volume.sh $rep_out/data/train_cleaned_${dset}_sp_hires
    #make mfcc for perturbed data
    steps/make_mfcc.sh --nj 1 --mfcc-config conf/mfcc_hires.conf $rep_out/data/train_cleaned_${dset}_sp_hires/
    #compute cmvn for perturbed data
        steps/compute_cmvn_stats.sh $rep_out/data/train_cleaned_${dset}_sp_hires/
    # makes sure that only the segments present in all of "feats.scp", "wav.scp" [if present], segments [if present] text, and utt2spk are present in any of them.
    utils/fix_data_dir.sh $rep_out/data/train_cleaned_${dset}_sp_hires/
    #Extract ivectors
    steps/online/nnet2/extract_ivectors_online.sh --cmd run.pl --nj 1 $rep_out/data/train_cleaned_${dset}_sp_hires/ ./exp/nnet3_cleaned_1d/extractor $rep_out/data/ivectors_$dset
    #Alignement for lattices
    steps/align_fmllr_lats.sh --nj 1 $rep_out/data/train_cleaned_${dset}_sp ./data/lang ./exp/tri3_cleaned $rep_out/data/lat_${dset}

    dir=$rep_out/data/$dset
    utils/copy_data_dir.sh $rep_out/data/$dset $rep_out/data/${dset}_hires 

    steps/make_mfcc.sh --nj 1 --mfcc-config conf/mfcc_hires.conf --cmd run.pl $rep_out/data/${dset}_hires
    steps/compute_cmvn_stats.sh $rep_out/data/${dset}_hires
    utils/fix_data_dir.sh $rep_out/data/${dset}_hires

    steps/online/nnet2/extract_ivectors_online.sh --cmd run.pl --nj 1 $rep_out/data/${dset}_hires ./exp/nnet3_cleaned_1d/extractor $rep_out/data/ivectors_${dset}_hires

    #Create file for Transfer Learning and egs
    mkdir $rep_out/Transfer_Learning/Funetuning_v2_512_${dset}
    mkdir $rep_out/Transfer_Learning/Funetuning_v2_512_${dset}/configs

    cp ./exp/chain_cleaned_1d/tdnn1d_sp/configs/network.xconfig $rep_out/Transfer_Learning/Funetuning_v2_512_${dset}/configs
 
