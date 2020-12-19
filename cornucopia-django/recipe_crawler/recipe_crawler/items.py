# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy

class IngredientItem(scrapy.Item):
    name = scrapy.Field()

class RecipeItem(scrapy.Item):
    title = scrapy.Field()
    directions = scrapy.Field()
    link = scrapy.Field()
    ingredients_all = scrapy.Field()
    ingredients_used = scrapy.Field()
    ingredients_needed = scrapy.Field()
    tags = scrapy.Field()
    
