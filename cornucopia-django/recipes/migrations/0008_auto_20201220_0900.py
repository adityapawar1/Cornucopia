# Generated by Django 3.1.4 on 2020-12-20 09:00

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('recipes', '0007_ingredient_recipe'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Ingredient',
        ),
        migrations.DeleteModel(
            name='Recipe',
        ),
    ]