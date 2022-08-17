#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --time=1:00:00
#SBATCH --mem-per-cpu=8Gb
#SBATCH --array=1-4
#SBATCH --partition=main
#SBATCH --account=ekawaguc_906

if [ ! $SLURM_ARRAY_TASK_ID ]; then
    idx=$1
else
    idx=$SLURM_ARRAY_TASK_ID
fi

# set path
# TO DO: change this path to your own directory: /home1/<username>/rbootcamp/code
cd /project/ekawaguc_906/RBootcamp2022/code

# pull the idx'th line from file params and store in variable named params
params=`sed "${idx}q;d" params_iris`

# split strings in params variable by space and store in bash arg variables
set -- junk $params
shift

var_name=$1
seed_idx=$2
outpath=../result

Rscript glm_iris.R \
	$var_name \
	$seed_idx \
	$outpath
