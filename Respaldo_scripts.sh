if ! [ -d ~/Respaldo_scripts  ]; then
	mkdir ~/Respaldo_scripts
	echo "Creando carpeta ~/Respaldo_scripts"
fi
cp -r ~/scripts/* ~/Respaldo_scripts/
