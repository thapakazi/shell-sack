#!/bin/bash

## $whoami
#    Milan Thapa
#     milans.thapa78@gmail.com
#
#    ip:
#    usrname:
#
#   personal:
#       t:@milanthapa_
#       g:zerOnepal
#
##

function ip {
	hostname -i
}

function username {
	whoami
}

function personal {
	echo "
    #   personal:
    #       g:zerOnepal
    #       t:@milanthapa_
    #       f:zeronepali
    "
}
echo " `git config user.name`"
echo -e "\t`git config user.email`"

echo -e "\t`username` @ `ip`"
personal
