Título del Proyecto: ApiCine

Descripción: Esta api se encarga de gestionar funciones, películas, reservas y más.

Instalación: Primero se debe instalar flask y mysql connector a traves de pip. Una vez instalados, se debe

correr el archivo sql de nombre "Cine" en un gesto de base de datos. Este archivo contiene el script que arma 

nuestra base de datos. Una vez hecho esto, se debe correr el archivo sql "StoredProcedure" el cual contiene 

el script que generara nuestra los stored procedure para nuestra base de datos. Si se desean insertar datos

a la base de datos esto se hace corriendo el archivo "insertDatos" el cual contiene un script para insertar

datos genericos a la base de datos. Con esto ya tendriamos nuestra base de datos lista. Nuestra API consta

de 3 archivos siendo "app.py" el que debe correrse, "db_config.py" donde el usuario debe prporcionar las credenciales

donde hostee su base de datos y "services.py" donde estan las funciones que contienen los cursores con las sentencias SQL

Uso:  Una vez que el archivo "app.py" este corriendo copiamos el endpoint y lo pegamos en nuestro navegador

de preferencia para luego poder realizar cualquiera de las 3 consultas programadas en la API 

Autor: Huespe Federico

Contacto: federicohue@hotmail.com

Tecnologías utilizadas: Python, MySQL, flask