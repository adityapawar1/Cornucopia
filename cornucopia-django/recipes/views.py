from django.shortcuts import render
from django.views import View
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
import os.path
import json


# Create your views here.
class RecipeFinder(View):
    def get(self, request):
        body = json.loads(request.body)
        return JsonResponse(body)

    def post(self, request):
        body = json.loads(request.body)
        return JsonResponse(body)

