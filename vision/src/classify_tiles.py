"""File that classifies different tiles into their respective groups."""

import argparse
import os
import pandas as pd
import sys
import tensorflow as tf
from tensorflow.python.framework import graph_io
import metrics
from read_input_data import *

# Removes the "Your CPU has instructions that tf was not compiled to use" warnings.
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

FLAGS = None

HIDDEN_UNIT_SIZE = 196

def _weight_variable(shape):
  """Create a weight variable with appropriate initialization"""
  initial = tf.truncated_normal(shape, stddev=0.1)
  return tf.Variable(initial)

def _bias_variable(shape):
  """Create a bias variable with appropriate initialization"""
  initial = tf.constant(0.1, shape=shape)
  return tf.Variable(initial)

def _nn_layer(input_tensor, input_dim, output_dim, layer_name, act=tf.nn.relu):
  """Reusable code for making a simple neural net layer.

  It does a matrix multiply, bias add, and then uses ReLU to nonlinearize. It also sets up name
  scoping so that the resultant graph is easy to read, and adds a number of summary ops.
  """
  with tf.name_scope(layer_name):
    with tf.name_scope('weights'):
      weights = _weight_variable([input_dim, output_dim])
    with tf.name_scope('biases'):
      biases = _bias_variable([output_dim])
    with tf.name_scope('Wx_plus_b'):
      preactivate = tf.matmul(input_tensor, weights) + biases
      tf.summary.histogram('pre_activations', preactivate)
    activations = act(preactivate, name='activation')
    tf.summary.histogram('activations', activations)
    return activations

def _evaluations(predictions, labels):
  """Returns a group of operations to calculate accuracy and other evaluation metrics."""
  ops = [metrics.accuracy(predictions, labels),
         metrics.confusion_matrix(predictions, labels),
         metrics.class_metrics(predictions, labels)]
  return tf.group(*ops)

def _train():
  """
    Trains a vision model. It takes in a 2D matrix of image pixel values, and constructs a DNN with
    one hidden layer, and one output for each class. To determine the most likely class of the DNN,
    simply call tf.argmax(y, 1). This will return the index of the DNN's prediction.
  """
  full_data_set = read_input_data()
  data_set = split_data_set(full_data_set,
                            train_percentage=FLAGS.train_ratio,
                            cv_percentage=FLAGS.cv_ratio,
                            test_percentage=FLAGS.test_ratio)
  print('data set read from disk. creating tensor graph.')

  sess = tf.InteractiveSession()

  with tf.name_scope('input'):
    x = tf.placeholder(tf.float32, [None, IMAGE_BUFFER_LENGTH], name='x-input')
    y_ = tf.placeholder(tf.float32, [None, NUM_CLASSES], name='y-input')
    # Add a histogram of the different labels that are passed in for each iteration. This helps
    # determine how evenly distributed labels are across epochs.
    tf.summary.histogram('labels', tf.argmax(y_, 1))

  # Have the input layer feed into a hidden layer, and dropout some values to make the DNN sparser
  # and quicker.
  hidden1 = _nn_layer(x, IMAGE_BUFFER_LENGTH, HIDDEN_UNIT_SIZE, 'hidden')
  with tf.name_scope('dropout'):
    keep_prob = tf.placeholder(tf.float32, name='dropout')
    dropped = tf.nn.dropout(hidden1, keep_prob)

  # Create an output layer that has the NUM_CLASSES different outputs.
  y = _nn_layer(dropped, HIDDEN_UNIT_SIZE, NUM_CLASSES, 'output', act=tf.identity)

  with tf.name_scope('prediction'):
    prediction = tf.nn.softmax(logits=y, name='prediction')

  # Compute the loss of the iteration.
  with tf.name_scope('cross_entropy'):
    diff = tf.nn.softmax_cross_entropy_with_logits(labels=y_, logits=y)
    with tf.name_scope('total'):
      cross_entropy = tf.reduce_mean(diff)
  tf.summary.scalar('cross_entropy', cross_entropy)

  # Add histogram for predictions.
  with tf.name_scope('predictions'):
    tf.summary.histogram('labels', tf.argmax(y, 1))

  # Use the Adam optimizer to train the DNN.
  with tf.name_scope('train'):
    train_step = tf.train.AdamOptimizer(FLAGS.learning_rate).minimize(cross_entropy)

  # Evaluate the performance of the DNN, such as per-class accuracy, overall accuracy, and a
  # confusion matrix.
  with tf.name_scope('evaluation'):
    eval_metrics = _evaluations(prediction, y_)

  # Merge all of the summaries, and write them to the proper directory.
  merged = tf.summary.merge_all()
  train_writer = tf.summary.FileWriter(FLAGS.log_dir + '/train', sess.graph)
  test_writer = tf.summary.FileWriter(FLAGS.log_dir + '/test')

  # Initialize the proper variables.
  tf.global_variables_initializer().run()
  tf.local_variables_initializer().run()

  def feed_dict(train):
    """Make a TensorFlow feed_dict: maps data onto Tensor placeholders."""
    if train:
      xs, ys = data_set.train.next_batch(100)
      k = FLAGS.dropout
    else:
      xs, ys = data_set.test.images, data_set.test.labels
      k = 1.0
    return {x: xs, y_:ys, keep_prob: k}

  print('graph created. begin training.')
  # Train for the max number of steps.
  for i in range(FLAGS.max_steps):
    # Record summaries and test-set accuracies.
    if i % 10 ==0:
      summary, _ = sess.run([merged, eval_metrics], feed_dict=feed_dict(False))
      test_writer.add_summary(summary, i)
    else:
      if i % 100 == 99:
        run_options = tf.RunOptions(trace_level=tf.RunOptions.FULL_TRACE)
        run_metadata = tf.RunMetadata()
        summary, _ = sess.run([merged, train_step],
                              feed_dict=feed_dict(True),
                              options=run_options,
                              run_metadata=run_metadata)

        train_writer.add_run_metadata(run_metadata, 'step%03d' % i)
        train_writer.add_summary(summary, i)
        print('Adding run metadata for', i)
      else:
        summary, _ = sess.run([merged, train_step], feed_dict=feed_dict(True))
        train_writer.add_summary(summary, i)

  train_writer.close()
  test_writer.close()

  print('Exporting trained model to: ', FLAGS.export_dir)

  if tf.gfile.Exists(FLAGS.export_dir):
    tf.gfile.DeleteRecursively(FLAGS.export_dir)

  graph_io.write_graph(sess.graph, FLAGS.export_dir, GRAPH_PB_NAME)
  saver = tf.train.Saver(tf.trainable_variables())
  saver.save(sess, FLAGS.export_dir + MODEL_NAME, write_meta_graph=True)

  print('successfully saved model to: ', FLAGS.export_dir)

def main(_):
  print('loading...')
  if tf.gfile.Exists(FLAGS.log_dir):
    tf.gfile.DeleteRecursively(FLAGS.log_dir)
  tf.gfile.MakeDirs(FLAGS.log_dir)
  print('logs dir created')
  _train()

if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('--max_steps', type=int, default=2500,
                      help='Number of steps to run trainer.')
  parser.add_argument('--learning_rate', type=float, default=0.001,
                      help='Initial learning rate')
  parser.add_argument('--dropout', type=float, default=0.9,
                      help='Keep probability for training dropout.')
  parser.add_argument('--train_ratio', type=float, default=0.7,
                      help='Percentage of examples that make up the training set.')
  parser.add_argument('--cv_ratio', type=float, default=0.0,
                      help='Percentage of examples that make up the cross validation set.')
  parser.add_argument('--test_ratio', type=float, default=0.3,
                      help='Percentage of examples that make up the test set.')
  parser.add_argument(
        '--log_dir',
        type=str,
        default=os.path.join(os.getenv('TEST_TMPDIR', '/tmp'), 'pacman/vision/logs/'),
        help='Summaries log directory')
  parser.add_argument(
        '--export_dir',
        type=str,
        default=os.path.dirname(os.path.realpath(__file__)) + RELATIVE_EXPORT_DIR,
        help='Model export directory')
  FLAGS, unparsed = parser.parse_known_args()
  tf.app.run(main=main, argv=[sys.argv[0]] + unparsed)
