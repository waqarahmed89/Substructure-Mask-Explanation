#!/bin/bash
# usage:
# cd /data01/wahmed/codes/Substructure-Mask-Explanation && ./run_sme_DK.sh


### activate conda environment
echo "Activating conda environment: ssl"
source /home/wahmed/miniforge3/etc/profile.d/conda.sh
conda activate ssl


##
echo "Step 1: Build graph datasets"
cd /data01/wahmed/codes/Substructure-Mask-Explanation/MaskGNN_interpretation
mkdir -p ../data/graph_data
python build_graph_dataset.py --task_name ESOL


##
echo "Step 2: Calculate the prediction of molecules without any substructure masked"
cd /data01/wahmed/codes/Substructure-Mask-Explanation/MaskGNN_interpretation
mkdir -p ../model
mkdir -p ../result
mkdir -p ../prediction
mkdir -p ../prediction/mol
CUDA_VISIBLE_DEVICES=0 python Main.py --task_name ESOL


###
echo "Step 3: Calculate the prediction of molecules with different substructures masked"
cd /data01/wahmed/codes/Substructure-Mask-Explanation/MaskGNN_interpretation
mkdir -p ../prediction/brics
mkdir -p ../prediction/summary
CUDA_VISIBLE_DEVICES=0 python SMEG_explain_for_substructure.py


###
echo "Step 4: Summary the prediction of molecules with different substructures masked"
cd /data01/wahmed/codes/Substructure-Mask-Explanation/MaskGNN_interpretation
python prediction_summary.py


###
echo "Step 5: Calculate the attribution of different substructures"
cd /data01/wahmed/codes/Substructure-Mask-Explanation/MaskGNN_interpretation
python attribution_calculate.py