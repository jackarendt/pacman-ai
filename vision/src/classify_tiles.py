"""File that classifies different tiles into their respective groups."""

import argparse
import os
import pandas as pd
import sys
import tensorflow as tf
from read_input_data import *

# Removes the "Your CPU has instructions that tf was not compiled to use" warnings.
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

FLAGS = None

def _weight_variable(shape):
  """Create a weight variable with appropriate initialization"""
  initial = tf.truncated_normal(shape, stddev=0.1)
  return tf.Variable(initial)

def _bias_variable(shape):
  """Create a bias variable with appropriate initialization"""
  initial = tf.constant(0.1, shape=shape)
  return tf.Variable(initial)

def _variable_summaries(var):
  """Attach a lot of summaries to a Tensor for tensorboard vizualizations."""
  with tf.name_scope('summaries'):
    mean = tf.reduce_mean(var)
    tf.summary.scalar('mean', mean)
    with tf.name_scope('stddev'):
      stddev = tf.sqrt(tf.reduce_mean(tf.square(var - mean)))
    tf.summary.scalar('stddev', stddev)
    tf.summary.scalar('max', tf.reduce_max(var))
    tf.summary.scalar('min', tf.reduce_min(var))
    tf.summary.histogram('histogram', var)

def _nn_layer(input_tensor, input_dim, output_dim, layer_name, act=tf.nn.relu):
  """Reusable code for making a simple neural net layer.

  It does a matrix multiply, bias add, and then uses ReLU to nonlinearize. It also sets up name
  scoping so that the resultant graph is easy to read, and adds a number of summary ops.
  """
  with tf.name_scope(layer_name):
    with tf.name_scope('weights'):
      weights = _weight_variable([input_dim, output_dim])
      _variable_summaries(weights)
    with tf.name_scope('biases'):
      biases = _bias_variable([output_dim])
      _variable_summaries(biases)
    with tf.name_scope('Wx_plus_b'):
      preactivate = tf.matmul(input_tensor, weights) + biases
      tf.summary.histogram('pre_activations', preactivate)
    activations = act(preactivate, name='activation')
    tf.summary.histogram('activations', activations)
    return activations

def _train():
  """ Trains a vision model and saves it to disk. """
  full_data_set = read_input_data()
  data_set = split_data_set(full_data_set,
                            train_percentage=FLAGS.train_ratio,
                            cv_percentage=FLAGS.cv_ratio,
                            test_percentage=FLAGS.test_ratio)

  sess = tf.InteractiveSession()

  with tf.name_scope('input'):
    x = tf.placeholder(tf.float32, [None, IMAGE_BUFFER_LENGTH], name='x-input')
    y_ = tf.placeholder(tf.float32, [None, NUM_LABELS], name='y-input')

  hidden1 = _nn_layer(x, IMAGE_BUFFER_LENGTH, 175, 'hidden')
  with tf.name_scope('dropout'):
    keep_prob = tf.placeholder(tf.float32)
    tf.summary.scalar('dropout_keep_probability', keep_prob)
    dropped = tf.nn.dropout(hidden1, keep_prob)

  y = _nn_layer(dropped, 175, NUM_LABELS, 'output', act=tf.identity)
  with tf.name_scope('cross_entropy'):
    diff = tf.nn.softmax_cross_entropy_with_logits(labels=y_, logits=y)
    with tf.name_scope('total'):
      cross_entropy = tf.reduce_mean(diff)
  tf.summary.scalar('cross_entropy', cross_entropy)

  with tf.name_scope('train'):
    train_step = tf.train.AdamOptimizer(FLAGS.learning_rate).minimize(cross_entropy)

  with tf.name_scope('accuracy'):
    with tf.name_scope('correct_prediction'):
      correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(y_, 1))
    with tf.name_scope('accuracy'):
      accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
  tf.summary.scalar('accuracy', accuracy)

  merged = tf.summary.merge_all()
  train_writer = tf.summary.FileWriter(FLAGS.log_dir + '/train', sess.graph)
  test_writer = tf.summary.FileWriter(FLAGS.log_dir + '/test')
  tf.global_variables_initializer().run()

  def feed_dict(train):
    """Make a TensorFlow feed_dict: maps data onto Tensor placeholders."""
    if train:
      xs, ys = data_set.train.next_batch(100)
      k = FLAGS.dropout
    else:
      xs, ys = data_set.test.images, data_set.test.labels
      k = 1.0
    return {x: xs, y_:ys, keep_prob: k}

  for i in range(FLAGS.max_steps):
    # Record summaries and test-set accuracies.
    if i % 10 ==0:
      summary, acc = sess.run([merged, accuracy], feed_dict=feed_dict(False))
      test_writer.add_summary(summary, i)
      print('Accuracy at step %s: %s' % (i, acc))
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

def main(_):
  if tf.gfile.Exists(FLAGS.log_dir):
    tf.gfile.DeleteRecursively(FLAGS.log_dir)
  tf.gfile.MakeDirs(FLAGS.log_dir)
  _train()

if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('--max_steps', type=int, default=1000,
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
  FLAGS, unparsed = parser.parse_known_args()
  tf.app.run(main=main, argv=[sys.argv[0]] + unparsed)
