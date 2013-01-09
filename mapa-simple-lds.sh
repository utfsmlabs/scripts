#!/bin/bash


punto=""
for pc in $(cat pcs-lds | grep -v "^#")
do
        compu=$(ping -o -t 1 $pc | grep "bytes from")
        clear
        echo "waitea$punto"
        if [ "x${compu}" != 'x' ]; then
            ### echo -e "\e[0;32m$pc PRENDIDO\e[0m"
            ssh root@$pc "exit" 2> error_temp
            if [ "x$(cat error_temp)" = 'x' ]; then
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

echo "            Mapa del LDS"
echo ""
echo ""
echo -e "     0 1    2 3    4 5    6 7    8 9"
echo ""
echo -e "  4  ${var[40]}|${var[41]}    ${var[42]}|${var[43]}    ${var[44]}|${var[45]}    ${var[46]}|${var[47]}     |"
echo -e "    --+--  --+--  --+--  --+--  --+--"  
echo -e "  3  ${var[30]}|${var[31]}    ${var[32]}|${var[33]}    ${var[34]}|${var[35]}    ${var[36]}|${var[37]}     |"
echo ""
echo ""
echo -e "  2  ${var[20]}|${var[21]}    ${var[22]}|${var[23]}    ${var[24]}|${var[25]}    ${var[26]}|${var[27]}    ${var[28]}|${var[29]}"
echo -e "    --+--  --+--  --+--  --+--  --+--"  
echo -e "  1  ${var[10]}|${var[11]}    ${var[12]}|${var[13]}    ${var[14]}|${var[15]}    ${var[16]}|${var[17]}    ${var[18]}|${var[19]}"

echo ""
echo ""
echo -e "\e[1;31mX\e[0m APAGADO    \e[0;32mO\e[0m PRENDIDO    \e[43;1;30mO\e[0m PRENDIDO pero con problemas de SSH"
echo ""
echo ""



