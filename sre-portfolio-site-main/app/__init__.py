import os
import json
from flask import Flask, render_template, request,redirect, url_for
from dotenv import load_dotenv


load_dotenv()
app = Flask(__name__)
profile = json.loads(open("app/profile.json", "r").read())

@app.route('/')
def index():
    return render_template('index.html', title="MLH Fellow",profile=profile,  url=os.getenv("URL"))

@app.route('/menu')
def menu():
    username = request.args.get('id')
    print('the id', username)

    return render_template('menu.html', title="menu", profile=profile)

@app.route('/about')
def about():
    return render_template('AboutUs.html', title="about")
