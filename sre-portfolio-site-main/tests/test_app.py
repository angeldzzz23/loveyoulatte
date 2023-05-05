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
    		"name": "Green Tea",
    		 "price": "12.12",
    		 "image": (io.BytesIO(b"abcdef"), 'test.jpg'),
    		 "type": "tea"
    		})

    	assert post_response.status_code == 200
    	json = post_response.get_json()
    	TimelinePost.delete_by_id(json['id'])

    	# testing deleting a product 

    	

    	# deleting using the deletion endpoint 


