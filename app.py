from flask import Flask

app = Flask(__name__)


@app.route("/api")
def hello():
    return "Hello World!"


@app.route("/api/ping")
def ping():
    return "pong!"


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
