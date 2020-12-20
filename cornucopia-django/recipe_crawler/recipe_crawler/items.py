# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy
from scrapy_djangoitem import DjangoItem
from recipes.models import Recipe, Ingredient

class IngredientItem(scrapy.Item):
    # django_model = Ingredient
    name = scrapy.Field()

class RecipeItem(DjangoItem):
    django_model = Recipe
    # title = scrapy.Field()
    # directions = scrapy.Field()
    # link = scrapy.Field()
    # display_url = scrapy.Field()
    # ingredients_all = scrapy.Field()
    # ingredients_used = scrapy.Field()
    # ingredients_needed = scrapy.Field()
    # tags = scrapy.Field()
    
