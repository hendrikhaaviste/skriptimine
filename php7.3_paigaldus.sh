#PHP paigaldusskript
#
#kontrollime pakette
sudo apt update
#kontrollime, kas php7.3 on installitud
#vastuse salvesatme muutuja sisse:
PHP=$(dpkg-query -W -f='${Status}' php7.3 2>/dev/null | grep -c 'ok installed')
#kui PHP muutuja väärtus on 0
if [ $PHP -eq 0 ]; then
	#siis ei ole ok installed leitud
	#ja väljastab teate
	echo "Paigaldame php ja vajalikud lisad"
	sudo apt install php7.3 libapache2-mod-php7.3  php7.3-mysql
	echo "PHP on paigaldatud"
elif [ $PHP -eq 1 ]; then
	#siis kui ok installed on leitud
	#ja teenus juba paigaldatud
	echo "PHP juba paigaldatud"
	#kontrollime olemasolu
	which php
#lõpetame tingimuslause
fi
#skripti lõpp
