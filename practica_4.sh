#!/bin/bash
#818058, Arcega, Hector, T, 3, A
#821038, Alonso, Simon, T, 3, A

oldIFS=$IFS
IFS=','


if [ $# -q 3 ]
then
	if [ $1 == "-a" -o $1 == "-s" ]
	then
		cat "$3" | tr -d '\r' | while read IP
		do
			#Ejecutamos un comando cualquiera para comprobar que es accesible la maquina?????
			ssh -n as@${IP} "exit" > /dev/null 2>&1
			#This means that the command before is successful
			if [ $? -eq 0 ]
			then
				scp practica_3.sh ./$2 as@${IP}:~/ > /dev/null 2>&1
				ssh -n as@{$IP} "sudo ./practica_3.sh $1 ./$2 && rm practica_3.sh ./$2 && exit"
			else
				echo "${IP} no es accesible"
			fi
		done
	else
		echo "Opcion invalida" 1>&2
	fi			
else
	echo "Numero incorrecto de parametros"
fi
IFS=$oldIFS
