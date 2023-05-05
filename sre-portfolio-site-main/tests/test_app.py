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


