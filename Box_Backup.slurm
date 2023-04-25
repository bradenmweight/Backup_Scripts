#!/bin/bash
#SBATCH -p debug
#SBATCH -J BACKUP
#SBATCH -o output.slurm
#SBATCH -t 1:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --mem 2GB

module load rclone

export MAX_SIZE=1  # in {SIZE_UNITS} -- input as integer
export SIZE_UNITS="M" # "M"  (for MB) or "G" (for GB)

echo "" >> backup_log.txt
echo $(date) >> backup_log.txt
echo "   Backing Up: >> backup_log.txt
echo "   bweight/scratch/* " >> backup_log.txt
echo "   --> Braden_Box:Huo_Lab/Braden_Weight/scratch/" >> backup_log.txt
echo "   Syncing only files smaller than ${MAX_SIZE}${SIZE_UNITS}" >> backup_log.txt

rclone sync /scratch/bweight/ Braden_Box:Huo_Lab/Braden_Weight/scratch/ --max-size ${MAX_SIZE}M

