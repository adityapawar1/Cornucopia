from django.shortcuts import render
from django.views import View
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import os.path


# Create your views here.
def handle_uploaded_file(f):
    with open(os.path.join(__file__, 'image.png'), 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)

class ImageInput(View):
    @csrf_exempt 
    def post(self, request):
        try:
            handle_uploaded_file(request.FILES['file.png'])
        except:
            return HttpResponse('File not found under file.png :(')

        return HttpResponse('File upload was a success!')

    def get(self, request):
        return HttpResponse('Use the POST method, not the GET method')


        
