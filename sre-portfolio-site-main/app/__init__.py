import os
import json
from flask import Flask, render_template, request,redirect, url_for
from dotenv import load_dotenv
from flask import send_from_directory

import datetime
from os import getenv
from dotenv import load_dotenv
# from requests import get
from peewee import *
from flask import Flask, render_template, request
from playhouse.shortcuts import model_to_dict
# from pylast import LastFMNetwork
import os
import uuid



basedir = os.path.abspath(os.path.dirname(__file__))
uploads_path = os.path.join(basedir, 'static/uploads')  # assume you have created a uploads folder
from flask import jsonify


load_dotenv()

app = Flask(__name__)

# if os.getenv("TESTING") == "true":
#     print("Running in test mode.")
#     # mydb = SqliteDatabase("file:memory?mode=memory&cache=shared", uri=True)
# else:
#     print("running in development mode")
mydb = MySQLDatabase(os.getenv("MYSQL_DATABASE"),
    user=os.getenv("MYSQL_USER"),
    password=os.getenv("MYSQL_PASSWORD") ,
    host=os.getenv("MYSQL_HOST"),
    port=3306
)

# TODO: make cleaner
def get_uplaod_file_name(userpic, filename):
    ext = filename.split('.')[-1]

    # TODO: change the name of the file

    newName = str(uuid.uuid4()) + '.' + ext

    print("uid",)
    print('here', u'photos/%s/profileImg//%s' % (str(userpic.user.id),newName))


    if userpic.title == "profile_image":
        return u'photos/%s/profileImg//%s' % (str(userpic.user.id),newName)
    return u'photos/%s/%s' % (str(userpic.user.id),newName)



#
#

class TimelinePost(Model):
    """
    Represents a timeline post
    """

    name = CharField()
    created_at = DateTimeField(default=datetime.datetime.now)
    imageName = CharField()
    price = DecimalField()
    image_url = CharField()
    atype = CharField() # tells if it fits into Signature Drinks, Matcha, Espresso, Loose Leaf Tea

    class Meta:
        """
        Model metadata
        """
        database = mydb

mydb.connect()
mydb.create_tables([TimelinePost])




profile = json.loads(open("app/profile.json", "r").read())
@app.route('/')
def index():
    return render_template('index.html', title="MLH Fellow",profile=profile,  url=os.getenv("URL"))

@app.route('/menu')
def menu():
    username = request.args.get('id')
    print('the id', username)

    return render_template('menu.html', title="menu", profile=profile)




# deleting products 

@app.route('/api/products/<product_id>', methods=["DELETE"])
def delete(product_id):
    product_id = product_id

    cursor = mydb.cursor()
    sql = "Select * from timelinepost where id=" + str(product_id)
    cursor.execute(sql)
    results = cursor.fetchall()

    try: 
        # deletes the image 
        os.remove(os.path.join(uploads_path , results[0][3]))
    except: 
        return {'error': 'file not found'}


    TimelinePost.delete_by_id(product_id)

    return {}



# this will get products 
@app.route("/api/products", methods=["GET"])
def get_products():

    # tea 
    # coffee
    # matcha
    # Signature Drinks
    productsWithCategories = {'tea': [], 'coffee':[],'matcha':[], 'signature': []}
    print(productsWithCategories)

    products = TimelinePost.select().order_by(TimelinePost.created_at.desc())

    for product in products:
        n = {'id': product.id,'name': product.name, 'imageName':product.imageName, 'price':str(round(product.price, 2)), 'image_url': product.image_url}
        productsWithCategories[product.atype].append(n)


    return productsWithCategories





@app.route("/api/products", methods=["POST"])
def add_timeline():
    
    """
    Adds a new post to the timeline.
    """
    name = request.form.get('name', None)
    #price 
    price = request.form.get('price', None)

    #getting the type 
    atype= request.form.get('type', None)

    # TODO
    # check that the type is correct 

    # TODO
    # return error if there is no image 
    # image 
    f = request.files['image']

    ext = f.filename.split('.')[-1]

    newName = str(uuid.uuid4()) + '.' + ext

    if not f:
        return "no image uploaded", 400

    if not name or not len(name):
        return "Invalid name", 400

    if not price: 
        return "Invalid price", 400

    if not atype: 
        return "invalid type"

    f.save(os.path.join(uploads_path , newName))  # save the file into the uploads folder

    url = str(request.base_url)
    new_url = url.replace('api/timeline_post', "static/uploads/" + newName)

    image_url = new_url

    post = TimelinePost.create(name=name, imageName=newName, price=price,image_url=image_url,atype=atype )

    return model_to_dict(post)


# deleting endpoint 



@app.route('/about')
def about():
    return render_template('AboutUs.html', title="about")
