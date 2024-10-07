from flask import Flask, request, jsonify
from services import get_movies_data, make_reservation_service, get_movies_data_fecha

app = Flask(__name__)

# Funcion para realizar reservas

@app.route("/get_movies_by_date/<string:date_str>", methods=['GET'])
def get_movies_by_date(date_str):
    return get_movies_data_fecha(date_str)

# Busca peliculas por ID

@app.route("/get_movies/<int:peliculaID>", methods=['GET'])
def get_movie(peliculaID):
    return get_movies_data(peliculaID)

# Funcion para realizar reservas

@app.route("/make_reservation", methods=['POST'])
def make_reservation():
    data = request.get_json()
    funcionid = data.get("idfuncion")
    cantidad = data.get("cantidad")
    print(funcionid)
    print(cantidad)
    return make_reservation_service(funcionid, cantidad)
 
if __name__ == "__main__":
    
    app.run(debug=True, port=11)