from django.shortcuts import render
from django.views import View
from django.http import HttpResponse, JsonResponse, HttpResponseBadRequest
from .models import Ingredient, Recipe
import os.path
import json

from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings
from recipe_crawler.spider import MySpider


# Create your views here.
class RecipeFinder(View):
    def get(self, request):
        if len(request.body) <= 0:
            return JsonResponse({'yo': 'no json sent'})
            
        body = json.loads(request.body)
        return JsonResponse({})

    def post(self, request):
        try:
            ingredients = request.body['ingredients']
        except KeyError:
            return HttpResponseBadRequest("No ingredient specified")

        if len(ingredients) >= 1:
            # scrape
            pass
        else:
            queryset = Ingredient.objects.filter(name=indgredient[0])
            if queryset.exists():
                JsonResponse({'objects': 'found'})
                pass
            else:
                # scrape

        Ingredient.objects.filter
        if len(request.body) <= 0:
            return JsonResponse({'yo': 'no json sent'})
            
        body = json.loads(request.body)
        return JsonResponse(body)

