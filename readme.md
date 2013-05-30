Guía de uso de scripts
======================

## Cosas básicas
Este sistema está basado en [Fabric](http://www.fabfile.org), por lo que ejecutar scripts se hace invocando al programa `fab`:
  fab -R lds ejecutar:uname
El comando anterior ejecutará el comando `uname` en los pcs del lds.
Una vez finalizada la ejecución, se entregará un resumen de la ejecución del comando.

### Especificando donde ejecutar el comando
Fabric puede ejecutar comandos en un sólo pc, o en un grupo. Para ejecutar en uno solo, se utiliza la opción `-H`. Se pueden especificar más hosts usando comas:
  fab -H lpa-pc10,lds-pc32 ejecutar:"killall transmission-gtk"

Además, hay roles predefinidos: están en la carpeta scripts/pcs. Éstos son conjuntos de hosts, están definidos: core2, i5, lpa y lds. lpa es core2 + i5 (revisar definición en fabfile.py). Para ejecutar comandos en grupos de pc, se utiliza la opción `-R`, también se pueden especificar más grupos usando comas:
  fab -R lpa,lds ejecutar:"killall google-chrome"

## Comandos programados
### Enviar comandos a pc
  fab -R lds ejecutar:"comando -argumento"
### Enviar archivo a pcs
  fab -R lds enviar:"/path/en/apu","/path/en/pcs"
### Reiniciar pcs
  fab -R lds reiniciar