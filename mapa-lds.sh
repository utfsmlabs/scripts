#!/bin/bash

error_temp="tmp/error_mapa-lds"

load(){
    punto=""
    for pc in $(cat pcs/lds | grep -v "^#")
    do
     #   compu=$(ping -o -t 1 $pc | grep "bytes from")
        pc=$(echo "$pc" | sed 's/^#//')
        clear
        echo "waitea$punto[$pc]"
        id=$(echo $pc | sed "s/^[-pcslpad]*//")
     #   var[$id]="\e[0;1;31mX\e[0m"
     #   if [ "x${compu}" != 'x' ]; then
     #       ### echo -e "\e[0;32m$pc PRENDIDO\e[0m"
     #       ssh root@$pc "exit" 2> error_temp
     #       if [ "x$(cat error_temp)" = 'x' ]; then
     #           var[$id]="\e[0;0;32mO\e[0m"
     #           usua[$id]=$(ssh root@$pc "users")
     #       else
     #           var[$id]="\e[43;1;30mO\e[0m" 
     #       fi
     #   else
     #       ### echo -e "\e[1;31m$pc APAGADOH\e[0m"
     #       var[$id]="\e[0;1;31mX\e[0m"
     #   fi
        info
        punto="$punto."
    done
}

info(){
    compu=$(ping -o -t 1 $pc | grep "bytes from")
    var[$id]="\e[0;1;31mX\e[0m" #X roja (DEFAULT)
    if [ "x${compu}" != 'x' ]; then
        ### echo -e "\e[0;32m$pc PRENDIDO\e[0m"
        ssh root@$pc "exit" 2> $error_temp
        if [ "x$(cat $error_temp)" = 'x' ]; then
            var[$id]="\e[0;0;32mO\e[0m" #O verde
            usua[$id]=$(ssh root@$pc "users")
        else
            var[$id]="\e[43;1;30mO\e[0m" #O amarilla
        fi
    else
        ### echo -e "\e[1;31m$pc APAGADOH\e[0m"
        var[$id]="\e[0;1;31mX\e[0m" #X roja
    fi
}

load
stty_state=`stty -g`
##stty raw; stty -echo


copiar_estados(){
    var[38]="\e[45;1;35m \e[0m"
    var[39]="\e[45;1;35m \e[0m"
    var[48]="\e[45;1;35m \e[0m"
    var[49]="\e[45;1;35m \e[0m"
    for indice in $(jot 49)
    do
        echo $indice
        ori[$indice]=${var[$indice]}
    done
   }

reset_pos(){
    i=4
    j=0
    let pos=$i*10+$j
    var[40]=$(echo ${var[40]} | sed "s/e.[0-9]*[;][0-9]*[;]/e[7;1;/")

}

copiar_estados
reset_pos

while [ true ]
do

let pos=$i*10+$j
for indice in $(jot 5)
do
    mostrar_usua[$indice]=""
done
indice=1
for pj in $(echo ${usua[$pos]})
do
    mostrar_usua[$indice]=$pj
    let indice=$indice+1
done

clear

echo "            Mapa del LDS"
echo ""
echo ""
echo -e "     0 1    2 3    4 5    6 7    8 9"
echo -e "                                          \e[0;0;1mlds-pc$pos\e[0m"
echo -e "  4  ${var[40]}|${var[41]}    ${var[42]}|${var[43]}    ${var[44]}|${var[45]}    ${var[46]}|${var[47]}    ${var[48]}|${var[49]}      ${mostrar_usua[1]}"
echo -e "    --+--  --+--  --+--  --+--  --+--     ${mostrar_usua[2]}"  
echo -e "  3  ${var[30]}|${var[31]}    ${var[32]}|${var[33]}    ${var[34]}|${var[35]}    ${var[36]}|${var[37]}    ${var[38]}|${var[39]}      ${mostrar_usua[3]}"
echo -e "                                          ${mostrar_usua[4]}"
echo -e "                                          ${mostrar_usua[5]}"
echo -e "  2  ${var[20]}|${var[21]}    ${var[22]}|${var[23]}    ${var[24]}|${var[25]}    ${var[26]}|${var[27]}    ${var[28]}|${var[29]}"
echo -e "    --+--  --+--  --+--  --+--  --+--"  
echo -e "  1  ${var[10]}|${var[11]}    ${var[12]}|${var[13]}    ${var[14]}|${var[15]}    ${var[16]}|${var[17]}    ${var[18]}|${var[19]}"

echo ""
echo ""
echo -e "\e[0;1;31mX\e[0m APAGADO    \e[0;0;32mO\e[0m PRENDIDO    \e[43;1;30mO\e[0m PRENDIDO pero con algun problema xD"
echo -e "q: salir    R: recargar todo    p: recargar info pc"
echo ""

    stty raw; stty -echo
    keycode=`dd bs=1 count=1 2>/dev/null`
    stty "$stty_state"


    case $keycode in
        "A")    #echo "ARRIBA"
                let pos=$i*10+$j
                var[$pos]=${ori[$pos]}
                if [ $i -eq 4 ]; then
                    i=1
                    let pos=$i*10+$j
                    var[$pos]=$(echo ${var[$pos]} | sed "s/e.[0-9]*[;][0-9]*[;]/e[7;1;/")
                else
                    let i=$i+1
                    let pos=$i*10+$j
                    var[$pos]=$(echo ${var[$pos]} | sed "s/e.[0-9]*[;][0-9]*[;]/e[7;1;/")
                fi
                ;;
        "B")    #echo "ABAJO"
                let pos=$i*10+$j
                var[$pos]=${ori[$pos]}
                if [ $i -eq 1 ]; then
                    i=4
                    let pos=$i*10+$j
                    var[$pos]=$(echo ${var[$pos]} | sed "s/e.[0-9]*[;][0-9]*[;]/e[7;1;/")
                else
                    let i=$i-1
                    let pos=$i*10+$j
                    var[$pos]=$(echo ${var[$pos]} | sed "s/e.[0-9]*[;][0-9]*[;]/e[7;1;/")
                fi
                ;;
        "C")    #echo "DERECHA"
                let pos=$i*10+$j
                var[$pos]=${ori[$pos]}
                if [ $j -eq 9 ]; then
                    j=0
                    let pos=$i*10+$j
                    var[$pos]=$(echo ${var[$pos]} | sed "s/e.[0-9]*[;][0-9]*[;]/e[7;1;/")
                else
                    let j=$j+1
                    let pos=$i*10+$j
                    var[$pos]=$(echo ${var[$pos]} | sed "s/e.[0-9]*[;][0-9]*[;]/e[7;1;/")
                fi
                ;;
        "D")    #echo "IZQUIERDA"
                let pos=$i*10+$j
                var[$pos]=${ori[$pos]}
                if [ $j -eq 0 ]; then
                    j=9
                    let pos=$i*10+$j
                    var[$pos]=$(echo ${var[$pos]} | sed "s/e.[0-9]*[;][0-9]*[;]/e[7;1;/")
                else
                    let j=$j-1
                    let pos=$i*10+$j
                    var[$pos]=$(echo ${var[$pos]} | sed "s/e.[0-9]*[;][0-9]*[;]/e[7;1;/")
                fi
                ;;
        "R")    #echo "RELOAD"
                load
                copiar_estados
                reset_pos
                ;;
        "p")    #echo "RELOAD PC"
                let pos=$i*10+$j
                id=$pos
                pc="lds-pc$id"
                info
                copiar_estados
                var[$pos]=$(echo ${var[$pos]} | sed "s/e.[0-9]*[;][0-9]*[;]/e[7;1;/")
                ;;
        "q")    exit;;
    esac
done

