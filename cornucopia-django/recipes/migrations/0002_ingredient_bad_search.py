# Generated by Django 3.1.4 on 2020-12-20 14:55

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('recipes', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='ingredient',
            name='bad_search',
            field=models.BooleanField(default=False),
            preserve_default=False,
        ),
    ]
