# Nvim DevHerles

![Nvim DevHerles pic](./images/nvim.png)

## Install in one command

The following will install this config if you have an existing config it will move it to `~/.config/nvim.old`

This script only supports Ubuntu
```
bash <(curl -s https://raw.githubusercontent.com/DevHerles/nvim/master/utils/install.sh)
```
## Installing Oracle SDK (for coc-xml)
### Downloading SDK binaries

Download SDK binaries in .tar.gz (tarball) by heading over to their website

### Installing

Create a directory to install SDK in with:
```
sudo mkdir /usr/local/java
```
Move the SDK binaries into the directory:
```
sudo mv sdk-8u151-linux-x64.tar.gz /usr/local/java
```
Go into the install directory:
```
cd /usr/local/java
```
Unpack the tarball:
```
sudo tar zxvf sdk-8u151-linux-x64.tar.gz
```
### Post-installation steps

To save space, delete the tarball by running:
```
sudo rm sdk-8u151-linux-x64.tar.gz
```
Let the system know where SDK is installed:
```
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jre1.8.0_151/bin/java" 1
```
After that's done, check the installation by running:
```
java -version
```
It should output the following:

```bash
java version "1.8.0_151"
Java(TM) SE Runtime Environment (build 1.8.0_151-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.151-b12, mixed mode)
```
