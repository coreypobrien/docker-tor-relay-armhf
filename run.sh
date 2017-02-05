#!/bin/bash

# Generate a .torrc
cat > .torrc << EOF
DataDirectory /var/tor
DirPortFrontPage @CONFDIR@/tor-exit-notice.html
BridgeRelay ${BridgeRelay:-0}
PublishServerDescriptor ${PublishServerDescriptor:-0}
ExitPolicy ${ExitPolicy:-reject *:*}
ORPort ${ORPort:-9001}
Nickname ${Nickname:-ididntedittheconfig}
EOF

if [ ! -z "$SOCKSPolicies" ]; then
     echo "$SOCKSPolicies" | tr , '\n' | sed 's/^/SOCKSPolicy /' >> .torrc
fi

if [ ! -z "$Address" ]; then
     echo "Address $Address" >> .torrc
fi

if [ ! -z "$RelayBandwithRate" ]; then
     echo "RelayBandwithRate $RelayBandwithRate" >> .torrc
fi
if [ ! -z "$RelayBandwithBurst" ]; then
     echo "RelayBandwithBurst $RelayBandwithBurst" >> .torrc
fi

if [ ! -z "$AccountingMax" ]; then
     echo "AccountingMax $AccountingMax" >> .torrc
fi
if [ ! -z "$AccountingStart" ]; then
     echo "AccountingStart $AccountingStart" >> .torrc
fi

if [ ! -z "$ContactInfo" ]; then
     echo "ContactInfo $ContactInfo" >> .torrc
fi

if [ ! -z "$DirPort" ]; then
     echo "DirPort $DirPort" >> .torrc
fi

# Run tor
/usr/bin/tor -f .torrc

