# SSH Documentation
This is a documentation on ssh related tools and commands

## Concepts
```
SSH is the clinet
SSHD is the server (Open SSH Daemon)
```

Generate keys
```
$ ssh-keygen
~/.ssh/id_ras     - Private key
~/.ssh/id_ras.pub - Public key
```

Start ssh-agent in the background
```
$ eval "$(ssh-agent -s)"
```

Add key
```
$ ssh-add ~/.ssh/id_rsa
```

Check saved keys
```
$ ssh-add -l
```

Delete all cached keys
```
$ ssh-add -D
```

Check and modify sshd setting
```
$ sudo vim /etc/ssh/sshd_config
```

## Reference
* [SSH Crash Course | With Some DevOps](https://www.youtube.com/watch?v=hQWRp-FdTpc)
* [Adding a new SSH key to your GitHub account - GitHub Docs](https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)
