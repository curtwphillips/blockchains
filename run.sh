#!/bin/bash
# script assumes the blocks directory is in your home directory $HOME

# command line arguments:
# the default task is to start livenet nodes for btc, bch, and ltc
# the coins to start must be specified or they will all start, with -btc, -bch, and/or -ltc
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
        -btc) BTC=true
            ;;
        -bch) BCH=true
            ;;
        -ltc) LTC=true
            ;;
        -*) echo "bad option $1"
            exit 1 ;;
        *) echo "bad option $1"
            exit 1 ;;
    esac
    shift
done

# if no coin args operate on all coins
if [ ! "$BTC" ] && [ ! "$BCH" ] && [ ! "$LTC" ]; then
    BTC=true
    BCH=true
    LTC=true
fi
