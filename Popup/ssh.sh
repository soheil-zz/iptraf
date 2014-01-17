#!/bin/sh

#  ssh.sh
#  Popup
#
#  Created by Soheil Yasrebi on 1/17/14.
#
ssh root@pubbay.com "uptime|cut -d' ' -f14|sed 's/,//'"