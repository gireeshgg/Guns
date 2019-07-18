export TERRAFORMVM=`cat terraform/public_ip.txt`
cat <<EOF > /etc/ansible/hosts
[terraformhost]
wpznv87178dns2.eastus2.cloudapp.azure.com  ansible_connection=ssh ansible_user=devopsinfra ansible_ssh_private_key_file=/home/devopsinfra/.ssh/id_rsa 
[terraformvm]
${TERRAFORMVM} ansible_connection=ssh   ansible_user=ubuntu    ansible_ssh_private_key_file=/home/devopsinfra/terraform.pem
EOF
