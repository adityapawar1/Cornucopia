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
    # print(lIngredient.objects))
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
    print(f'started spider for {ingredient_string}')

    for i in range(20):
        recipes = get_recipe(ingredients[0])
        if type(recipes) == type([]):
            print(f'{ingredient_string} Scraper Done')
            print(recipes)
            return recipes
        sleep(1)

    if type(recipe) == type("string"):
        recipes =  [
            {
                'title': 'No Recipe Found',
                'url': 'None' ,
                'ingredients': [
                    'None'
                ],
                'directions': 'None'
            }
        ]

    return recipes


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
            recipes = run_spider(ingredients)
            return JsonResponse({'recipes': recipes}) 
        else:
            recipes = get_recipe(ingredients[0])
            if type(recipes) == type([]):
                # scrape
                recipes = run_spider(ingredients)
                return JsonResponse({'recipes': recipes})   
            else:
                return JsonResponse({'recipes': recipes})    

