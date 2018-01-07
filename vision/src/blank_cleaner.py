"""
  Some blank tiles have very subtle blue in them, (4, 5, 27). This is almost impossible to reliably
  detect by a human eye. This script loads in the data labels.csv file and checks to see if more
  than 1/4 of the pixel components are non-zero (accounting for all of the alpha values). If there
  are more than 1/4, the tile has been misclassified as blank, and should be made 'ignore' instead.
"""
from constants import *
from math import *
from functools import *
import numpy as np
import os
import pandas as pd
from PIL import Image

if __name__ == '__main__':
  data_dir = os.path.dirname(os.path.realpath(__file__)) + '/../tiles/'
  data_set = pd.read_csv(data_dir + LABEL_FILE_NAME, skipinitialspace=True,
                         skiprows=1, names=[IMAGE, LABEL])
  data_set[LABEL] = data_set[LABEL].astype(object)

  count = 0
  for image_idx, row in data_set.iterrows():
    # Load the image, and get the RBGA pixel data.
    im = Image.open(data_dir + row[IMAGE])
    rgba_pixels = im.getdata()

    # Flatten the 2d array into a 1D array.
    argb_data = [x for sets in rgba_pixels for x in sets]

    # Verify that the tile is actually blank if 1/4 of the tiles are nonzero.
    if data_set.at[image_idx, LABEL] == 2:
      visible_components = len(list(filter(lambda comp: comp > 0, argb_data)))
      if visible_components > len(argb_data) / 4:
        # Change the classification to "ignore".
        count += 1
        data_set.at[image_idx, LABEL] = 12

  # Write the CSV to disk.
  print(count, 'blank tiles converted to ignore.')
  data_set.to_csv(data_dir + LABEL_FILE_NAME, index=False)
