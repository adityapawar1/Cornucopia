import scrapy
from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider
from urllib.parse import urlencode

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

    return query_string

class RecipeSpider(CrawlSpider):
    name = 'ReciperCrawler'
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
                yield scrapy.Request(url=url + urlencode(supercook_query_string), callback=self.supercook, method='POST')

    def supercook(self, response):
        pass

    def get_data(self, response):
        pass
        # with open('dump.html', 'w+') as file:
        #     file.write(response.content)