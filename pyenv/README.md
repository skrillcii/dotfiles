# Pyenv

## Useful commands
### Basic pyenv usage
Check availalbe python versions
```
pyenv install --list
```

Install a python versions
```
pyenv install <python-version>
```

Check installed pyenv verions
```
pyenv versions
```

Set global version(s), in order
```
pyenv global <python-versions> system ...
```

Set local version(s), in order
```
pyenv local <python-versions> system ...
```

### Pyenv with virtualenv
Initialize a virtual python version
```
pyenv virtualenv <python-versions> <env-name>
```

For example
```
pyenv virtualenv 3.8.4 project
```

Set project folder too with pyenv local
```
cd /project
pyenv local project
```

Remove virtualenv
```
pyenv uninstall project
```

## References
[Qiiia - pyenv usage](https://qiita.com/ksato9700/items/5d9eba10fe6b8e064178)
