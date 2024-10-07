from flask import Flask, jsonify
import json
from db_config import create_db_connection
import mysql.connector
from datetime import datetime
from decimal import Decimal


class CustomJSONEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.isoformat()
        elif isinstance(obj, Decimal):
            return float(obj)  
        return super().default(obj)

db = create_db_connection()
cursor = None

if db:
    cursor = db.cursor(dictionary=True)

# Busca peliculas por fecha

def get_movies_data_fecha(date_str):
    if not db or not db.is_connected():
        print("No hay conexion con la base de datos")
        return jsonify({"error": "No se pudo conectar a la BD"}), 500
 
    try:

        print(f"SQL: Buscar por peliculaID = {date_str}")
 
        cursor.callproc('ConsultarPeliculasPorFecha', [date_str,])

        result = None

        for res in cursor.stored_results():
            result = res.fetchall()

        print(f"result: {result}")
 
        if result:
            return json.dumps(result,cls=CustomJSONEncoder)
        else:
            print("No results")
            return jsonify({"error": "No se encontro peliculas"}), 404
 
    except mysql.connector.Error as e:
 
        print(f"Error ejecutando query: {e}")
        return jsonify({"error": str(e)}), 500 


# Busca peliculas por ID

def get_movies_data(peliculaID):
    if not db or not db.is_connected():
        print("No hay conexion con la base de datos")
        return jsonify({"error": "No se pudo conectar a la BD"}), 500
 
    try:
        print(f"SQL: Buscar por peliculaID = {peliculaID}")
 
        cursor.callproc('ConsultarPeliculaPorId', [peliculaID,])

        result = None

        for res in cursor.stored_results():
            result = res.fetchall()

        print(f"result: {result}")
 
        if result:
            return json.dumps(result)
        else:
            print("No results")
            return jsonify({"error": "No se encontro peliculas"}), 404
 
    except mysql.connector.Error as e:
 
        print(f"Error ejecutando query: {e}")
        return jsonify({"error": str(e)}), 500
    
# Funcion para realizar reservas 

def make_reservation_service(idfuncion, cantidad):
    if not db or not db.is_connected():
        print("No hay conexion con la base de datos")
        return jsonify({"error": "No se pudo conectar a la BD"}), 500
 
    try:
        print(f"SQL: Hacer una reserva = {idfuncion}")
 
        cursor.callproc('sp_ReservarFuncion', [idfuncion,cantidad,])

        result = None

        for res in cursor.stored_results():
            result = res.fetchall()

        print(f"result: {result}")
 
        if result:
            return json.dumps(result)
        else:
            print("No results")
            return jsonify({"error": "No se encontro peliculas"}), 404
 
    except mysql.connector.Error as e:
 
        print(f"Error ejecutando query: {e}")
        return jsonify({"error": str(e)}), 500