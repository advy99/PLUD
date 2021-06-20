# Lose To Win

Lose To Win: Proyecto para la asignatura de Programación Lúdica.

# Como ejecutar el proyecto

En la sección de lanzamientos podremos encontrar la última versión disponible del código, así como su versión ejecutable. Lua, al ser un lenguaje interpretado, nos permitirá ejecutar Lose To Win directamente desde el código, aunque debido a la necesidad de tener instalado Love2D para esta opción hemos añadido un fichero zip con los recursos necesario y una versión portable de Love2D para que lanzar Lose To Win sea tan sencillo como ejecutar un fichero, sin necesidad de descargas adicionales.


## Ejecutando el código fuente manualmente con Love2D}

Si optamos por descargar el código del proyecto, será necesario instalar Love2D en nuestro sistema. Esto se puede hacer utilizando los instaladores de la página principal de Love2D (https://love2d.org). Será necesario instalar, como mínimo, la versión 11.3 de Love2D.

Tras instalar Love2D, simplemente nos movemos a la ruta del proyecto, en la que se encuetra el fichero main.lua y lanzamos Love2D en la carpeta actual:

```
cd <ruta_descarga>/proyecto
love .
```

## Utilizando la versión de lanzamiento (recomendado)

Si optamos descargar la versión disponible en la herramienta de lanzamiento de GitHub, donde podemos encontrar el fichero LoseToWin.zip, es tan simple como extraer dicho fichero comprimido donde encontraremos una carpeta y dos ficheros:

- LoseToWin: Carpeta con los recursos y código de LoseToWin, así como una versión portable de Love2D tanto de Windows como de Linux, ambos de 64 bits.
- LoseToWinLinux.sh: Fichero para ejecutar Lose To Win en Linux.
- LoseToWinWindows.bat: Fichero para ejecutar Lose To Win en Windows.

Lanzar Lose To Win es tan simple como ejecutar el fichero de tu sistema operativo.

En cualquier caso, siempre es posible abrir un error en GitHub si se encuentra algún fallo tanto en la versión de lanzamiento, ejecución, etc.


# Bibliotecas externas y recursos utilizados

## Bibliotecas

- LIP: https://github.com/Dynodzzo/Lua_INI_Parser/ (licencia MIT)
- middleclass: Biblioteca para usar clases en Lua: https://github.com/kikito/middleclass (licencia MIT)
- SUIT: Biblioteca para gestionar menus con sliders, checkbox, etc: https://github.com/vrld/suit
- STI: Biblioteca para cargar mapas de Tiled en Love2D: https://github.com/karai17/Simple-Tiled-Implementation

## Assets

- Arte de los personajes por Calciumtrice, https://opengameart.org/users/calciumtrice (licencia CC-BY 3.0)

- Arte del fondo: https://www.deviantart.com/khrinx/art/Seamless-hd-landscape-641301814

- Arte de plataformas: https://pixelfrog-assets.itch.io/ (licencia CC-0)

- Arte de la bola de energía: https://www.deviantart.com/dbaf23

- Music by Monplaisir, https://freemusicarchive.org/music/Monplaisir (licencia CC-0)

- Flags: https://www.flaticon.com/packs/international-flags-6?word=flags by https://www.freepik.com/

- Sound Effects by:
	- Slime sounds:
		- Jump: https://freesound.org/people/Zuzek06/ (licencia CC-0)
		- Fall: https://freesound.org/people/Lukeo135/ (licencia CC-0)
		- Death: https://opengameart.org/content/8-wet-squish-slurp-impacts by Independent.nu (licencia CC-0)
	- Energy Ball: https://freesound.org/people/SomeSine/ (licencia CC-0)

- Icons:
	- Botón PLAY: https://www.flaticon.com/authors/those-icons
	- Botón opciones: https://www.freepik.com/
	- Botón EXIT: https://www.freepik.com/
	- Botón créditos: https://www.freepik.com/
	- Botón práctica: https://www.freepik.com/
	- Botón check: https://www.freepik.com/
	- Botón bomba: https://www.freepik.com/
	- Botón death_ball: https://www.flaticon.com/authors/dinosoftlabs
	- Botón trofeo: https://www.freepik.com/
- Font by Brian Kent (ÆNIGMA GAMES & FONTS): https://www.dafont.com/kirby-no-kira-kizzu.font

## Herramientas

- Font Forge: https://fontforge.org/en-US/
- Tiled: https://www.mapeditor.org/
