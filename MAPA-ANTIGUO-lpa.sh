#!/bin/bash
punto=""

error_temp="tmp/error_mapa-lpa"

for pc in $(cat pcs/lpa)
do
        pc=$(echo "$pc" | sed 's/^#//')
        clear
        echo "waitea$punto[$pc]"
        compu=$(ping -o -t 1 $pc | grep "bytes from")
        #clear
        if [ "x${compu}" != 'x' ]; then
            ### echo -e "\e[0;32m$pc PRENDIDO\e[0m"
            ssh root@$pc "exit" 2> $error_temp
            if [ "x$(cat $error_temp)" = 'x' ]; then
                var[$(echo $pc | sed "s/^[-pcslpad]*//")]="\e[0;32mO\e[0m" 
            else
                var[$(echo $pc | sed "s/^[-pcslpad]*//")]="\e[43m\e[1;30mO\e[0m" 
            fi
        else
            ### echo -e "\e[1;31m$pc APAGADOH\e[0m"
            var[$(echo $pc | sed "s/^[-pcslpad]*//")]="\e[1;31mX\e[0m"
        fi
        punto="$punto."
done

clear

echo "            Mapa del LPA"
echo ""
echo ""
echo -e "    |         ${var[27]}  |  ${var[37]}      ${var[47]}  |  ${var[57]}         |"
echo -e "    +---      ---+---      ---+---      ---+"  
echo -e "    |${var[16]}          ${var[26]}|${var[36]}          ${var[46]}|${var[55]}          ${var[66]}|"
echo ""
echo ""
echo -e "    |  ${var[15]}      ${var[25]}  |  ${var[35]}      ${var[45]}  |  ${var[55]}      ${var[65]}  |"
echo -e "    +---      ---+---      ---+---      ---+"  
echo -e "    |${var[14]}          ${var[24]}|${var[34]}          ${var[44]}|${var[54]}          ${var[64]}|"
echo ""
echo ""
echo -e "    |  ${var[13]}      ${var[23]}  |  ${var[33]}      ${var[43]}  |  ${var[53]}      ${var[63]}  |"
echo -e "    +---      ---+---      ---+---      ---+"  
echo -e "    |${var[12]}          ${var[22]}|${var[32]}          ${var[42]}|${var[52]}          ${var[62]}|"
echo ""
echo ""
echo -e "    |  ${var[11]}      ${var[21]}  |  ${var[31]}      ${var[41]}  |  ${var[51]}      ${var[61]}  |"
echo -e "    +---      ---+---      ---+---      ---+"  
echo -e "    |${var[10]}          ${var[20]}|${var[30]}          ${var[40]}|${var[50]}          ${var[60]}|"
echo ""


echo ""
echo -e "\e[1;31mX\e[0m APAGADO    \e[0;32mO\e[0m PRENDIDO    \e[43;1;30mO\e[0m PRENDIDO pero con algun tipo de problema xD"
echo ""
echo ""
