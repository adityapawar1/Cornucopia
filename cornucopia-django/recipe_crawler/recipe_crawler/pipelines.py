# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
from recipes.models import Recipe, Ingredient

class RecipeCrawlerPipeline():
    def process_item(self, item, spider):
        ingredient_name = item['ingredient']['name']
        ingredient = Ingredient.objects.filter(name=ingredient_name)[0]
        item['ingredient'] = ingredient
        item.save()
        return item
