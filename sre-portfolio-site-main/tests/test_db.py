# test_py
from unittest import TestCase
from peewee import SqliteDatabase
from app import TimelinePost

MODELS = [TimelinePost]

db = SqliteDatabase(":memory:")


class TestProducts(TestCase):

    def setUp(self) -> None:
        db.bind(MODELS, bind_refs=False, bind_backrefs=False)

        db.connect()
        db.create_tables(MODELS)

    def tearDown(self) -> None:
        db.drop_tables(MODELS)
        db.close()

    def test_product(self) -> None:

    	saved_product_1 = TimelinePost.create(name="mocha", imageName="image_1", price=22.12,image_url="url",atype="type")

    	assert saved_product_1.id == 1


    	product_count: int = TimelinePost.select().count()

    	assert product_count == 1


    	fetched_product_1: TimelinePost = TimelinePost.get_by_id(saved_product_1.id)

    	assert fetched_product_1.name == saved_product_1.name and fetched_product_1.id == saved_product_1.id


    	TimelinePost.delete_by_id(fetched_product_1.id)


    	post_count: int = TimelinePost.select().count()

    	assert post_count == 0




