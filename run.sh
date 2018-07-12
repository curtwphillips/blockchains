#!/usr/local/bin/bash
# requires bash 4+

# script assumes:
# the blocks directory is in your home directory $HOME
# you compiled bitcoind/litecoind in the ~/blocks/<coin>/server directory
# otherwise you will need to update the paths below

# command line arguments:
# the default task with no passed in arguments is to start livenet nodes for btc, bch, and ltc
# specify particular coin servers to start or stop with -btc, -bch, and/or -ltc
# if you want to stop servers instead of starting them use -stop
# if you want to operate on testnet servers instead of livenet use -testnet

# example commands:
# start the livenet btc and bch servers
# ~/blocks/run.sh -btc -bch

# stop all livenet servers
# ~/blocks/run.sh -stop

# stop the testnet btc server
# ~/blocks/run.sh -stop -testnet -btc

while test $# -gt 0
do
  case "$1" in
    -stop) echo STOP=true
      ;;
    -testnet) TESTNET=true
      ;;
    -btc) BTC=true; COINS=("${COINS[@]}" 'btc')
      ;;
    -bch) BCH=true COINS=("${COINS[@]}" 'bch')
      ;;
    -ltc) LTC=true COINS=("${COINS[@]}" 'ltc')
      ;;
    -*) echo "bad option $1"
      exit 1 ;;
    *) echo "bad option $1"
      exit 1 ;;
  esac
  shift
done

declare -A COINSERVERS
COINSERVERS["btc"]='bitcoind'
COINSERVERS["bch"]='bitcoind'
COINSERVERS["ltc"]='litecoind'

# if no coin args operate on all coins
if [ ! "$COINS" ]; then
  COINS=('btc' 'bch' 'ltc')
fi

for COIN in "${COINS[@]}"
do
  if [ "$TESTNET"]; then
    CONF="$HOME/blocks/$COIN/pruned/$COIN.pruned.testnet.conf"
    GREPSTRING="blocks/$COIN/pruned/$COIN.pruned.testnet.conf"
  else
    CONF="$HOME/blocks/$COIN/pruned/$COIN.pruned.conf"
    GREPSTRING="blocks/$COIN/pruned/$COIN.pruned.conf"
  fi
  if [ STOP = true ]; then
    kill -SIGTERM $(ps aux | grep "$GREPSTRING" | grep -v grep | awk '{print $2}')
    echo "stopping $COINSERVERS[$COIN] for $COIN using $GREPSTRING"
  else
    $HOME/blocks/$COIN/server/src/${COINSERVERS[${COIN}]} -daemon -datadir=$HOME/blocks/$COIN/pruned -conf=CONF
    echo "starting ${COINSERVERS[${COIN}]} for $COIN using $HOME/blocks/$COIN/server/src/${COINSERVERS[${COIN}]}"
  fi
done
