from os import environ
from unittest import TestCase

environ["TESTING"] = "true"

from app import app
from io import StringIO
import os
import io
from app import TimelinePost


class AppTestCase(TestCase):
    def setUp(self) -> None:
        self.client = app.test_client()

    def test_home(self) -> None:
    	get_response = self.client.get("/")
    	assert get_response.status_code == 200

    	html = get_response.get_data(as_text=True)

    	assert "<p>275 W Lexington Dr3<br>Glendale, California</p>" in html

    def test_menu(self) -> None:
    	get_response = self.client.get("/menu")
    	assert get_response.status_code == 200

    	html = get_response.get_data(as_text=True)

    	assert "<p>275 W Lexington Dr3<br>Glendale, California</p>" in html

    def test_about(self) -> None:
    	get_response = self.client.get("/about")
    	assert get_response.status_code == 200

    	html = get_response.get_data(as_text=True)

    	assert "<p>275 W Lexington Dr3<br>Glendale, California</p>" in html


    def test_products_api(self) -> None: 
    	get_response = self.client.get("/api/products")
    	assert get_response.status_code == 200
    	assert get_response.is_json

    	# testing the response 
    	json = get_response.get_json()
    	assert "coffee" in json
    	assert "matcha" in json
    	assert "tea" in json
    	assert "signature" in json

    	# creating a product 

    	post_response = self.client.post("/api/products", data = {
    		"name": "Green Tea222",
    		 "price": "12.12",
    		 "image": (io.BytesIO(b"abcdef"), 'test.jpg'),
    		 "type": "tea"
    		})

    	assert post_response.status_code == 200
    	json = post_response.get_json()

    	# testing the deleting endpoint 

    	delete_renpose = self.client.delete("/api/products/" + str(json['id']))

    	assert post_response.status_code == 200

    	
    	# deleting using the deletion endpoint 
    def test_incorrect_products_api(self) -> None:
    	# removes key and sends new reponse 
    	def removeVal(key):
    		all_data = {
    		"name": "Green Tea222",
			"price": "12.12",
    		"image": (io.BytesIO(b"abcdef"), 'test.jpg'),
    		 "type": "tea"
    		}
    		all_data.pop(key)
    		post_response = self.client.post("/api/products", data = all_data)    		
    		return post_response
		# helper methods to change values to incorrect ones 
    	def change(key, value):
    		all_data = {
    		"name": "Green Tea222",
			"price": "12.12",
    		"image": (io.BytesIO(b"abcdef"), 'test.jpg'),
    		 "type": "tea"
    		}
    		all_data[key] = value
    		post_response = self.client.post("/api/products", data = all_data)    		
    		return post_response    		



    	# testing the product 
    	# creating a product without a price 
    	post_response = removeVal("price")
    	text = post_response.get_data(as_text=True)
    	assert "Invalid price" in text    	
    	assert post_response.status_code == 400



    	# checking for incorrect input 
    	post_response = change("price", "aa") # non floating number
    	text = post_response.get_data(as_text=True)
    	assert "Invalid Price" in text        	
    	assert post_response.status_code == 400

    	# -1 number 
    	post_response = change("price", "-1")
    	text = post_response.get_data(as_text=True)
    	assert "Invalid Price" in text        	
    	assert post_response.status_code == 400

    	
    	# testing for incorrect name 
    	post_response = removeVal("name")
    	text = post_response.get_data(as_text=True)
    	assert "Invalid name" in text        
    	assert post_response.status_code == 400

    	# testing for incorrect type
    	#missing type 
    	post_response = removeVal("type")
    	assert post_response.status_code == 400

    	# testing for wrong type 
    	post_response = change("type", "hahahah")
    	assert post_response.status_code == 400  
    	text = post_response.get_data(as_text=True)
    	assert "Invalid type" in text



    	# testing for missing image 
    	post_response = removeVal("image") 
    	text = post_response.get_data(as_text=True)
    	assert "Invalid Image" in text
    	assert post_response.status_code == 400 	
    	# TODO: validation to check if it is actually an image 



    def testing_incorrect_deletion_api(self) -> None:

    	delete_renpose = self.client.delete("/api/products/" + str("a"))

    	assert delete_renpose.status_code == 400


