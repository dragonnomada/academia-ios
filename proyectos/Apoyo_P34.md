# Apoyo Práctica 34

Por [Alan Badillo Salas](https://www.nomadacode.com)

1. En la *Pantalla 1* se muestra un `UITableView` con una lista de empleados
2. En la *Pantalla 1* al pulsar un registro de la tabla se recupera el empleado y se realiza un `performSegue` con el empleado seleccionado como `sender`
3. En la *Pantalla 1* se prepara el `segue` para configurar `empleadoSubject` y `empleado` en la *Pantalla 2*
4. En la *Pantalla 2* se tiene el `empleadoSubject` opcional y el `empleado` opcional configurados por el `segue`
5. En la *Pantalla 2* se muestran campos de edición con los valores traídos desde el `empleado` opcional
6. En la *Pantalla 2* se muestra un botón para guardar los datos del empleado, al pulsarlo se manda un empleado con mismo `id` pero datos modificados mediante el `empleadoSubject`
7. En la *Pantalla 1* se suscribe al `empleadoSubject` mediante `.sink` para recibir el empleado modificado
8. En la *Pantalla 1* se actualiza el empleado modificado en la tabla