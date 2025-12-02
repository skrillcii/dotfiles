To add an SSH public key to the authorized_keys file for another user on a Linux system, follow these steps: Obtain the Public Key.

Ensure you have the public key (e.g., id_rsa.pub) of the user you want to grant SSH access to. This key should be generated on the user's local machine.

- Access the Server as Root or a User with Sudo Privileges:

You need to be able to access the target user's home directory and modify files within it.

- Create the .ssh Directory (if it doesn't exist) and Set Permissions:

Log in to the server and, as root or using sudo, switch to the target user's context or navigate to their home directory. Create the .ssh directory if it's missing and set the correct permissions.

```
sudo -i -u <target_username>
mkdir -p ~/.ssh
chmod 700 ~/.ssh
```

Add the Public Key to authorized_keys.
Append the public key to the authorized_keys file within the target user's .ssh directory.

```
echo "<public_key_content>" >> ~/.ssh/authorized_keys
```

Replace <public_key_content> with the actual content of the public key file (e.g., ssh-rsa AAAAB3NzaC... user@hostname). Set Permissions for authorized_keys.
Ensure the authorized_keys file has the correct permissions.

```
chmod 600 ~/.ssh/authorized_keys
```

Verify Ownership (if necessary).
If you performed these steps as root and not by switching to the target user, verify that the .ssh directory and authorized_keys file are owned by the target user.
ソースコード

```
chown -R <target_username>:<target_username> ~/.ssh
```

After these steps, the specified user should be able to log in to the server using their private key associated with the added public key.
