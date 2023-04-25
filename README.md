# Backing up to Box with rclone

# Primary setup website -- Repeated Here
https://rclone.org/box/

To modify/initialize/control your rclone remote sites:
```
$ rclone config
```

The first time running `$ rclone config` will result in the following:
```
No remotes found, make a new one?
n) New remote
s) Set configuration password
q) Quit config
n/s/q> n
name> Braden_Box
Type of storage to configure.
Choose a number from below, or type in your own value
[snip]
XX / Box
   \ "box"
[snip]
Storage> box
Box App Client Id - leave blank normally.
client_id> 
Box App Client Secret - leave blank normally.
client_secret>

If your browser doesn't open automatically go to the following link: http://127.0.0.1:53682/auth
Log in and authorize rclone for access
Waiting for code... 

{"access_token":"XXX","token_type":"bearer","refresh_token":"XXX","expiry":"XXX"}

Got code

--------------------
[Braden_Box]
client_id = 
client_secret = 
token = {"access_token":"XXX","token_type":"bearer","refresh_token":"XXX","expiry":"XXX"}
--------------------
y) Yes this is OK
e) Edit this remote
d) Delete this remote
y/e/d> y
```

## Some useful commands
1. To list directories -- \
```$ rclone lsd Braden_Box:```

2. To list all file -- \
```$ rclone ls Braden_Box:```

3. To copy from BlueHive to Box -- \
 ```$ rclone copy /path/to/local/file Braden_Box:path/to/Box/location/```

4. To sync from BlueHive to Box -- \
```$ rclone sync /path/to/local/files/* Braden_Box:path/to/Box/location/``` 

5. To sync from BlueHive to Box -- \
```rclone sync /scratch/bweight/ Braden_Box:Huo_Lab/Braden_Weight/scratch/ --max-size 5M```

## Submitting a sync job to the cluster via SLURM
1. See ```Box_Backup.slurm``` for a working submission file


### More Information on Filtering Files/Data
https://rclone.org/filtering/
