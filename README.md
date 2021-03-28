# Nvim DevHerles

![Nvim DevHerles pic](./images/nvim.png)

## Install in one command

The following will install this config if you have an existing config it will move it to `~/.config/nvim.old`

This script only supports Ubuntu

```sh
bash <(curl -s https://raw.githubusercontent.com/DevHerles/nvim/master/utils/install.sh)
```

## Installing Oracle SDK (for coc-xml)

### Downloading SDK binaries

Download SDK binaries in .tar.gz (tarball) by heading over to their [website](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html)

### Installing

Create a directory to install SDK in with:

```sh
sudo mkdir /usr/local/java
```

Move the SDK binaries into the directory:

```sh
sudo mv jdk-8u261-linux-x64.tar.gz /usr/local/java
```

Go into the install directory:

```sh
cd /usr/local/java
```

Unpack the tarball:

```sh
sudo tar -xzfv jdk-8u261-linux-x64.tar.gz
```

### Post-installation steps

To save space, delete the tarball by running:

```sh
sudo rm jdk-8u261-linux-x64.tar.gz
```

Let the system know where SDK is installed:

```sh
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk1.8.0_26/bin/java" 1
```

You must update the previous path in coc-settings.json like:

```sh
// java
"xml.java.home": "/usr/local/java/jdk1.8.0_261",
```

Don't forgot... `:CocRestart`

After that's done, check the installation by running:

```sh
java -version

```

It should output the following:

```bash
java version "1.8.0_261"
Java(TM) SE Runtime Environment (build 1.8.0_261-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.261-b12, mixed mode)
```

# Vim awesome commands

## vi/vim/nvim, how can I write out a number of lines to a new file

```bash
:100,200w filename
Of course 100,200 is the range of lines you want to write.

:'a,'b w filename then hit return.

vim -c "100,200w new_file.txt" -c wq original_file.txt

For example: :+0,+99w filename write the next 100 lines to filename.

:.w >> filename and hitting return.
```

## Jump to particular line number from a shell prompt, enter:

```bash
$ vim +linenumber file.py
$ vim +3 __init__.py
```

## Jump to particular line that contains main() function from a shell prompt, enter:

\$ vim +/searchTermHere file.py

```bash
$ vim +/main initlib.c
### note shell escape done with \ ###
$ vim +/addUser\( initlib.c
$ vim +/addUser\(arg1\) initlib.c
```

## git-diff to ignore ^M

```bash
$ git config --global core.autocrlf true
```

Of course, this is said to convert crlf to lf, while you want to convert cr to lf. I hope this still works …

And then convert your files:

### Remove everything from the index

```bash
$ git rm --cached -r .
```

If you have already added the files to be tracked, you need to remove them from tracking:

```bash
git rm .env --cached
git commit -m "Stopped tracking .env File"
```

### Re-add all the deleted files to the index

### You should get lots of messages like: "warning: CRLF will be replaced by LF in <file>."

```bash
$ git diff --cached --name-only -z | xargs -0 git add
```

### Commit

```bash
$ git commit -m "Fix CRLF"
```
