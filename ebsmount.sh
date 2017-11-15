#!/bin/bash

#getting instance az
abzone=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

#getting availble ebs  volume-id
ebsvolume=$(/var/awslogs/bin/aws ec2 describe-volumes --filters Name=tag-value,Values=project Name=tag-value,Values=environment Name=tag-value,Values=product Name=availability-zone,Values=`echo $abzone` --query 'Volumes[*].[VolumeId, State==`available`]' --output text  | grep True | awk '{print $1}' | head -n 1)

#check if there are avaible ebs vloumes

if [ -n "$ebsvolume" ]; then

#getting instance id
    instanceid=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
#attaching ebs
    /var/awslogs/bin/aws ec2 attach-volume --volume-id `echo $ebsvolume` --instance-id `echo $instanceid` --device /dev/xvdk

    sleep 10
    # mount ebs to /mnt
    mount /dev/xvdk /mnt/data
fi
