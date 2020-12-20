# Cornucopia
Cornucopia is an app that lets users use accessible ingredients to discover new dishes. Based on the entered ingredients, the program will refer users to recipes that contain them. Using multi-classification image recognition and web scraping, Cornucopia recommends recipes using ingredients that the users may already have.

# Frontend
We designed Cornucopia to be simple, yet amazing. Our app uses vibrant colors paired with a modern, unique design. With Swift as our base, we developed an iOS app that uses the UIKit library and CoreML. The app uses the Resnet50 machine learning model to classify each image with an ingredient. Then, the app uses the HTTP POST method to forward the recognized ingredients to the Amazon Web Services Server. The server returns recipes that use those ingredients and we use the information throughout various places in the application.

# Backend
The goal of the image recognition software is to implement a model that efficiently classifies ingredients from a picture.   
Powered by state of the art technology such as machine learning and web scraping, Cornucopia identifies recipes with your everyday ingredients.

