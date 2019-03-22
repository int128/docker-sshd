#!/bin/sh
set -e

adduser -D "$SSH_USERNAME"
echo "$SSH_USERNAME:$SSH_PASSWORD" | chpasswd

# configure public key authentication
mkdir -v -p -m 700 "/home/$SSH_USERNAME/.ssh"
echo "$SSH_AUTHORIZED_KEYS" > "/home/$SSH_USERNAME/.ssh/authorized_keys"
chmod -v 600 "/home/$SSH_USERNAME/.ssh/authorized_keys"
chown -v -R "$SSH_USERNAME" "/home/$SSH_USERNAME/.ssh"

# configure host keys
mkdir -v -p -m 700 /etc/ssh
echo "$SSH_HOST_DSA_KEY" > /etc/ssh/ssh_host_dsa_key
echo "$SSH_HOST_RSA_KEY" > /etc/ssh/ssh_host_rsa_key
echo "$SSH_HOST_ECDSA_KEY" > /etc/ssh/ssh_host_ecdsa_key
echo "$SSH_HOST_ED25519_KEY" > /etc/ssh/ssh_host_ed25519_key
chmod -v 600 /etc/ssh/*

# configure sudo without password
touch /etc/sudoers.d/nopasswd
chmod -v 440 /etc/sudoers.d/nopasswd
echo "$SSH_USERNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nopasswd

exec /usr/sbin/sshd -D -e
