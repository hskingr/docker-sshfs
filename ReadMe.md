need to make a bind mount out of the data directory 

commands

mount --bind /mnt/sshfs-files /mnt/sshfs-files && mount --make-shared /mnt/sshfs-files

this is for running and entering the container

docker-compose down && docker-compose up -d --build sshfs && docker exec -it sshfs-new bash

build and run attached 

docker-compose up --build sshfs

** if the folder is busy on the host machine then unmount the folder:

umount /mnt/files


22/02/2022
getting permission denied error
when going into the container and doing a normal ssh command, I get promted with a password
Need to figure out what is stopping the id_rsa file from authenticating
Check the host server for permission or other problems
Check the folder permissions for permission or other problems
23/02/2022
fixed all errors
need to make documentations incase error happens again
