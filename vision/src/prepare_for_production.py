"""Freezes the tensorflow graph, stripping any non-c++ compatible and non-inference operations."""

import tensorflow as tf
import os
from tensorflow.python.tools import freeze_graph
from tensorflow.core.framework import graph_pb2
from tensorflow.python.framework import importer
from constants import *

# Removes the "Your CPU has instructions that tf was not compiled to use" warnings.
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

if __name__ == '__main__':
  export_path = os.path.dirname(os.path.realpath(__file__)) + RELATIVE_EXPORT_DIR

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
  input_graph_def = graph_pb2.GraphDef()
  with tf.gfile.Open(output_frozen_graph_name, 'rb') as f:
    input_graph_def.ParseFromString(f.read())
    _ = importer.import_graph_def(input_graph_def, name='')

    graph = tf.get_default_graph()

    # The first index that dropout appears.
    dropout_start_index = -1
    # The index after the last 'dropout'.
    dropout_end_index = -1
    # The index where the output layer receives the dropout's output.
    dropout_output_index = -1
    # The input index of the output layer's node that is connected to the dropout.
    dropout_input_index = -1

    dropout_name_scope = 'dropout'
    for i, node in enumerate(graph.as_graph_def().node):
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
    graph_def = graph.as_graph_def()
    graph_def.node[dropout_output_index].input[dropout_input_index] = (
        graph_def.node[dropout_start_index - 1].name
    )
    new_nodes = graph_def.node[:dropout_start_index] + graph_def.node[dropout_end_index:]

    # Save the finalized graph.
    output_graph = graph_pb2.GraphDef()
    output_graph.node.extend(new_nodes)
    with tf.gfile.GFile(export_path + FINALIZED_PB_NAME, 'wb') as f:
      f.write(output_graph.SerializeToString())
