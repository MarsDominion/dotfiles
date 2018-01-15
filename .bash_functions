# THIS FILE IS UNDER VERSION CONTROL.  MAKE CHANGES IN YOUR REPO!!!!! #
#*********************************************************************#

# Quick Function to get a shell on a docker container
dockershell() {
      docker exec -i -t $1 /bin/bash
}
dockerip() {
  docker inspect $1|jq -r .[0].NetworkSettings.Networks.docker_default.IPAddress

}
setaws() {
  export AWS_PROFILE=$1
}

ec2ip() {
  aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value|[0],PrivateIpAddress, KeyName]" --output table
}

ec2list() {
  aws ec2 describe-instances --query "Reservations[*].Instances[*].[PrivateIpAddress, Tags[?Key=='Name'].Value|[0]]" --output table
}

rdslist() {
  aws rds describe-db-instances --query "DBInstances[*].[DBInstanceIdentifier, Engine]" --output table
}

rdsendpoint() {
  aws rds describe-db-instances --filters "Name=db-instance-id,Values=$1" --query "DBInstances[*].[DBInstanceIdentifier, Engine, Endpoint.Port, Endpoint.Address]" --output table
}
