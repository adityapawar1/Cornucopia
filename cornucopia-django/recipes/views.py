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
        if queryset[0].bad_search:
            return 'bad_search'

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
placeholder_recipe = [
            {
                'title': 'No Recipe Found',
                'url': 'None' ,
                'ingredients': [
                    'None'
                ],
                'directions': 'None'
            }
        ]

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
        if recipes == 'bad_search':
            return placeholder_recipe
        if type(recipes) == type([]):
            print(f'{ingredient_string} Scraper Done')
            print(recipes)
            return recipes
        sleep(1)

    if type(recipe) == type("string"):
        recipes = placeholder_recipe

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

        if 'banana' in ingredients[0]:

            response = {
                'recipes': [
                    {
                    'title': 'Banana Soft Serve Dairy Free Ice Cream Recipe',
                    'url': 'https://www.melaniecooks.com/banana-soft-serve-dairy-free-ice-cream-recipe/6845/' ,
                    'ingredients': [
                        'Bananas',
                        'Sugar'
                    ],
                    'directions': 'Put frozen bananas in a food processor bowl fitted with the metal blade. Turn the food processor on and process until smooth. Serve immediately'
                    },
                    {
                    'title': 'Chocolate Chip Banana Bars',
                    'url': 'https://butterwithasideofbread.com/best-banana-recipes/',
                    'ingredients': [
                        'Bananas',
                        'Brown sugar',
                        'Milk',
                        'Baking Soda'
                    ],
                    'directions': 'Heat oven to 350 degrees F. Spray a 15×10.5″ pan with non-stick spray. Peel bananas and mash well. Stir in brown sugar, oil, milk and eggs until combined. Add in dry ingredients and stir. Fold in 1/2 the chocolate chips. Spread the batter into the prepared pan and sprinkle remaining chips on top. Bake 18-22 minutes, until a wooden toothpick inserted in center comes out clean. Cool completely and cut into squares. Yields 24 bars'
                    },
                    {
                    'title': 'One-Ingredient Banana Ice Cream',
                    'url': 'https://cooking.nytimes.com/recipes/3038-one-ingredient-banana-ice-cream',
                    'ingredients': [
                        'Bananas',
                    ],
                    'directions': 'Peel the bananas, cut them in 2- to 3-inch chunks and place them in a freezer bag in the freezer for at least 6 hours. Remove and blend in a blender until smooth. Serve immediately, or freeze in an airtight container for at least 2 hours. Scoop and serve.'
                    }
                ]
            }

            return JsonResponse(response)


        if len(ingredients) > 1:
            # scrape
            recipes = run_spider(ingredients)
            return JsonResponse({'recipesmore': recipes}) 
        else:
            recipes = get_recipe(ingredients[0])
            if type(recipes) == type([]):
                # scrape
                recipes = run_spider(ingredients)
                return JsonResponse({'recipesscrape': recipes})   
            else:
                return JsonResponse({'recipesalr': recipes})    


