# Mop

## Prerequisite
* Ubuntu 20.04
* Golang 13.8 linux/amd64

Install Golang
```
$ sudo apt install golang
```

Confirm version
```
$ go version
```

Download Golang hello world example
```
$ go get github.com/golang/example/hello
```

After execution of the above command a new directory named go will be created in your user home directory,
containing a source code and executable binary of the Hello World Golang program.
Given that the new go directory is located within you user home directory, to execute the hello program run:
```
$ ~/go/bin/hello
Hello, Go example!
```

## Installation
Mop is implemented in Go and compiles down to a single executable file.
Make sure your $GOPATH is set.
```
$ go get github.com/mop-tracker/mop/cmd/mop
$ cd $GOPATH/src/github.com/mop-tracker/mop
$ make            # <-- Compile and run mop.
$ make build      # <-- Build mop in current directory.
$ make install    # <-- Build mop and install it in $GOPATH/bin.
```

Run the compiled binary
```
$ $GOPATH/bin/mop
```

## Using Mop
For demonstration purposes Mop comes preconfigured with a number of stock tickers.
You can easily change the default list by using the following keyboard commands:
```
+       Add stocks to the list.
-       Remove stocks from the list.
o       Change column sort order.
g       Group stocks by advancing/declining issues.
f       Set a filtering expression.
F       Unset a filtering expression.
?       Display help screen.
esc     Quit mop.
```

When prompted please enter comma-delimited list of stock tickers.
The list and other settings are stored in the profile file (default: .moprc in your $HOME directory)
```
$ ln -s ~/dotfiles/mop/moprc ~/.moprc
```

# Reference
* [How-to-install-go-on-ubuntu-20-04-focal-fossa-linux](https://linuxconfig.org/how-to-install-go-on-ubuntu-20-04-focal-fossa-linux)
* [GitHub - mop-tracker/mop](https://github.com/mop-tracker/mop)
