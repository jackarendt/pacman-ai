"""Freezes the tensorflow graph, stripping any non-c++ compatible and non-inference operations."""

import argparse
import os
import sys
import tensorflow as tf

from tensorflow.python.tools import freeze_graph
from tensorflow.core.framework import graph_pb2
from tensorflow.python.framework import importer
from constants import *

# Removes the "Your CPU has instructions that tf was not compiled to use" warnings.
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

FLAGS = None

def main(_):
  export_path = os.path.dirname(os.path.realpath(__file__)) + '/' + FLAGS.export_dir

  input_graph_path = export_path + GRAPH_PB_NAME
  checkpoint_path = export_path + MODEL_NAME
  input_saver_def_path = ''
  input_binary = False
  output_node_names = 'prediction/prediction'
  restore_op_name = 'save/restore_all'
  filename_tensor_name = 'save/Const:0'
  output_frozen_graph_name = export_path + FROZEN_PB_NAME
  clear_devices = False

  # Freeze the graph.
  freeze_graph.freeze_graph(input_graph_path, input_saver_def_path,
                            input_binary, checkpoint_path, output_node_names,
                            restore_op_name, filename_tensor_name,
                            output_frozen_graph_name, clear_devices, '')


  # This is a super crude way to strip out the dropout nodes from the frozen model. The general idea
  # is to identify the block of nodes that have the 'dropout/' prefix and remove them. Then take the
  # output layer's input and assign it to the hidden layer's output.
  graph_def = graph_pb2.GraphDef()
  with tf.gfile.Open(output_frozen_graph_name, 'rb') as f:
    graph_def.ParseFromString(f.read())

    # The first index that dropout appears.
    dropout_start_index = -1
    # The index after the last 'dropout'.
    dropout_end_index = -1
    # The index where the output layer receives the dropout's output.
    dropout_output_index = -1
    # The input index of the output layer's node that is connected to the dropout.
    dropout_input_index = -1

    dropout_name_scope = 'dropout'
    for i, node in enumerate(graph_def.node):
      # Get the index where dropout nodes begin.
      if dropout_start_index == -1 and dropout_name_scope in node.name:
        dropout_start_index = i
      # Get the index of the last dropout node.
      if (dropout_start_index != -1 and
          dropout_end_index == -1 and
          dropout_name_scope not in node.name):
        dropout_end_index = i

      # Enumerate through a node's input to see if it connects to the dropout nodes.
      if dropout_end_index != -1:
        for idx, node_input in enumerate(node.input):
          if dropout_name_scope in node_input:
            dropout_output_index = i
            dropout_input_index = idx

    # Modify the graph_def to remove the dropout nodes and connect the hidden layer directly to the
    # output.
    graph_def.node[dropout_output_index].input[dropout_input_index] = (
        graph_def.node[dropout_start_index - 1].name
    )
    nodes = graph_def.node[:dropout_start_index] + graph_def.node[dropout_end_index:]

    # Save the finalized graph.
    output_graph = graph_pb2.GraphDef()
    output_graph.node.extend(nodes)
    with tf.gfile.GFile(export_path + FINALIZED_PB_NAME, 'wb') as wf:
      wf.write(output_graph.SerializeToString())

    print('Finalized Graph Nodes:')
    for i, node in enumerate(output_graph.node):
      print('%d %s %s' % (i, node.name, node.op))
      [print(u'└─── %d ─ %s' % (i, n)) for i, n in enumerate(node.input)]

if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('--export_dir', type=str, default="", help='Model export directory')
  FLAGS, unparsed = parser.parse_known_args()
  tf.app.run(main=main, argv=[sys.argv[0]] + unparsed)
