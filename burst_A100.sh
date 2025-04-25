#!/bin/bash


#SBATCH --job-name=rh_a100_30k
#SBATCH --output=/scratch/vt2369/ETNLP_Project/slurm_output/out_%A_%a.out
#SBATCH --account=cs_ga_3033_102-2025sp
#SBATCH --partition=c24m170-a100-2
#SBATCH --gres=gpu:a100:2
#SBATCH --time=09:00:00
#SBATCH --cpus-per-task=2             # Request 1 CPU per job instance
#SBATCH --mem=32GB
#SBATCH --mail-user=vt2369@nyu.edu
#SBATCH --mail-type=BEGIN,END

module purge                          # unload all currently loaded modules in the environment

export WANDB_ENTITY=ETNLP_Project
export WANDB_PROJECT=retrieval-head-detection
export WANDB_NAME=rh_a100_30k_en

PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True /scratch/vt2369/ETNLP_Project/spin_env.sh python3 retrieval_head_detection.py --model_path "microsoft/Phi-3.5-mini-instruct" --s 0 --e 30000 --language "en" --wandb --quantize
export WANDB_NAME=rh_a100_30k_zh
PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True /scratch/vt2369/ETNLP_Project/spin_env.sh python3 retrieval_head_detection.py --model_path "microsoft/Phi-3.5-mini-instruct" --s 0 --e 30000 --language "zh" --wandb --quantize

export WANDB_NAME=rh_a100_30k_de
PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True /scratch/vt2369/ETNLP_Project/spin_env.sh python3 retrieval_head_detection.py --model_path "microsoft/Phi-3.5-mini-instruct" --s 0 --e 30000 --language "de" --wandb --quantize

export WANDB_NAME=rh_a100_30k_ar
PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True /scratch/vt2369/ETNLP_Project/spin_env.sh python3 retrieval_head_detection.py --model_path "microsoft/Phi-3.5-mini-instruct" --s 0 --e 30000 --language "ar" --wandb --quantize
