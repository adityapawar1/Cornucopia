from django.shortcuts import render
from django.views import View
from django.http import HttpResponse
import os.path


# Create your views here.
def handle_uploaded_file(f):
    with open(os.path.join(__file__, 'image.png'), 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)

class ImageInput(View):
    def post(self, request):
        handle_uploaded_file(request.FILES['file.png'])

        return HttpResponse('File upload was a success!')

        
