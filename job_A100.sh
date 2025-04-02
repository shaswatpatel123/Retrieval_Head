#!/bin/bash

#SBATCH --job-name=
#SBATCH --nodes=1                     # Request 1 compute node per job instance
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=36GB                     # Request 2GB of RAM per job instance
#SBATCH --time=04:00:00                # Request 10 mins per job instance
#SBATCH --output=/scratch/vt2369/ETNLP_Project/slurm_output/llama1b3bennl_%A.out  # The output will be saved here. %A will be replaced by the slurm job ID, and %a will be replaced by the SLURM_ARRAY_TASK_ID
#SBATCH --mail-user=vt2369@nyu.edu    # Email address
#SBATCH --mail-type=BEGIN,END         # Send an email when all the instances of this job are completed
module purge                          # unload all currently loaded modules in the environment

echo "Running: Llama-3.2-1B English"
/scratch/vt2369/ETNLP_Project/spin_env_rw.sh python /scratch/vt2369/ETNLP_Project/Retrieval_Head/retrieval_head_detection.py --model_path "meta-llama/Llama-3.2-1B" -s 0 -e 45000 --language en

echo "Running: Llama-3.2-1B Dutch"
/scratch/vt2369/ETNLP_Project/spin_env_rw.sh python /scratch/vt2369/ETNLP_Project/Retrieval_Head/retrieval_head_detection.py --model_path "meta-llama/Llama-3.2-1B" -s 0 -e 45000 --language nl

echo "Running: Llama-3.2-3B English"
/scratch/vt2369/ETNLP_Project/spin_env_rw.sh python /scratch/vt2369/ETNLP_Project/Retrieval_Head/retrieval_head_detection.py --model_path "meta-llama/Llama-3.2-3B" -s 0 -e 45000 --language en

echo "Running: Llama-3.2-3B Dutch"
/scratch/vt2369/ETNLP_Project/spin_env_rw.sh python /scratch/vt2369/ETNLP_Project/Retrieval_Head/retrieval_head_detection.py --model_path "meta-llama/Llama-3.2-3B" -s 0 -e 45000 --language nl
