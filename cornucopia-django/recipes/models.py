from django.db import models
from django.contrib.postgres.fields import ArrayField

# Create your models here.
class Ingredient(models.Model):
    name = models.CharField(max_length=64)

    # def __str__(self):
    #     return name

class Recipe(models.Model):
    title = models.CharField(max_length=200)
    directions = models.CharField(max_length=400)
    link = models.CharField(max_length=200)
    ing_all = ArrayField(models.CharField(max_length=200)) 
    used = ArrayField(models.CharField(max_length=200)) 
    needed = ArrayField(models.CharField(max_length=200)) 
    tags = ArrayField(models.CharField(max_length=200))
    ingredient = models.ForeignKey('Ingredient', on_delete=models.CASCADE)

    # def __str__(self):
    #     return title