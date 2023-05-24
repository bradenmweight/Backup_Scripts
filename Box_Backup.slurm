#!/bin/bash
#SBATCH -p action
#SBATCH -J BACKUP
#SBATCH -o output.slurm
#SBATCH -t 1:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=12
#SBATCH --mem 10GB

export OMP_NUM_THREADS=12
export TRANSFERS=12 # I/O to remote server
export CHECKERS=12  # Compare with remote server

module load rclone

export MAX_SIZE=1  # in {SIZE_UNITS} -- input as integer
export SIZE_UNITS="M" # "M"  (for MB) or "G" (for GB)
export RCLONE_VERBOSE=1 # 1 for verbose, 2 for very verbose, do not export variable for non-verbose
export RCLONE_SKIP_LINKS=false # Copy links as well

export FROM="/scratch/bweight/"
export TO="Braden_Box:Huo_Lab/Braden_Weight/scratch/"

echo "" >> backup_log.txt
echo $(date) >> backup_log.txt
echo " Backing Up Filesystem:" >> backup_log.txt
echo "   FROM: ${FROM}* " >> backup_log.txt
echo "     TO: ${TO}" >> backup_log.txt
echo " Modifiers: " >> backup_log.txt
echo "   Only syncing files smaller than ${MAX_SIZE}${SIZE_UNITS}B" >> backup_log.txt
echo "   Using ${TRANSFERS} file transfer processes" >> backup_log.txt
echo "   Using ${CHECKERS} file checking processes" >> backup_log.txt
echo "" >> backup_log.txt

rclone sync ${FROM}/ ${TO}/ --max-size ${MAX_SIZE}${SIZE_UNITS} --transfers=${TRANSFERS} --checkers=${CHECKERS} --exclude-from exclude.txt

echo "Finished: $(date)" >> backup_log.txt