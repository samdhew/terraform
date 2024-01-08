#!/bin/bash

echo "Hello! Hello!" > /tmp/hello_infra.txt

export INFRA_BASE=/home/db_user
export MOUNT_DIR=/data
echo OS_NAME=$(cat /etc/os-release | head -1 | awk -F'=' '{print $2}' | tr -d '"') >> /etc/environment
export TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
echo INSTANCE_NAME=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/tags/instance/Name) >> /etc/environment
echo INSTANCE_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4) >> /etc/environment
echo INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id) >> /etc/environment
echo INSTANCE_ENV=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/tags/instance/t_environment) >> /etc/environment
if [[ $INSTANCE_ENV == *"prod"* ]] || [[ $INSTANCE_ENV == *"prd"* ]]; then
    echo NR_PARAM_STORE_NAME=/DB/NEWRELIC_PROD_LICENSE_KEY >> /etc/environment
else
    echo NR_PARAM_STORE_NAME=/DB/NEWRELIC_NON_PROD_LICENSE_KEY >> /etc/environment
fi

# Execute permission for /etc/environment and source
chmod +x /etc/environment
source /etc/environment || echo "already sourced"

# Update hostname
echo "local-ipv4: $INSTANCE_IP"
echo "instance-id: $INSTANCE_ID"
echo 127.0.0.1 localhost "$INSTANCE_NAME"-"$INSTANCE_ID" >> /etc/hosts
hostnamectl set-hostname "$INSTANCE_NAME"-"$INSTANCE_ID"
hostname

# Copy infra setup scripts to instance
cd $INFRA_BASE
aws s3 cp s3://db-artifactbucket/infrasetup.tar.gz .
tar -xzvf infrasetup.tar.gz
ls -lah

# Format filesystem and mount EBS $MOUNT_DIR partition
chmod +x $INFRA_BASE/infrasetup/ebs.sh
bash $INFRA_BASE/infrasetup/ebs.sh "$MOUNT_DIR" > $INFRA_BASE/infrasetup/ebs.log

# Install NewRelic infra corresponding to the environment
export NR_LICENSE=$(aws ssm get-parameter --name $NR_PARAM_STORE_NAME  --with-decryption --output text | awk '{ print $7 }')
echo "license_key: $NR_LICENSE" | tee -a /etc/newrelic-infra.yml

if [ $OS_NAME == "Ubuntu" ] ;
then
curl -fsSL https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/newrelic-infra.gpg
echo "deb https://download.newrelic.com/infrastructure_agent/linux/apt focal main" | tee -a /etc/apt/sources.list.d/newrelic-infra.list ## Ubuntu 20.04 LTS (Focal Fossa)
apt-get update
dpkg -l newrelic-infra &> /dev/null && echo "Infra Agent Installed" || apt-get install newrelic-infra -y
else
curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo ## CentOS, RHEL, Oracle Linux 7.x (x86)
yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
rpm -qa | grep -i newrelic-infra* &> /dev/null && echo "Infra Agent Installed" || yum install newrelic-infra -y
fi

# Start CW Agent with custom config
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a stop
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a start
