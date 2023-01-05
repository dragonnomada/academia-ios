# Tutorial de Github

## Agregar submódulos

Sirve para conectar un repositorio dentro de otro. Lo que se copiará será un `commit` específico dentro de una carpeta.

> Agregar un submódulo en una carpeta dentro del repositiorio

```bash
cd <repositorio-local>/<path>

git submodule add <url repositorio-remoto> <submodule folder>
```

> Ejemplo para agregar el repositorio remoto [https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados) en el repositorio local [https://github.com/dragonnomada/academia-ios/tree/main/proyectos_equipos_5x](https://github.com/dragonnomada/academia-ios/tree/main/proyectos_equipos_5x)

```bash
git clone https://github.com/dragonnomada/academia-ios

cd academia-ios

cd proyectos_equipos_5x

git submodule add https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados ProyectoNominApp
```

## Actualizar un submódulo remoto en el repositorio local

Cuándo clonamos un submódulo, este ocupa el último commit en aquél entonces y podría quedar desactualizado.

Debemos ir al submódulo local hacer un `pull` para obtener el último `commit` y sincronizar nuestro repositorio local

> Actualizar un submódulo local

```bash
cd <repositorio-local>/<path>/<submodule folder>

# Nos recupera el último commit
git pull

# Volvemos al repositorio local
cd ..

git add .

git commit -m "Submódulo actualizado"

git push origin <branch>
```

> Ejemplo para actualizar el repositorio local [https://github.com/dragonnomada/academia-ios/tree/main/proyectos_equipos_5x](https://github.com/dragonnomada/academia-ios/tree/main/proyectos_equipos_5x) a la última versión del repositorio remoto [https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados](https://github.com/JoelBrayan22/ProyectoAdministracionDeNominasEmpleados)

```bash
# Nos dirigimos a la carpeta del submódulo remoto en local
cd ~/academia-ios/proyectos_equipos_5x/ProyectoNominApp

git pull

# Volvemos a la carpeta del repositorio local
cd ..

git add .

git commit -m "ProyectoNominApp actualizado a su última versión"

git push origin main
```

## Actualizar una rama desde el main

La fusión hacia abajo significa recuperar los cambios más actuales del main hacia nuestra rama, aquí podrían haber problemas de conflictos entre archivos.

Dentro del Github (web) podemos ver en cada rama cuántos `commits` hay desde el main hacia la rama (`behind`) y podemos solicitar un `pull request` para completar un `merge` desde la rama principal (`main`) hacia nuestra rama.

## Actualizar el main desde una rama

La fusión hacia arriba significa publicar los cambios más actuales de nuestra rama hacia el main, aquí podrían haber problemas de conflictos entre archivos.

Dentro del Github (web) podemos ver en cada rama cuántos `commits` hay desde nuestra rama hacia el main (`ahead`) y podemos solicitar un `pull request` para completar un `merge` desde nuestra rama hacia la rama principal (`main`).