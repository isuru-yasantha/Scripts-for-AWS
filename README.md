# Scripts-for-AWS EBS mounting

USE-CASE:
This script can be used for mount pre created aws ebs volume to a aws ec2-instance when a instance respawing in a termination.

EXAMPLE:
We can use this when we are using data on a seperate EBS volume and don't want lost data when an instance termination. Also need to mount again
to the new instance booting up based on availabilty zone of the instace.

REQUIREMENTS:
AWS-CLI should be installed and configured on script running instance.

NOTE:
Tag values are used for filtering purposes.
