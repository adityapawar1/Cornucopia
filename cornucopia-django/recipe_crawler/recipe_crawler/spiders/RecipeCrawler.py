import scrapy
from scrapy_splash import SplashRequest
from scrapy.spiders import CrawlSpider
from urllib.parse import urlencode
from recipe_crawler.items import IngredientItem, RecipeItem
from recipes.models import Ingredient
import json

def get_supercook_params(ingredients):
    ingredient_string = ""
    for ingredient in ingredients:
        ingredient_string += ingredient + ','

    ingredient_string = ingredient_string[:-1] # strip extra comma at the end
    query_string = { 
        'needsimage': 1,
        'kitchen':  ingredient_string, # 'tomato,bread,apple'
        'focus': '',
        'kw': '',
        'catname': ',,',
        'exclude': '',
        'start': 0
    }
    # print(query_string)
    return query_string

class RecipeSpider(CrawlSpider):
    name = 'RecipeCrawler'
    start_urls = ['http://https://google.com/']

    def __init__(self, ingredients='', *args, **kwargs):
        super(RecipeSpider, self).__init__(*args, **kwargs)
        self.ingredients = ingredients.split(',')
        self.item = IngredientItem() 
        self.item['name'] = self.ingredients[0]

        ingredient_name = self.ingredients[0]
        ingredient = Ingredient.objects.filter(name=ingredient_name)

        if not ingredient.exists():
            ingredient = Ingredient(name=ingredient_name)
            ingredient.save()

    def start_requests(self):
        urls = [
            'https://www.supercook.com/dyn/results?'
        ]

        for url in urls:
            if 'supercook' in url:
                supercook_query_string = get_supercook_params(self.ingredients)
                # print(urlencode(supercook_query_string))
                yield scrapy.Request(url=url + urlencode(supercook_query_string), callback=self.supercook, method='POST')

    def supercook(self, response):
        jsonresponse = json.loads(response.text)
        recipes = jsonresponse['results']
        self.logger.debug(recipes)

        for recipe in recipes[0:5]:
            all_ingredients = []
            recipe_item = RecipeItem()
            recipe_item['title'] = recipe['title']
            recipe_item['ingredient'] = self.item
            recipe_item['directions'] = ""
            recipe_item['link'] = recipe['hash']
            
            recipe_item['used'] = []
            for i in recipe['uses'].split(', '):
                all_ingredients.append(i)
                ingredient = IngredientItem()
                ingredient['name'] = i
                recipe_item['used'].append(ingredient)

            try:
                recipe_item['needed'] = recipe['needs']
            except KeyError:
                recipe_item['needed'] = []

            all_ingredients += recipe_item['needed']
            recipe_item['ing_all'] = all_ingredients

            try:
                recipe_item['tags'] = list(filter(lambda tag: 'low' in tag.lower() or 'free' in tag.lower() or 'vegan' in tag.lower(), recipe['tags']))
            except KeyError:
                recipe_item['tags'] = []

            # request = SplashRequest(url=recipe['hash'], callback=self.get_recipe_data, args={'wait': 3}) # 

            # request.meta['recipe_item'] = recipe_item
            yield recipe_item

    def get_recipe_data(self, response):
        recipe_item = response.meta['recipe_item']
        yield recipe_item
