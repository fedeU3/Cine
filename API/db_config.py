import mysql.connector

def create_db_connection():
    try:
        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="1234",
            database="cine"
        )
        if db.is_connected():
            print("Conectado a la base de datos")
        return db
    except mysql.connector.Error as e:
        print(f"No se pudo conectar a la base de datos: {e}")
        return None