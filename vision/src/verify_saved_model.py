"""Python script to verify that a saved model can be loaded and runs accurately."""

import argparse
import os
import pandas as pd
import sys
import tensorflow as tf
import metrics
from read_input_data import *

# Removes the "Your CPU has instructions that tf was not compiled to use" warnings.
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

FLAGS = None

def _verify_performance():
  """Verifies that a model can be loaded and has appropriate test accuracy."""
  print('loading data set...')
  full_data_set = read_input_data()
  data_set = split_data_set(full_data_set,
                            train_percentage=1 - FLAGS.test_ratio,
                            cv_percentage=0,
                            test_percentage=FLAGS.test_ratio)
  print('data set read, loading saved model from:', FLAGS.export_dir)

  with tf.Session(graph=tf.Graph()) as sess:
    tf.saved_model.loader.load(sess, [tf.saved_model.tag_constants.SERVING], FLAGS.export_dir)
    print('model successfully loaded.')
    graph = tf.get_default_graph()

    # Get the names of the input and output tensors.
    x = graph.get_tensor_by_name('input/x-input:0')

    # Predictions are on a scale of [0.0, 1.0], and all predictions for a given example sum to 1. If
    # the raw values are desired, use 'output/activations:0'.
    y = graph.get_tensor_by_name('prediction/prediction:0')

    # Since dropout is varied between test and train modes, it needs to have a concrete value here.
    dropout = graph.get_tensor_by_name('dropout/dropout:0')

    # Run the session on the test set.
    results = sess.run(y, {x: data_set.test.images, dropout: 1.0})

    # Get the index of the largets value.
    result_idx = tf.argmax(results, 1)
    y_idx = tf.argmax(data_set.test.labels, 1)

    # Get the accuracy of the model on the test set.
    correct_prediction = tf.equal(result_idx, y_idx)
    accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
    print('test accuracy:', sess.run(accuracy))

    # Print all softmax values for each example.
    if FLAGS.show_confidence:
      for idx in range(len(results)):
          print([('%.02f' % i)  for i in results[idx]])

def main(_):
  _verify_performance()


if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('--test_ratio', type=float, default=0.3,
                      help='Percentage of examples that make up the test set.')
  parser.add_argument('--show_confidence', type=bool, default=False,
                      help='Shows the clasification percentages for each example.')
  parser.add_argument(
        '--export_dir',
        type=str,
        default=os.path.dirname(os.path.realpath(__file__)) + '/../model/',
        help='Model export directory')
  FLAGS, unparsed = parser.parse_known_args()
  tf.app.run(main=main, argv=[sys.argv[0]] + unparsed)
