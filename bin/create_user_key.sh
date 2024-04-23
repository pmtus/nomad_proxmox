#! /bin/bash
# Create a public/private key pair for the user with ed25519 algorithm
# and add the public key to the authorized_keys file
# Usage: ./create_user_key.sh <username>

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

username=$1
# Check if the user is root and change the key_dir to not include /home
if [ "$username" == "root" ]; then
    key_dir="/root/.ssh"
else key_dir="/home/$username/.ssh"
key_file="$key_dir/id_ed25519"

if [ -f "$key_file" ]; then
    echo "Key file $key_file already exists"
    exit 1
fi

mkdir -p $key_dir
chown $username:$username $key_dir
chmod 700 $key_dir

sudo -u $username ssh-keygen -t ed25519 -f $key_file -N ""

cat $key_file.pub >> $key_dir/authorized_keys
chown $username:$username $key_dir/authorized_keys
chmod 600 $key_dir/authorized_keys

echo "Key pair created for user $username"
echo "Public key added to $key_dir/authorized_keys"
echo "Private key saved to $key_file"

exit 0