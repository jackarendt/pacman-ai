"""Trains a DNN classifier based on a set of parameters."""
import os
import tensorflow as tf
from tensorflow.python.framework import graph_io
import metrics
from constants import *

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

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

def _evaluations(predictions, labels, num_classes, class_names):
  """Returns a group of operations to calculate accuracy and other evaluation metrics."""
  ops = [metrics.accuracy(predictions, labels, num_classes),
         metrics.confusion_matrix(predictions, labels, num_classes),
         metrics.class_metrics(predictions, labels, class_names)]
  return tf.group(*ops)

def train(data_set, num_classes, max_steps, learning_rate,
          hidden_unit_size, dropout, log_dir, class_names):
  """Trains a DNN Classifier for a given data set."""
  sess = tf.InteractiveSession()

  with tf.name_scope('input'):
    x = tf.placeholder(tf.float32, [None, IMAGE_BUFFER_LENGTH], name='x-input')
    y_ = tf.placeholder(tf.float32, [None, num_classes], name='y-input')
    # Add a histogram of the different labels that are passe`d in for each iteration. This helps
    # determine how evenly distributed labels are across epochs.
    tf.summary.histogram('labels', tf.argmax(y_, 1))

  # Have the input layer feed into a hidden layer, and dropout some values to make the DNN sparser
  # and quicker.
  hidden1 = _nn_layer(x, IMAGE_BUFFER_LENGTH, hidden_unit_size, 'hidden')
  with tf.name_scope('dropout'):
    keep_prob = tf.placeholder(tf.float32, name='dropoout')
    dropped = tf.nn.dropout(hidden1, keep_prob)

  # Create an output layer that has the specified number of outputs.
  y = _nn_layer(dropped, hidden_unit_size, num_classes, 'output', act=tf.identity)

  # Compute softmax of different labels, such that the sum of all predictions = 1.
  with tf.name_scope('prediction'):
    prediction = tf.nn.softmax(logits=y, name='prediction')
    tf.summary.histogram('labels', tf.argmax(prediction, 1))

  # Compute the loss of the iteration.
  with tf.name_scope('cross_entropy'):
    diff = tf.nn.softmax_cross_entropy_with_logits(labels=y_, logits=y)
    with tf.name_scope('total'):
      cross_entropy = tf.reduce_mean(diff)
  tf.summary.scalar('cross_entropy', cross_entropy)

  # Use the Adam optimizer to train the DNN.
  with tf.name_scope('train'):
    train_step = tf.train.AdamOptimizer(learning_rate).minimize(cross_entropy)

  # Evaluate the performance of the DNN, such as per-class accuracy, overall accuracy, and a
  # confusion matrix.
  with tf.name_scope('evaluation'):
    eval_metrics = _evaluations(prediction, y_, num_classes, class_names)

  # Merge all of the summaries, and write them to the proper directory.
  merged = tf.summary.merge_all()
  train_writer = tf.summary.FileWriter(log_dir + '/train', sess.graph)
  test_writer = tf.summary.FileWriter(log_dir + '/test')

  # Initialize the proper variables.
  tf.global_variables_initializer().run()
  tf.local_variables_initializer().run()

  def feed_dict(train):
    """Make a TensorFlow feed_dict: maps data onto Tensor placeholders."""
    if train:
      xs, ys = data_set.train.next_batch(250)
      k = dropout
    else:
      xs, ys = data_set.test.images, data_set.test.labels
      k = 1.0
    return {x: xs, y_:ys, keep_prob: k}

  print('graph created. begin training.')
  # Train for the max number of steps.
  for i in range(max_steps):
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
  return sess

def export_graph(export_dir, sess):
  """Exports a saved model to a given directory."""
  print('Exporting trained model to: ', export_dir)
  if tf.gfile.Exists(export_dir):
    tf.gfile.DeleteRecursively(export_dir)

  graph_io.write_graph(sess.graph, export_dir, GRAPH_PB_NAME)
  saver = tf.train.Saver(tf.trainable_variables())
  saver.save(sess, export_dir + MODEL_NAME, write_meta_graph=True)

  print('successfully saved model to: ', export_dir)
