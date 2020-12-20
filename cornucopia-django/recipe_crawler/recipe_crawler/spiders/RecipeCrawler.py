import scrapy
# from scrapy_selenium import SeleniumRequest
from scrapy_splash import SplashRequest
from selenium.webdriver.common.keys import Keys
from scrapy.spiders import CrawlSpider
from urllib.parse import urlencode
from recipe_crawler.items import IngredientItem, RecipeItem
import json

def get_supercook_params(indgredients):
    indgredient_string = ""
    for indgredient in indgredients:
        indgredient_string += indgredient + ','

    indgredient_string = indgredient_string[:-1] # strip extra comma at the end
    query_string = { 
        'needsimage': 1,
        'kitchen':  indgredient_string, # 'tomato,bread,apple'
        'focus': '',
        'kw': '',
        'catname': ',,',
        'exclude': '',
        'start': 0
    }
    print(query_string)
    return query_string

class RecipeSpider(CrawlSpider):
    name = 'RecipeCrawler'
    start_urls = ['http://https://google.com/']

    def __init__(self, indgredients='', *args, **kwargs):
        super(RecipeSpider, self).__init__(*args, **kwargs)
        self.indgredients = indgredients.split(',')

    def start_requests(self):
        urls = [
            'https://www.supercook.com/dyn/results?'
        ]


        for url in urls:
            if 'supercook' in url:
                supercook_query_string = get_supercook_params(self.indgredients)
                print(urlencode(supercook_query_string))
                yield scrapy.Request(url=url + urlencode(supercook_query_string), callback=self.supercook, method='POST')

    def supercook(self, response):
        jsonresponse = json.loads(response.text)
        recipes = jsonresponse['results']
        self.logger.debug(recipes)
        urls = []
        for recipe in recipes[0:10]:
            recipe_item = RecipeItem()
            recipe_item['title'] = recipe['title']
            recipe_item['ingredients_used'] = recipe['uses']
            try:
                recipe_item['ingredients_needed'] = recipe['needs']
            except KeyError:
                recipe_item['ingredients_needed'] = []

            try:
                recipe_item['tags'] = filter(lambda tag: 'low' in tag.lower() or 'free' in tag.lower(), recipe_item['tags'])
            except KeyError:
                recipe_item['tags'] = []

            request = SplashRequest(url=recipe['hash'], callback=self.get_recipe_data)

            request.meta['recipe_item'] = recipe_item
            request.meta['display_url'] = recipe['displayurl']
            urls.append(recipe['hash'])
            yield request

    def get_recipe_data(self, response):
        recipe_item = response.meta['recipe_item']
        with open('dump.html', 'w+') as file:
            file.write(response.text)
