# Linux System Documentation 
This documentation is for the record of understanding basics of Linux

## Std Redirection
Reference: [Stderr Stdout and Stdin - How to Redirect them - Commands for Linus](https://www.youtube.com/watch?v=icuV2CR3Ghg)
Use folling command to redirect stdout
```
$ python3 std.py > std.txt
$ python3 std.py 1> std.txt
```

Use folling command to redirect stderr
```
$ python3 std.py 2> std.txt
```

Use folling command to redirect stdout & stderr
```
$ python3 std.py &> std.txt
```

Use >> for append, instead of > for overwrite
```
$ python3 std.py >> std.txt
```

## Termials and Shells
Reference: [Unix termials and shells - 1 of 5](https://www.youtube.com/watch?v=07Q9oqNLXB4)

```
Brief Differences
* /dev/pts/ - directory of pseudo-terminal slaves
* /dev/tty  - controlling terminal file
* /dev/ttyN - virtual console terminal files
```

General process layer
```
process >> (virtual) terminal device >> tty >> pts >> shell
```

Pipline
```
pipeline A && pipeline B - if command A returns 0, then run B
pipeline A || pipeline B - if command A returns non-0, then run B
pipeline A ; pipeline B  - run command A and command B subquently
```

Flow control
```
if command-list then command-list fi
while command-list do command-list done
```

Function
```
function name { command-list }
```

Function foo typical script style with a return
```
function foo {
    ls -la
    cd /
    return 0
}
```

Function with enumerated arguments
```
function foo { cd $1; ls $2; }
```

Order of precedence when there is name collision
```
1. function call
2. built-in command
3. process command
```

Terms used in shell scripting
```
1. brace expansion
2. tilde expansion
3. variable expansion, arithmetic expansion, command substitution
4. filename expansion
```

Shell command inherentance
```
1. ( command-list ) - execute in sub-shell
2. { command-list } - execute in current shell
```
