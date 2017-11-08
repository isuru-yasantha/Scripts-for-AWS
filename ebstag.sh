#!/bin/bash

ServiceID=AESP
Environment=STG

#getting instance ids

for i in $(aws ec2 describe-instances  --filter  Name=tag-value,Values=$ServiceID Name=tag-value,Values=$Environment --query 'Reservations[*].Instances[*].InstanceId' --output text); do
# getting tag values based on key values
iName=$(aws ec2 describe-instances --instance-id $i --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value | [0]]' --output text)
iServiceid=$(aws ec2 describe-instances --instance-id $i --query 'Reservations[].Instances[].[Tags[?Key==`Service ID`].Value | [0]]' --output text)
iEnvironment=$(aws ec2 describe-instances --instance-id $i --query 'Reservations[].Instances[].[Tags[?Key==`Environment`].Value | [0]]' --output text)

#getting volume ids attached to the instances
   for j in $(aws ec2 describe-volumes --filters Name=attachment.instance-id,Values=$i --query 'Volumes[*].{ID:VolumeId}' --output text); do
# checking there tag values
   vName=$(aws ec2 describe-volumes --volume-id $j --query 'Volumes[].[Tags[?Key==`Name`].Value | [0]]' --output text)
   vServiceid=$(aws ec2 describe-volumes --volume-id $j --query 'Volumes[].[Tags[?Key==`Service ID`].Value | [0]]' --output text)
   vEnvironment=$(aws ec2 describe-volumes --volume-id $j --query 'Volumes[].[Tags[?Key==`Environment`].Value | [0]]' --output text)

# if there are no tag values assign instance tag values to  the volumes


          if [ "$iName" != "None" ] && [ "$vName" == "None" ]; then
              aws ec2 create-tags --resources $j --tags Key=Name,Value="'`echo $iName`'"

          fi

          if [ "$iServiceid" != "None" ] && [ "$vServiceid" == "None" ]; then
              aws ec2 create-tags --resources $j --tags Key="Service ID",Value=`echo $iServiceid`
          fi

          if [ "$iEnvironment" != "None" ] && [ "$vEnvironment" == "None" ]; then
              aws ec2 create-tags --resources $j --tags Key=Environment,Value=`echo $iEnvironment`
          fi
   done
done
