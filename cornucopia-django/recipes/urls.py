from django.urls import path

from . import views

urlpatterns = [
    # path('image/', views.ImageInput.as_view(), name='image'),
    path('api/ingredient', views.RecipeFinder.as_view(), name='recipe_finder'),
]