# Proyecto Individual 1 - ReclutApp

Por [Alan Badillo Salas](https://www.nomadacode.com)

## Introuducción

`ReclutApp` es una aplicación para *IOS* diseñada con *Swift* y *UIKit* que ayuda a los miembros de recursos humanos en el proceso de reclutamiento de perfiles hasta contratarlos como empleados formales.

La aplicación consta de las siguientes pantallas:

* **Pantalla Principal** - Muestra una lista con el resumen de los perfiles reclutados y su estado de reclutamiento. También cuenta con un botón para ir a la pantalla de agregar un nuevo perfil de reclutamiento y al pulsar sobre cada perfil se accede a la pantalla de detalles del perfil, dónde se puede actualizar el estado de reclutamiento de cada perfil.
* **Pantalla Reclutar** - Muestra un formulario con los datos del perfil a reclutar, como la foto, el nombre, su dirección y el número económico del empleado referido (opcional).
* **Pantalla Detalles** - Muestra los detalles del perfil reclutado y su estado de reclutamiento. También una lista del proceso de reclutamiento: *Reclutar* (marcada por defecto), *Entrevistar*, *Validar* y *Contratar*. La lista muestra un ícono de éxito, actual y en espera, según si ese proceso se está realizando. Al pulsar sobre el proceso se abrirá la venta correspondiente para completar el proceso.
* **Pantalla Entrevistar** - Muestra las casillas necesarias para marcar los requisitos cumplidos de la entrevista, si se seleccionan todos el usuario podrá completar la entrevista y marcar el siguiente proceso.
* **Pantalla Detalles** - Muesta los detalles del perfil y su estado de reclutamiento. Se muestran los detalles del perfil y su estado de reclutamiento, así cómo el tiempo de retraso estimado para completar el proceso actual y la lista de procesos: *Reclutar* (marcada por defecto), *Entrevistar*, *Validar* y *Contratar*. En cada proceso se muestra el ícono de éxito si ya cumpletó el proceso, el ícono de actual si el proceso es el actual y el ícono de espera si aún no completa el proceso. En el proceso actual se muestra habilita un botón para navegar a la pantalla de proceso.
* **Pantalla Proceso Entrevistar** - Se muestra una lista de casillas marcables para indicar si las partes del proceso ya fueron completadas, el botón para actualizar y el botón de completar el proceso (habilitado sólo si cumple todas las casillas).
* **Pantalla Proceso Validar** - Se muestra una lista de casillas marcables para indicar si las partes del proceso ya fueron completadas, el botón para actualizar y el botón de completar el proceso (habilitado sólo si cumple todas las casillas).
* **Pantalla Proceso Completar** - Se muestra una lista de casillas marcables para indicar si las partes del proceso ya fueron completadas, el botón para actualizar y el botón de completar el proceso (habilitado sólo si cumple todas las casillas).

## Rúbricas

* `[REQUERIDO]` Diseñó la **Pantalla Principal**
* `[REQUERIDO]` Diseñó la **Pantalla Reclutar**
* `[REQUERIDO]` Diseñó la **Pantalla Detalles**
* `[REQUERIDO]` Diseñó la **Pantalla Proceso Entrevistar**
* `[REQUERIDO]` Diseñó la **Pantalla Proceso Validar**
* `[REQUERIDO]` Diseñó la **Pantalla Proceso Completar**
* `[REQUERIDO]` Creó la navegación entre pantallas usando *segues*
* `[REQUERIDO]` Agregó la funcionalidad de la **Pantalla Principal**
* `[REQUERIDO]` Agregó la funcionalidad de la **Pantalla Reclutar**
* `[REQUERIDO]` Agregó la funcionalidad de la **Pantalla Detalles**
* `[REQUERIDO]` Agregó la funcionalidad de la **Pantalla Proceso Entrevistar**
* `[REQUERIDO]` Agregó la funcionalidad de la **Pantalla Proceso Validar**
* `[REQUERIDO]` Agregó la funcionalidad de la **Pantalla Reclutar**
* `[REQUERIDO]` Agregó la funcionalidad de la **Pantalla Proceso Completar**
* Agregó la funcionalidad para la carga de la imagen del perfil
* Mostró la imagen del perfil en las diferentes pantallas
* Utilizó *CoreData* para la persistencia de datos
* El alumno documentó las cabeceras de sus códigos
* El alumno documentó cada pieza importante de código
* El alumno documentó los algoritmos utilizados para implementar los métodos
* El alumno documentó las pruebas unitarias
* El alumno espació correctamente el código para aumentar la legibilidad
* El alumno usó nombres nemónicos en sus variables y métodos
* El alumno completó el proyecto o práctica