from os import environ
from unittest import TestCase

environ["TESTING"] = "true"

from app import app

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

    	post_response = self.client.post("/api/products")



        # assert get_response.status_code == 200
        # assert get_response.is_json

        # assert "coffee" in json
        # assert len(json["timeline_posts"]) == 0

        # post_response = self.client.post("/api/timeline_post", data={
        #     "name":    "########",
        #     "email":   "hi@ex.co",
        #     "content": "########"
        # })

        # assert post_response.status_code == 200

