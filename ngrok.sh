#!/bin/sh
# https://ngrok.com/download
printf "\n \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;96m Creando tunel Ngrok para localhost:80  \e[0m\n"
service apache2 start
sleep 2
ngrok http 80
# ngrok http 80 > /dev/null 2>&1 &
sleep 7
printf "\n \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;96m La URL generada para acceso remoto desde internet es: \e[0m\n"
curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io"
printf "\n \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;96m Las IP del servicio ngrok con las que establece el tunel son: \e[0m\n"
ss |grep https
printf "\n \e[1;31m[\e[0m\e[1;37m~\e[0m\e[1;31m]\e[0m\e[1;96m Tunel creado ...\e[0m\n"
