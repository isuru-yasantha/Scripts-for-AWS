# EBS mounting - ebsmount.sh

USE-CASE:
This script can be used for mount pre created aws ebs volume to a aws ec2-instance when a instance respawing in a termination.

EXAMPLE:
We can use this when we are using data on a seperate EBS volume and don't want lost data when an instance termination. Also need to mount again
to the new instance booting up based on availabilty zone of the instace.

REQUIREMENTS:
AWS-CLI should be installed and configured on script running instance.

NOTE:
Tag values are used for filtering purposes.

# EBS Tagging - ebstag.sh

USE-CASE:
This script can be used for tagging untagged ebs volumes with attached instance tags.

EXAMPLE:
We can use the script for incidents like, you have different aws deployments with different environments and you are not already attach tags to ebs volumes which are attached to the instances. Using filter values based on your requirement, this script can attach tags which are already attached to the instances. Here we have used Service ID and Environment for filtering purposes.

REQUIREMENTS:
AWS-CLI should be installed and configured on script running instance.
