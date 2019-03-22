# sshd

This is a general purpose image running SSHd for functional tests.

## Getting Started

Setup keys and run a container as follows:

```sh
# Generate a key
ssh-keygen -t rsa -N '' -C '' -f id_rsa

# Generate host keys
mkdir -p etc/ssh
ssh-keygen -A -f .

# Run a container
docker run --rm -p 22:22 \
  -e "SSH_HOST_DSA_KEY=$(cat etc/ssh/ssh_host_dsa_key)" \
  -e "SSH_HOST_RSA_KEY=$(cat etc/ssh/ssh_host_rsa_key)" \
  -e "SSH_HOST_ECDSA_KEY=$(cat etc/ssh/ssh_host_ecdsa_key)" \
  -e "SSH_HOST_ED25519_KEY=$(cat etc/ssh/ssh_host_ed25519_key)" \
  -e "SSH_AUTHORIZED_KEYS=$(cat id_rsa.pub)" \
  int128/sshd
```

Now you can connect to the container via SSH.

```sh
ssh -o UserKnownHostsFile=known_hosts -i id_rsa tester@localhost
```

## Usage

You need to set the following environment variables:

- `SSH_HOST_DSA_KEY` - DSA host key
- `SSH_HOST_RSA_KEY` - RSA host key
- `SSH_HOST_ECDSA_KEY` - ECDSA host key
- `SSH_HOST_ED25519_KEY` - ED25519 host key

You can set the following environment variables:

- `SSH_USERNAME` - username (default: `tester`)
- `SSH_PASSWORD` - password (default: `hello`)
- `SSH_AUTHORIZED_KEYS` - authorized keys for the user
