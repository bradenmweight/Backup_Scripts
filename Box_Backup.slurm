#!/bin/bash
#SBATCH -p standard
#SBATCH -J BACKUP
#SBATCH -o output.slurm
#SBATCH -t 2-00:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=36
#SBATCH --mem 10GB

export OMP_NUM_THREADS=36
export TRANSFERS=18 # I/O to remote server
export CHECKERS=18  # Compare with remote server

module load rclone

export MAX_SIZE=5  # in {SIZE_UNITS} -- input as integer
export SIZE_UNITS="M" # "M"  (for MB) or "G" (for GB)
export RCLONE_VERBOSE=1 # 1 for verbose, 2 for very verbose, do not export variable for non-verbose
export RCLONE_SKIP_LINKS=false # Copy links as well

echo "" >> backup_log.txt
echo $(date) >> backup_log.txt
echo " Backing Up Filesystem:" >> backup_log.txt
echo "   FROM: bweight/scratch/* " >> backup_log.txt
echo "     TO: Braden_Box:Huo_Lab/Braden_Weight/scratch/" >> backup_log.txt
echo " Modifiers: " >> backup_log.txt
echo "   Only syncing files smaller than ${MAX_SIZE}${SIZE_UNITS}B" >> backup_log.txt
echo "   Using ${TRANSFERS} file transfer processes" >> backup_log.txt
echo "   Using ${CHECKERS} file checking processes" >> backup_log.txt
echo "" >> backup_log.txt

rclone sync /scratch/bweight/ Braden_Box:Huo_Lab/Braden_Weight/scratch/ --max-size ${MAX_SIZE}${SIZE_UNITS} --transfers=${TRANSFERS} --checkers=${CHECKERS} --exclude-from exclude.txt

echo "Finished: $(date)" >> backup_log.txt