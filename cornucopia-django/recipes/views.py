from django.shortcuts import render
from django.views import View
from django.http import HttpResponse, JsonResponse, HttpResponseBadRequest
from .models import Ingredient, Recipe
import os.path
import json
from time import sleep
import requests
from platform import platform

def get_recipe(ingredient):
    print(len(Ingredient.objects))
    queryset = Ingredient.objects.filter(name=ingredient)
    if queryset.exists():
        recipe_query = Recipe.objects.filter(ingredient=queryset[0])

        if recipe_query.exists():
            recipes = []
            for recipe in recipe_query:
                return_recipe = {}
                return_recipe['title'] = recipe.title 
                return_recipe['url'] = recipe.link
                return_recipe['ingredients'] = recipe.ing_all
                return_recipe['directions'] = recipe.directions
                recipes.append(return_recipe)
                print(return_recipe)

            return recipes
        else:
            return 'no_recipe' # would be scraping for {ingredients} becuase it is a new ingredient'
    else:
        return 'no_ingredient' # ingredient {ingredients[0]} found, but no associated recipes, will scrape'
        
       

    # return {}

def run_spider(ingredients):
    ingredient_string = ""
    for ingredient in ingredients:
        ingredient_string += ingredient + ', '
        
    ingredient_string = ingredient_string[:-2]
    data = {
            'project': 'recipe_crawler',
            'spider': 'RecipeCrawler',
            'ingredients': ingredient_string,
    }

    response = requests.post('http://localhost:6800/schedule.json', data=data)
    print('started spider')

    for i in range(20):
        recipe = get_recipe(ingredients[0])
        if recipe != 'no_recipe' and recipe != 'no_ingredient':
            print('Scraper Done!!')
            break
        sleep(1)

    if type(recipe) != type({}):
        recipe =  [
            {
                'title': 'No Recipe Found',
                'url': 'None' ,
                'ingredients': [
                    'None'
                ],
                'directions': 'None'
            }
        ]

    return recipe


# Create your views here.
class RecipeFinder(View):
    def get(self, request):
        # if len(request.body) <= 0:
        #     return JsonResponse({'yo': 'no json sent'})
            
        # body = json.loads(request.body)
        response = [
            {
                'title': 'No Recipe Found',
                'url': 'None' ,
                'ingredients': [
                    'None'
                ],
                'directions': 'None'
            }
        ]
        return JsonResponse({'recipes': response})

    def post(self, request):
        try:
            body = json.loads(request.body)
        except json.decoder.JSONDecodeError:
            raise json.decoder.JSONDecodeError(f'json.decoder.JSONDecodeError, json that was attempted was {request.body}')

        # error handling
        if len(request.body) <= 0:
            return HttpResponseBadRequest('No requests body')
        try:
            ingredients = body['ingredients']
        except KeyError:
            return HttpResponseBadRequest("No ingredient(s) specified")


        if len(ingredients) > 1:
            # scrape
            recipe = run_spider(ingredients)
        else:
            recipes = get_recipe(ingredients[0])
            if recipes == 'no_ingredient' or recipes == 'no_recipe':
                # scrape
                recipe = run_spider(ingredients)
                return JsonResponse({'recipes': recipes})   
            else:
                return JsonResponse({'recipes': recipes})    

