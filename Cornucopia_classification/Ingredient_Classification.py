#importing libraries
import numpy as np
import matplotlib.pyplot as plt

import os
import pathlib

import PIL
import glob

import tensorflow as tf
from tensorflow import keras 

#setting path of base directory
base_dir = 'Data/fruits-360'
#setting path of training data directory by using the directory of the base directory.
train_dir = os.path.join(base_dir, 'Training/')

#A subclass of PurePath, this class represents concrete paths of the system’s path fl
train_dir_pathlib = pathlib.Path('Data/fruits-360/Training/')

# Total number of Images in Training set
print(len(list(train_dir_pathlib.glob("*/*.jpg"))))

#fruits is a list of the paths for the training images for Apple Red Delicious
fruits = list(train_dir_pathlib.glob("Apple Red Delicious/*.jpg"))
print(fruits)

#size of image
plt.figure(figsize = (10,10))

#plotting images 4*4
for i in range(16):
    plt.subplot(4,4,i+1)
    img = PIL.Image.open(str(fruits[i]))
    plt.imshow(img)
    plt.axis('on')
    
plt.show()

batch_size = 32
img_height = 100
img_width = 100

#Generates a tf.data.Dataset from image files in training directory

train_ds = tf.keras.preprocessing.image_dataset_from_directory(
    train_dir_pathlib,
    validation_split = 0.2,
    subset = 'training',
    seed = 99,
    image_size = (img_height, img_width),
    batch_size = batch_size
)

#Generates a tf.data.Dataset from image files for Validation
validation_ds = tf.keras.preprocessing.image_dataset_from_directory(
    train_dir_pathlib,
    validation_split = 0.2,
    subset = 'validation',
    seed = 99,
    image_size = (img_height, img_width),
    batch_size = batch_size
)

class_names = train_ds.class_names
num_class = len(class_names)

print(class_names)

print(num_class)

for images, labels in train_ds.take(1):
    plt.figure(figsize = (10,10))
    for i in range(9):
        plt.subplot(3,3,i+1)
        plt.imshow(images[i].numpy().astype('uint8'))
        plt.title(class_names[labels[i]])
        plt.axis("on")
plt.show()


# Pre-Processing

#Optomizes pipeline performance
AUTOTUNE = tf.data.experimental.AUTOTUNE

train_ds = train_ds.cache().shuffle(1000).prefetch(buffer_size = AUTOTUNE)
validation_ds = validation_ds.cache().prefetch(buffer_size = AUTOTUNE)


data_augmentation = tf.keras.Sequential(
    [
        tf.keras.layers.experimental.preprocessing.RandomFlip('horizontal'),
        tf.keras.layers.experimental.preprocessing.RandomRotation(0.2)
    ]
)

#preprocesses a tensor or numpy array encoding a batch of images.
preprocess_input = tf.keras.applications.resnet.preprocess_input

#base_model instantiated with the ResNet50 architecture
base_model = tf.keras.applications.resnet.ResNet50(
    input_shape = (img_height, img_width, 3),
    include_top = False,
    weights = 'imagenet'
)


base_model.trainable = False

global_average_layer = tf.keras.layers.GlobalAveragePooling2D()
prediction_layer = tf.keras.layers.Dense(num_class)

# # Building the Model
inputs = tf.keras.Input(shape = (100,100,3))
x = data_augmentation(inputs)
x = preprocess_input(x)
x = base_model(x, training = False)
x = global_average_layer(x)
x = tf.keras.layers.Dropout(0.2)(x)
outputs = prediction_layer(x)

model = tf.keras.Model(inputs = inputs, outputs = outputs)

optimizer = tf.keras.optimizers.Adam(learning_rate = 0.0001)

model.compile(
    optimizer = optimizer,
    loss = tf.keras.losses.SparseCategoricalCrossentropy(from_logits = True),
    metrics = ['accuracy']
)

model.summary()

#train the Model

model.evaluate(validation_ds)

epochs = 10
history = model.fit(
    train_ds,
    epochs = epochs,
    validation_data = validation_ds
)

train_loss = history.history['loss']
val_loss = history.history['val_loss']

epochs_range = range(epochs)

plt.figure(figsize = (12,10))

plt.plot(epochs_range, train_loss, label = 'Training Loss')
plt.plot(epochs_range, val_loss, label = 'Validation Loss')

plt.legend(loc = 'upper left')
plt.title('Training and Validation Loss')

plt.show()

np.argmin(val_loss)

model.save("model.h5") #using h5 extension
print("model has been saved")
