#!/bin/bash


#todos:
# 1. Use cached cookie for a while instead of cookie-refresh
# 2. encrypt cookie and credential file
# 3. Extract other information on demand

# first set this credential file as below such that
# $ cat ~/.vianet-credentials
#   #my vianet credentials
#   USERNAME=my_awesome_username
#   PASSWORD=my_awesome_password

CREDENTIAL_FILE="$HOME/.vianet_credentials"
if [ ! -s $CREDENTIAL_FILE ]; then
	echo -n "Your username please [don't be panic, its one time job] : "
	read USERNAME

	echo -n "password too please : "
	read -s PASSWORD
	echo
	echo "#one time asked password generated at `date`" > $CREDENTIAL_FILE
	echo "USERNAME=$USERNAME" >> $CREDENTIAL_FILE
	echo "PASSWORD=$PASSWORD" >> $CREDENTIAL_FILE

	#feedback msg
	echo "Credentials are cached in '$CREDENTIAL_FILE' for future use"
	echo "curl even takes time, :( need optimisation..."

fi

# # loading the creds
source $CREDENTIAL_FILE

# # cookie to bake into
COOKIE_FILENAME=cookies.txt

# # login url for the server
LOGIN_URL='https://customers.vianet.com.np/customerportal/customers/login'

# # पैले भित्र त पसम न; cooking अनि बनाउला नि
curl  -s $LOGIN_URL \
	  --cookie $COOKIE_FILENAME --cookie-jar $COOKIE_FILENAME \
	  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0' \
	  --data "redirect_to=&username=$USERNAME&password=$PASSWORD&btnLogin="
# -H 'Host: customers.vianet.com.np' \
# -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' \
# -H 'Accept-Language: ne,en-US;q=0.7,en;q=0.3' -H 'Accept-Encoding: gzip, deflate' \
# -H 'Referer: https://customers.vianet.com.np/customerportal/customers/login' \
# -H 'Connection: keep-alive' -H 'Content-Type: application/x-www-form-urlencoded'



# # datas are in here :D
DATA_URL='https://customers.vianet.com.np/customerportal/services/internet'

# now get some useful data eating that cookie :D
data_left=$(curl -s $DATA_URL \
				 --cookie $COOKIE_FILENAME  \
				 -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0' \
				   | awk '/ GB \(/ {print }'|sed 's/<[^>]*>//g')

echo
# data_left=${data_left:-'7.28 GB (29.12%) out of 25 GB'}
BGreen='\e[1;31m'
echo -e "My pkg left: $BGreen $data_left"
echo
