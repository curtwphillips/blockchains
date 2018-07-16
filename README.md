# blocks
A directory structure with configurations and scripts for syncing bitcoin, bitcoin cash, and litecoin nodes on the same system

### Set up bitcoin cash 
```
cd ~/blocks/bch
git clone https://github.com/bitcoin/bitcoin
mv -v bitcoin/* server/
cd server
git checkout <latest stable version>
```
Follow the instructions in the doc/build-osx.md file for compiling bitcoin.
View the instructions on [the server github](https://github.com/server/server/blob/master/doc/build-osx.md).

### Set up bitcoin
```
cd ~/blocks/btc
git clone https://github.com/bitcoin/bitcoin
mv -v bitcoin/* server/
cd server
git checkout <latest stable version>
```
Follow the instructions in the doc/build-osx.md file for compiling bitcoin.
View the instructions on [the server github](https://github.com/bitcoin/bitcoin/blob/master/doc/build-osx.md).

### Set up litecoin
```
cd ~/blocks/ltc
git clone https://github.com/litecoin-project/litecoin
mv -v litecoin/* server/
cd server
git checkout <latest stable version>
```
Follow the instructions in the doc/build-osx.md file for compiling litecoin.
View the instructions on [the litecoin github](https://github.com/litecoin-project/litecoin/blob/master/doc/build-osx.md).

## Run the nodes
```
$HOME/blocks/run.sh
```