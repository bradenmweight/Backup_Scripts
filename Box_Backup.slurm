#!/bin/bash
#SBATCH -p standard
#SBATCH -J BACKUP
#SBATCH -o output.slurm
#SBATCH -t 2-00:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=4
#SBATCH --mem 5GB

export OMP_NUM_THREADS=4

module load rclone

export MAX_SIZE=5  # in {SIZE_UNITS} -- input as integer
export SIZE_UNITS="M" # "M"  (for MB) or "G" (for GB)

echo "" >> backup_log.txt
echo $(date) >> backup_log.txt
echo "   Backing Up:" >> backup_log.txt
echo "   FROM: bweight/scratch/* " >> backup_log.txt
echo "     TO: Braden_Box:Huo_Lab/Braden_Weight/scratch/" >> backup_log.txt
echo "   Syncing only files smaller than ${MAX_SIZE}${SIZE_UNITS}" >> backup_log.txt
echo "" >> backup_log.txt

rclone sync /scratch/bweight/ Braden_Box:Huo_Lab/Braden_Weight/scratch/ --max-size ${MAX_SIZE}${SIZE_UNITS} --exclude-from exclude.txt

