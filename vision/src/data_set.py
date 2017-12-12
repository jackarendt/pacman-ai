"""Class for representing an entire dataset. Splits it up into """
import numpy as np
import os
import pandas as pd
from constants import *


class DataSet(object):
  def __init__(self, data_set):
    """ Creates a dataset with a list of images and labels. """
    self._num_examples = data_set.shape[0]
    self._images = np.zeros(shape=(self._num_examples, IMAGE_BUFFER_LENGTH), dtype=np.float32)
    self._labels = np.zeros(shape=(self._num_examples, NUM_LABELS), dtype=np.float32)

    self._epochs_completed = 0
    self._index_in_epoch = 0

    # Converts the image dataframe into an ndarray.
    for idx, image in enumerate(data_set[IMAGE]):
      self._images[idx] = image

    # Converts the label dataframe into an ndarray.
    for idx, label in enumerate(data_set[LABEL]):
      self._labels[idx] = label

  @property
  def images(self):
    return self._images

  @property
  def labels(self):
    return self._labels

  @property
  def num_examples(self):
    return self._num_examples

  @property
  def epochs_completed(self):
    return self._epochs_completed


  def next_batch(self, batch_size, shuffle=True):
    """Return the next `batch_size` examples from this data set."""
    start = self._index_in_epoch

    # Shuffle for the first epoch
    if self._epochs_completed == 0 and start == 0 and shuffle:
      self._shuffle()

    if start + batch_size < self._num_examples:
      self._index_in_epoch += batch_size
      end = self._index_in_epoch
      return self._images[start:end], self._labels[start:end]
    else:
      remaining_examples = self._num_examples - start
      remaining_images = self._images[start:self._num_examples]
      remaining_labels = self._labels[start:self._num_examples]

      if shuffle:
        self._shuffle()

      start = 0
      self._index_in_epoch = batch_size - remaining_examples
      end = self._index_in_epoch
      new_epoch_images = self._images[start:end]
      new_epoch_labels = self._labels[start:end]
      return np.concatenate((remaining_images, new_epoch_images), axis=0),\
             np.concatenate((remaining_labels, new_epoch_labels), axis=0)

  def _shuffle(self):
    """Shuffles the full data set."""
    perm0 = np.arange(self._num_examples)
    np.random.shuffle(perm0)
    self._images = self.images[perm0]
    self._labels = self.labels[perm0]
