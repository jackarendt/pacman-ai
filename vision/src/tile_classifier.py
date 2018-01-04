import argparse
import os
import pandas as pd
import sys
import tensorflow as tf
from tensorflow.python.framework import graph_io
import metrics
from read_input_data import *
import trainer

FLAGS = None

HIDDEN_UNIT_SIZE = 196

def main(_):
  print("loading...")
  full_data_set = read_input_data()
  data_set = split_data_set(full_data_set,
                            train_percentage=FLAGS.train_ratio,
                            cv_percentage=FLAGS.cv_ratio,
                            test_percentage=FLAGS.test_ratio)
  print('data set read from disk. creating tensor graph.')
  train_session = trainer.train(data_set=data_set,
                                num_labels=NUM_CLASSES,
                                max_steps=FLAGS.max_steps,
                                learning_rate=FLAGS.learning_rate,
                                hidden_unit_size=HIDDEN_UNIT_SIZE,
                                dropout=FLAGS.dropout,
                                log_dir=FLAGS.log_dir)

  trainer.export_graph(FLAGS.export_dir, train_session)

if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('--max_steps', type=int, default=2500,
                      help='Number of steps to run trainer.')
  parser.add_argument('--learning_rate', type=float, default=0.003,
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
        default=os.path.join(os.getenv('TEST_TMPDIR', '/tmp'), 'pacman/tiles/logs/'),
        help='Summaries log directory')
  parser.add_argument(
        '--export_dir',
        type=str,
        default=os.path.dirname(os.path.realpath(__file__)) + RELATIVE_EXPORT_DIR,
        help='Model export directory')
  FLAGS, unparsed = parser.parse_known_args()
  tf.app.run(main=main, argv=[sys.argv[0]] + unparsed)
