"""Helper file to create tensorboard metrics for a training iteration."""
import numpy as np
import tensorflow as tf
from constants import *

def _oneHotToDenseEncoding(predictions, labels):
  """Converts a one hot encoding to the dense encoding."""
  return tf.argmax(predictions, 1), tf.argmax(labels, 1)

def accuracy(predictions, labels, num_classes):
  """Returns the accuracy of the predictions."""
  pred_idx, label_idx = _oneHotToDenseEncoding(predictions, labels)
  with tf.name_scope('accuracy'):
    with tf.name_scope('correct_prediction'):
      correct_prediction = tf.equal(label_idx, pred_idx)
    with tf.name_scope('accuracy'):
      accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
      mean_accuracy, op = tf.metrics.mean_per_class_accuracy(label_idx, pred_idx, num_classes)
  tf.summary.scalar('mean_accuracy', mean_accuracy)
  tf.summary.scalar('accuracy', accuracy)
  return tf.group(accuracy, op)


def confusion_matrix(predictions, labels, num_classes):
  """Creates and returns a confusion matrix for the predictions and labels."""
  with tf.name_scope('confusion'):
    # Convert one-hot encoding to dense encoding.
    pred_idx, label_idx = _oneHotToDenseEncoding(predictions, labels)
    batch_confusion = tf.confusion_matrix(labels=label_idx, predictions=pred_idx,
                                          num_classes=num_classes)
    confusion = tf.Variable(tf.zeros([num_classes, num_classes], dtype=tf.int32), name='confusion')
    # Zero out the diagonal so that correct predictions don't wash out incorrect ones. It is still
    # important to see 200 misclassifications, even though there are 5000 correct classifications.
    zero_diagonal = tf.matrix_set_diag(confusion + batch_confusion, np.zeros(num_classes))
    confusion_update = confusion.assign(zero_diagonal)

    # Add a diagonal with values
    reformatted_confusion = tf.matrix_set_diag(confusion, np.repeat(255, num_classes))

    # Cast counts to float so tf.summary.image renormalizes to [0,255]
    confusion_image = tf.reshape(tf.cast(reformatted_confusion, tf.float32),
                                 [1, num_classes, num_classes, 1])
    tf.summary.image('confusion', confusion_image)
    tf.summary.text('confusion-matrix', tf.as_string(confusion))

    return confusion_update

def class_metrics(predictions, labels, classes):
  """Creates per-class metrics. Ex) accuracy, precision, recall, and f1 score."""
  pred_idx, label_idx = _oneHotToDenseEncoding(predictions, labels)
  ops = []
  with tf.name_scope('class'):
    for idx, label in enumerate(classes):
      with tf.name_scope(label):
        # For each class map the predictions and labels to whether each value matches the current
        # label. ex) label: 2, [2, 3, 5, 2, 3] -> [True, False, False, True, False]
        true_label = tf.map_fn(lambda l: tf.equal(l, idx), label_idx, dtype=tf.bool)
        true_pred = tf.map_fn(lambda l: tf.equal(l, idx), pred_idx, dtype=tf.bool)

        # Calculate precision and add a tensorboard scalar.
        precision, prec_op = tf.metrics.precision(labels=true_label, predictions=true_pred)
        tf.summary.scalar('precision', precision)

        # Calculate recall and add a tensorboard scalar.
        recall, rec_op = tf.metrics.recall(labels=true_label, predictions=true_pred)
        tf.summary.scalar('recall', recall)

        # Compute the f1 score and add a tensorboard scalar.
        f1 = (2 * recall * precision) / (recall + precision)
        tf.summary.scalar('f1', f1)

        # Calculate class accuracy and add a tensorboard scalar.
        accuracy = tf.reduce_mean(tf.cast(tf.equal(true_label, true_pred), tf.float32))
        tf.summary.scalar('accuracy', accuracy)

      # Append the class operations to the ops list.
      ops.append(tf.group(rec_op, prec_op, accuracy, f1))

  # Return the list of ops as a single group operation.
  return tf.group(*ops)
