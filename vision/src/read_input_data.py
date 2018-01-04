"""Reads input data from the tiles and segments it into training and  test sets."""

from constants import *
from data_set import *
import itertools
from math import *
import numpy as np
import os
import pandas as pd
from PIL import Image

from tensorflow.contrib.learn.python.learn.datasets import base
from tensorflow.python.framework import dtypes

# Indices of different color bands stored in RGBA format.
RGBA_R = 0
RGBA_G = 1
RGBA_B = 2
RGBA_A = 3

def _convert_label_to_one_hot(label, num_classes):
  """Converts an index to a one-hot encoded list."""
  one_hot = np.zeros(num_classes, dtype=np.float32)
  one_hot[label] = 1
  return one_hot

def read_input_data(data_dir, num_classes):
  """
  Reads the input data and converts it to a 1D array of image data in ARGB format, with the
  appropriate label.
  """
  data_set = pd.read_csv(data_dir + 'labels.csv', skipinitialspace=True,
                         skiprows=1, names=[IMAGE, LABEL])

  data_set[LABEL] = data_set[LABEL].astype(object)

  for image_idx, row in data_set.iterrows():
    # Load the image, and get the RBGA pixel data.
    im = Image.open(data_dir + row[IMAGE])
    rgba_pixels = im.getdata()

    # Convert the rgba pixel data to ARGB (the macOS default for screen captures), and flatten it
    # to a 1D array of pixel values with format [A0, R0, G0, B0, A1, R1, G1, B1...].
    argb_pixels = \
        [(pixel[RGBA_A], pixel[RGBA_R], pixel[RGBA_G], pixel[RGBA_B]) for pixel in rgba_pixels]
    argb_data = [x for sets in argb_pixels for x in sets]

    # Change the image column so that it is a 1D array of pixel values instead of an image name.
    data_set.at[image_idx, IMAGE] = np.array(argb_data, dtype=np.float32)
    data_set.at[image_idx, LABEL] = _convert_label_to_one_hot(row[LABEL], num_classes)

  # Return the processed data set.
  return data_set

def split_data_set(data_set, num_classes,
                   train_percentage=0.64, cv_percentage=0.16, test_percentage=0.2):
  """Splits the data set into a training, cross validation, and test training group. """
  original_sum = train_percentage + cv_percentage + test_percentage
  if original_sum != 1:
    train_percentage = train_percentage / original_sum
    cv_percentage = cv_percentage / original_sum
    test_percentage = test_percentage / original_sum
    print('Dataset partition ratios do not total 1. They have been normalized to:\n' +
          'train: %f\ncv: %f\ntest: %f\n' % (train_percentage, cv_percentage, test_percentage))

  data_set = data_set.sample(frac=1).reset_index(drop=True)

  train_idx = floor(train_percentage * len(data_set.index))
  cv_idx = train_idx + floor(cv_percentage * len(data_set.index))

  train = DataSet(data_set[0:train_idx].reset_index(drop=True), num_classes)
  cv = DataSet(data_set[train_idx:cv_idx].reset_index(drop=True), num_classes)
  test = DataSet(data_set[cv_idx:].reset_index(drop=True), num_classes)

  return base.Datasets(train=train, validation=cv, test=test)
