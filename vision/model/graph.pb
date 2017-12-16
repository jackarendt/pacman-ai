node {
  name: "input/x-input"
  op: "Placeholder"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: -1
        }
        dim {
          size: 256
        }
      }
    }
  }
}
node {
  name: "input/y-input"
  op: "Placeholder"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: -1
        }
        dim {
          size: 14
        }
      }
    }
  }
}
node {
  name: "input/ArgMax/dimension"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "input/ArgMax"
  op: "ArgMax"
  input: "input/y-input"
  input: "input/ArgMax/dimension"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "output_type"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "input/labels/tag"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "input/labels"
      }
    }
  }
}
node {
  name: "input/labels"
  op: "HistogramSummary"
  input: "input/labels/tag"
  input: "input/ArgMax"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "hidden/weights/truncated_normal/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\001\000\000\304\000\000\000"
      }
    }
  }
}
node {
  name: "hidden/weights/truncated_normal/mean"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "hidden/weights/truncated_normal/stddev"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.10000000149011612
      }
    }
  }
}
node {
  name: "hidden/weights/truncated_normal/TruncatedNormal"
  op: "TruncatedNormal"
  input: "hidden/weights/truncated_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "hidden/weights/truncated_normal/mul"
  op: "Mul"
  input: "hidden/weights/truncated_normal/TruncatedNormal"
  input: "hidden/weights/truncated_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "hidden/weights/truncated_normal"
  op: "Add"
  input: "hidden/weights/truncated_normal/mul"
  input: "hidden/weights/truncated_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "hidden/weights/Variable"
  op: "VariableV2"
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 256
        }
        dim {
          size: 196
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "hidden/weights/Variable/Assign"
  op: "Assign"
  input: "hidden/weights/Variable"
  input: "hidden/weights/truncated_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/weights/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "hidden/weights/Variable/read"
  op: "Identity"
  input: "hidden/weights/Variable"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/weights/Variable"
      }
    }
  }
}
node {
  name: "hidden/biases/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 196
          }
        }
        float_val: 0.10000000149011612
      }
    }
  }
}
node {
  name: "hidden/biases/Variable"
  op: "VariableV2"
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 196
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "hidden/biases/Variable/Assign"
  op: "Assign"
  input: "hidden/biases/Variable"
  input: "hidden/biases/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "hidden/biases/Variable/read"
  op: "Identity"
  input: "hidden/biases/Variable"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
}
node {
  name: "hidden/Wx_plus_b/MatMul"
  op: "MatMul"
  input: "input/x-input"
  input: "hidden/weights/Variable/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "hidden/Wx_plus_b/add"
  op: "Add"
  input: "hidden/Wx_plus_b/MatMul"
  input: "hidden/biases/Variable/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "hidden/Wx_plus_b/pre_activations/tag"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "hidden/Wx_plus_b/pre_activations"
      }
    }
  }
}
node {
  name: "hidden/Wx_plus_b/pre_activations"
  op: "HistogramSummary"
  input: "hidden/Wx_plus_b/pre_activations/tag"
  input: "hidden/Wx_plus_b/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "hidden/activation"
  op: "Relu"
  input: "hidden/Wx_plus_b/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "hidden/activations/tag"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "hidden/activations"
      }
    }
  }
}
node {
  name: "hidden/activations"
  op: "HistogramSummary"
  input: "hidden/activations/tag"
  input: "hidden/activation"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout/dropout"
  op: "Placeholder"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
}
node {
  name: "dropout/dropout_1/Shape"
  op: "Shape"
  input: "hidden/activation"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "dropout/dropout_1/random_uniform/min"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "dropout/dropout_1/random_uniform/max"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "dropout/dropout_1/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "dropout/dropout_1/Shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "dropout/dropout_1/random_uniform/sub"
  op: "Sub"
  input: "dropout/dropout_1/random_uniform/max"
  input: "dropout/dropout_1/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout/dropout_1/random_uniform/mul"
  op: "Mul"
  input: "dropout/dropout_1/random_uniform/RandomUniform"
  input: "dropout/dropout_1/random_uniform/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout/dropout_1/random_uniform"
  op: "Add"
  input: "dropout/dropout_1/random_uniform/mul"
  input: "dropout/dropout_1/random_uniform/min"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout/dropout_1/add"
  op: "Add"
  input: "dropout/dropout"
  input: "dropout/dropout_1/random_uniform"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout/dropout_1/Floor"
  op: "Floor"
  input: "dropout/dropout_1/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout/dropout_1/div"
  op: "RealDiv"
  input: "hidden/activation"
  input: "dropout/dropout"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "dropout/dropout_1/mul"
  op: "Mul"
  input: "dropout/dropout_1/div"
  input: "dropout/dropout_1/Floor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "output/weights/truncated_normal/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\304\000\000\000\016\000\000\000"
      }
    }
  }
}
node {
  name: "output/weights/truncated_normal/mean"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "output/weights/truncated_normal/stddev"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.10000000149011612
      }
    }
  }
}
node {
  name: "output/weights/truncated_normal/TruncatedNormal"
  op: "TruncatedNormal"
  input: "output/weights/truncated_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "output/weights/truncated_normal/mul"
  op: "Mul"
  input: "output/weights/truncated_normal/TruncatedNormal"
  input: "output/weights/truncated_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "output/weights/truncated_normal"
  op: "Add"
  input: "output/weights/truncated_normal/mul"
  input: "output/weights/truncated_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "output/weights/Variable"
  op: "VariableV2"
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 196
        }
        dim {
          size: 14
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "output/weights/Variable/Assign"
  op: "Assign"
  input: "output/weights/Variable"
  input: "output/weights/truncated_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "output/weights/Variable/read"
  op: "Identity"
  input: "output/weights/Variable"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights/Variable"
      }
    }
  }
}
node {
  name: "output/biases/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 14
          }
        }
        float_val: 0.10000000149011612
      }
    }
  }
}
node {
  name: "output/biases/Variable"
  op: "VariableV2"
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 14
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "output/biases/Variable/Assign"
  op: "Assign"
  input: "output/biases/Variable"
  input: "output/biases/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "output/biases/Variable/read"
  op: "Identity"
  input: "output/biases/Variable"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases/Variable"
      }
    }
  }
}
node {
  name: "output/Wx_plus_b/MatMul"
  op: "MatMul"
  input: "dropout/dropout_1/mul"
  input: "output/weights/Variable/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "output/Wx_plus_b/add"
  op: "Add"
  input: "output/Wx_plus_b/MatMul"
  input: "output/biases/Variable/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "output/Wx_plus_b/pre_activations/tag"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "output/Wx_plus_b/pre_activations"
      }
    }
  }
}
node {
  name: "output/Wx_plus_b/pre_activations"
  op: "HistogramSummary"
  input: "output/Wx_plus_b/pre_activations/tag"
  input: "output/Wx_plus_b/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "output/activation"
  op: "Identity"
  input: "output/Wx_plus_b/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "output/activations/tag"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "output/activations"
      }
    }
  }
}
node {
  name: "output/activations"
  op: "HistogramSummary"
  input: "output/activations/tag"
  input: "output/activation"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "prediction/prediction"
  op: "Softmax"
  input: "output/activation"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "cross_entropy/Rank"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "cross_entropy/Shape"
  op: "Shape"
  input: "output/activation"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/Rank_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "cross_entropy/Shape_1"
  op: "Shape"
  input: "output/activation"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/Sub/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "cross_entropy/Sub"
  op: "Sub"
  input: "cross_entropy/Rank_1"
  input: "cross_entropy/Sub/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/Slice/begin"
  op: "Pack"
  input: "cross_entropy/Sub"
  attr {
    key: "N"
    value {
      i: 1
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "cross_entropy/Slice/size"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "cross_entropy/Slice"
  op: "Slice"
  input: "cross_entropy/Shape_1"
  input: "cross_entropy/Slice/begin"
  input: "cross_entropy/Slice/size"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/concat/values_0"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: -1
      }
    }
  }
}
node {
  name: "cross_entropy/concat/axis"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "cross_entropy/concat"
  op: "ConcatV2"
  input: "cross_entropy/concat/values_0"
  input: "cross_entropy/Slice"
  input: "cross_entropy/concat/axis"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/Reshape"
  op: "Reshape"
  input: "output/activation"
  input: "cross_entropy/concat"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/Rank_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "cross_entropy/Shape_2"
  op: "Shape"
  input: "input/y-input"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/Sub_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "cross_entropy/Sub_1"
  op: "Sub"
  input: "cross_entropy/Rank_2"
  input: "cross_entropy/Sub_1/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/Slice_1/begin"
  op: "Pack"
  input: "cross_entropy/Sub_1"
  attr {
    key: "N"
    value {
      i: 1
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "cross_entropy/Slice_1/size"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "cross_entropy/Slice_1"
  op: "Slice"
  input: "cross_entropy/Shape_2"
  input: "cross_entropy/Slice_1/begin"
  input: "cross_entropy/Slice_1/size"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/concat_1/values_0"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: -1
      }
    }
  }
}
node {
  name: "cross_entropy/concat_1/axis"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "cross_entropy/concat_1"
  op: "ConcatV2"
  input: "cross_entropy/concat_1/values_0"
  input: "cross_entropy/Slice_1"
  input: "cross_entropy/concat_1/axis"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/Reshape_1"
  op: "Reshape"
  input: "input/y-input"
  input: "cross_entropy/concat_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/SoftmaxCrossEntropyWithLogits"
  op: "SoftmaxCrossEntropyWithLogits"
  input: "cross_entropy/Reshape"
  input: "cross_entropy/Reshape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "cross_entropy/Sub_2/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "cross_entropy/Sub_2"
  op: "Sub"
  input: "cross_entropy/Rank"
  input: "cross_entropy/Sub_2/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/Slice_2/begin"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "cross_entropy/Slice_2/size"
  op: "Pack"
  input: "cross_entropy/Sub_2"
  attr {
    key: "N"
    value {
      i: 1
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "cross_entropy/Slice_2"
  op: "Slice"
  input: "cross_entropy/Shape"
  input: "cross_entropy/Slice_2/begin"
  input: "cross_entropy/Slice_2/size"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/Reshape_2"
  op: "Reshape"
  input: "cross_entropy/SoftmaxCrossEntropyWithLogits"
  input: "cross_entropy/Slice_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "cross_entropy/total/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "cross_entropy/total/Mean"
  op: "Mean"
  input: "cross_entropy/Reshape_2"
  input: "cross_entropy/total/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "cross_entropy_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "cross_entropy_1"
      }
    }
  }
}
node {
  name: "cross_entropy_1"
  op: "ScalarSummary"
  input: "cross_entropy_1/tags"
  input: "cross_entropy/total/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "predictions/ArgMax/dimension"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "predictions/ArgMax"
  op: "ArgMax"
  input: "output/activation"
  input: "predictions/ArgMax/dimension"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "output_type"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "predictions/labels/tag"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "predictions/labels"
      }
    }
  }
}
node {
  name: "predictions/labels"
  op: "HistogramSummary"
  input: "predictions/labels/tag"
  input: "predictions/ArgMax"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "train/gradients/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "train/gradients/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "train/gradients/Fill"
  op: "Fill"
  input: "train/gradients/Shape"
  input: "train/gradients/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Reshape"
  op: "Reshape"
  input: "train/gradients/Fill"
  input: "train/gradients/cross_entropy/total/Mean_grad/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Shape"
  op: "Shape"
  input: "cross_entropy/Reshape_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Tile"
  op: "Tile"
  input: "train/gradients/cross_entropy/total/Mean_grad/Reshape"
  input: "train/gradients/cross_entropy/total/Mean_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tmultiples"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Shape_1"
  op: "Shape"
  input: "cross_entropy/Reshape_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Shape_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/cross_entropy/total/Mean_grad/Shape_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Prod"
  op: "Prod"
  input: "train/gradients/cross_entropy/total/Mean_grad/Shape_1"
  input: "train/gradients/cross_entropy/total/Mean_grad/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/cross_entropy/total/Mean_grad/Shape_1"
      }
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Const_1"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/cross_entropy/total/Mean_grad/Shape_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Prod_1"
  op: "Prod"
  input: "train/gradients/cross_entropy/total/Mean_grad/Shape_2"
  input: "train/gradients/cross_entropy/total/Mean_grad/Const_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/cross_entropy/total/Mean_grad/Shape_1"
      }
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Maximum/y"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/cross_entropy/total/Mean_grad/Shape_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Maximum"
  op: "Maximum"
  input: "train/gradients/cross_entropy/total/Mean_grad/Prod_1"
  input: "train/gradients/cross_entropy/total/Mean_grad/Maximum/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/cross_entropy/total/Mean_grad/Shape_1"
      }
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/floordiv"
  op: "FloorDiv"
  input: "train/gradients/cross_entropy/total/Mean_grad/Prod"
  input: "train/gradients/cross_entropy/total/Mean_grad/Maximum"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/cross_entropy/total/Mean_grad/Shape_1"
      }
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/Cast"
  op: "Cast"
  input: "train/gradients/cross_entropy/total/Mean_grad/floordiv"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/cross_entropy/total/Mean_grad/truediv"
  op: "RealDiv"
  input: "train/gradients/cross_entropy/total/Mean_grad/Tile"
  input: "train/gradients/cross_entropy/total/Mean_grad/Cast"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "train/gradients/cross_entropy/Reshape_2_grad/Shape"
  op: "Shape"
  input: "cross_entropy/SoftmaxCrossEntropyWithLogits"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/cross_entropy/Reshape_2_grad/Reshape"
  op: "Reshape"
  input: "train/gradients/cross_entropy/total/Mean_grad/truediv"
  input: "train/gradients/cross_entropy/Reshape_2_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/zeros_like"
  op: "ZerosLike"
  input: "cross_entropy/SoftmaxCrossEntropyWithLogits:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "train/gradients/cross_entropy/SoftmaxCrossEntropyWithLogits_grad/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: -1
      }
    }
  }
}
node {
  name: "train/gradients/cross_entropy/SoftmaxCrossEntropyWithLogits_grad/ExpandDims"
  op: "ExpandDims"
  input: "train/gradients/cross_entropy/Reshape_2_grad/Reshape"
  input: "train/gradients/cross_entropy/SoftmaxCrossEntropyWithLogits_grad/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/cross_entropy/SoftmaxCrossEntropyWithLogits_grad/mul"
  op: "Mul"
  input: "train/gradients/cross_entropy/SoftmaxCrossEntropyWithLogits_grad/ExpandDims"
  input: "cross_entropy/SoftmaxCrossEntropyWithLogits:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "train/gradients/cross_entropy/Reshape_grad/Shape"
  op: "Shape"
  input: "output/activation"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/cross_entropy/Reshape_grad/Reshape"
  op: "Reshape"
  input: "train/gradients/cross_entropy/SoftmaxCrossEntropyWithLogits_grad/mul"
  input: "train/gradients/cross_entropy/Reshape_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/add_grad/Shape"
  op: "Shape"
  input: "output/Wx_plus_b/MatMul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/add_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 14
      }
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/add_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "train/gradients/output/Wx_plus_b/add_grad/Shape"
  input: "train/gradients/output/Wx_plus_b/add_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/add_grad/Sum"
  op: "Sum"
  input: "train/gradients/cross_entropy/Reshape_grad/Reshape"
  input: "train/gradients/output/Wx_plus_b/add_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/add_grad/Reshape"
  op: "Reshape"
  input: "train/gradients/output/Wx_plus_b/add_grad/Sum"
  input: "train/gradients/output/Wx_plus_b/add_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/add_grad/Sum_1"
  op: "Sum"
  input: "train/gradients/cross_entropy/Reshape_grad/Reshape"
  input: "train/gradients/output/Wx_plus_b/add_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/add_grad/Reshape_1"
  op: "Reshape"
  input: "train/gradients/output/Wx_plus_b/add_grad/Sum_1"
  input: "train/gradients/output/Wx_plus_b/add_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/add_grad/tuple/group_deps"
  op: "NoOp"
  input: "^train/gradients/output/Wx_plus_b/add_grad/Reshape"
  input: "^train/gradients/output/Wx_plus_b/add_grad/Reshape_1"
}
node {
  name: "train/gradients/output/Wx_plus_b/add_grad/tuple/control_dependency"
  op: "Identity"
  input: "train/gradients/output/Wx_plus_b/add_grad/Reshape"
  input: "^train/gradients/output/Wx_plus_b/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/output/Wx_plus_b/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/add_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "train/gradients/output/Wx_plus_b/add_grad/Reshape_1"
  input: "^train/gradients/output/Wx_plus_b/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/output/Wx_plus_b/add_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/MatMul_grad/MatMul"
  op: "MatMul"
  input: "train/gradients/output/Wx_plus_b/add_grad/tuple/control_dependency"
  input: "output/weights/Variable/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: true
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "dropout/dropout_1/mul"
  input: "train/gradients/output/Wx_plus_b/add_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: true
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^train/gradients/output/Wx_plus_b/MatMul_grad/MatMul"
  input: "^train/gradients/output/Wx_plus_b/MatMul_grad/MatMul_1"
}
node {
  name: "train/gradients/output/Wx_plus_b/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "train/gradients/output/Wx_plus_b/MatMul_grad/MatMul"
  input: "^train/gradients/output/Wx_plus_b/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/output/Wx_plus_b/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "train/gradients/output/Wx_plus_b/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "train/gradients/output/Wx_plus_b/MatMul_grad/MatMul_1"
  input: "^train/gradients/output/Wx_plus_b/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/output/Wx_plus_b/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/mul_grad/Shape"
  op: "Shape"
  input: "dropout/dropout_1/div"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/mul_grad/Shape_1"
  op: "Shape"
  input: "dropout/dropout_1/Floor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/mul_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "train/gradients/dropout/dropout_1/mul_grad/Shape"
  input: "train/gradients/dropout/dropout_1/mul_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/mul_grad/mul"
  op: "Mul"
  input: "train/gradients/output/Wx_plus_b/MatMul_grad/tuple/control_dependency"
  input: "dropout/dropout_1/Floor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/mul_grad/Sum"
  op: "Sum"
  input: "train/gradients/dropout/dropout_1/mul_grad/mul"
  input: "train/gradients/dropout/dropout_1/mul_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/mul_grad/Reshape"
  op: "Reshape"
  input: "train/gradients/dropout/dropout_1/mul_grad/Sum"
  input: "train/gradients/dropout/dropout_1/mul_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/mul_grad/mul_1"
  op: "Mul"
  input: "dropout/dropout_1/div"
  input: "train/gradients/output/Wx_plus_b/MatMul_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/mul_grad/Sum_1"
  op: "Sum"
  input: "train/gradients/dropout/dropout_1/mul_grad/mul_1"
  input: "train/gradients/dropout/dropout_1/mul_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/mul_grad/Reshape_1"
  op: "Reshape"
  input: "train/gradients/dropout/dropout_1/mul_grad/Sum_1"
  input: "train/gradients/dropout/dropout_1/mul_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/mul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^train/gradients/dropout/dropout_1/mul_grad/Reshape"
  input: "^train/gradients/dropout/dropout_1/mul_grad/Reshape_1"
}
node {
  name: "train/gradients/dropout/dropout_1/mul_grad/tuple/control_dependency"
  op: "Identity"
  input: "train/gradients/dropout/dropout_1/mul_grad/Reshape"
  input: "^train/gradients/dropout/dropout_1/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/dropout/dropout_1/mul_grad/Reshape"
      }
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/mul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "train/gradients/dropout/dropout_1/mul_grad/Reshape_1"
  input: "^train/gradients/dropout/dropout_1/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/dropout/dropout_1/mul_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/Shape"
  op: "Shape"
  input: "hidden/activation"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/Shape_1"
  op: "Shape"
  input: "dropout/dropout"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "train/gradients/dropout/dropout_1/div_grad/Shape"
  input: "train/gradients/dropout/dropout_1/div_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/RealDiv"
  op: "RealDiv"
  input: "train/gradients/dropout/dropout_1/mul_grad/tuple/control_dependency"
  input: "dropout/dropout"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/Sum"
  op: "Sum"
  input: "train/gradients/dropout/dropout_1/div_grad/RealDiv"
  input: "train/gradients/dropout/dropout_1/div_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/Reshape"
  op: "Reshape"
  input: "train/gradients/dropout/dropout_1/div_grad/Sum"
  input: "train/gradients/dropout/dropout_1/div_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/Neg"
  op: "Neg"
  input: "hidden/activation"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/RealDiv_1"
  op: "RealDiv"
  input: "train/gradients/dropout/dropout_1/div_grad/Neg"
  input: "dropout/dropout"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/RealDiv_2"
  op: "RealDiv"
  input: "train/gradients/dropout/dropout_1/div_grad/RealDiv_1"
  input: "dropout/dropout"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/mul"
  op: "Mul"
  input: "train/gradients/dropout/dropout_1/mul_grad/tuple/control_dependency"
  input: "train/gradients/dropout/dropout_1/div_grad/RealDiv_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/Sum_1"
  op: "Sum"
  input: "train/gradients/dropout/dropout_1/div_grad/mul"
  input: "train/gradients/dropout/dropout_1/div_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/Reshape_1"
  op: "Reshape"
  input: "train/gradients/dropout/dropout_1/div_grad/Sum_1"
  input: "train/gradients/dropout/dropout_1/div_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/tuple/group_deps"
  op: "NoOp"
  input: "^train/gradients/dropout/dropout_1/div_grad/Reshape"
  input: "^train/gradients/dropout/dropout_1/div_grad/Reshape_1"
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/tuple/control_dependency"
  op: "Identity"
  input: "train/gradients/dropout/dropout_1/div_grad/Reshape"
  input: "^train/gradients/dropout/dropout_1/div_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/dropout/dropout_1/div_grad/Reshape"
      }
    }
  }
}
node {
  name: "train/gradients/dropout/dropout_1/div_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "train/gradients/dropout/dropout_1/div_grad/Reshape_1"
  input: "^train/gradients/dropout/dropout_1/div_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/dropout/dropout_1/div_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "train/gradients/hidden/activation_grad/ReluGrad"
  op: "ReluGrad"
  input: "train/gradients/dropout/dropout_1/div_grad/tuple/control_dependency"
  input: "hidden/activation"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/add_grad/Shape"
  op: "Shape"
  input: "hidden/Wx_plus_b/MatMul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/add_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 196
      }
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/add_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/Shape"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/add_grad/Sum"
  op: "Sum"
  input: "train/gradients/hidden/activation_grad/ReluGrad"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/add_grad/Reshape"
  op: "Reshape"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/Sum"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/add_grad/Sum_1"
  op: "Sum"
  input: "train/gradients/hidden/activation_grad/ReluGrad"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/add_grad/Reshape_1"
  op: "Reshape"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/Sum_1"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/add_grad/tuple/group_deps"
  op: "NoOp"
  input: "^train/gradients/hidden/Wx_plus_b/add_grad/Reshape"
  input: "^train/gradients/hidden/Wx_plus_b/add_grad/Reshape_1"
}
node {
  name: "train/gradients/hidden/Wx_plus_b/add_grad/tuple/control_dependency"
  op: "Identity"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/Reshape"
  input: "^train/gradients/hidden/Wx_plus_b/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/hidden/Wx_plus_b/add_grad/Reshape"
      }
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/add_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/Reshape_1"
  input: "^train/gradients/hidden/Wx_plus_b/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/hidden/Wx_plus_b/add_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/MatMul_grad/MatMul"
  op: "MatMul"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/tuple/control_dependency"
  input: "hidden/weights/Variable/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: true
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "input/x-input"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: true
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^train/gradients/hidden/Wx_plus_b/MatMul_grad/MatMul"
  input: "^train/gradients/hidden/Wx_plus_b/MatMul_grad/MatMul_1"
}
node {
  name: "train/gradients/hidden/Wx_plus_b/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "train/gradients/hidden/Wx_plus_b/MatMul_grad/MatMul"
  input: "^train/gradients/hidden/Wx_plus_b/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/hidden/Wx_plus_b/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "train/gradients/hidden/Wx_plus_b/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "train/gradients/hidden/Wx_plus_b/MatMul_grad/MatMul_1"
  input: "^train/gradients/hidden/Wx_plus_b/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@train/gradients/hidden/Wx_plus_b/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "train/beta1_power/initial_value"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.8999999761581421
      }
    }
  }
}
node {
  name: "train/beta1_power"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "train/beta1_power/Assign"
  op: "Assign"
  input: "train/beta1_power"
  input: "train/beta1_power/initial_value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "train/beta1_power/read"
  op: "Identity"
  input: "train/beta1_power"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
}
node {
  name: "train/beta2_power/initial_value"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.9990000128746033
      }
    }
  }
}
node {
  name: "train/beta2_power"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "train/beta2_power/Assign"
  op: "Assign"
  input: "train/beta2_power"
  input: "train/beta2_power/initial_value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "train/beta2_power/read"
  op: "Identity"
  input: "train/beta2_power"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
}
node {
  name: "hidden/weights/Variable/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/weights/Variable"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 256
          }
          dim {
            size: 196
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "hidden/weights/Variable/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/weights/Variable"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 256
        }
        dim {
          size: 196
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "hidden/weights/Variable/Adam/Assign"
  op: "Assign"
  input: "hidden/weights/Variable/Adam"
  input: "hidden/weights/Variable/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/weights/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "hidden/weights/Variable/Adam/read"
  op: "Identity"
  input: "hidden/weights/Variable/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/weights/Variable"
      }
    }
  }
}
node {
  name: "hidden/weights/Variable/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/weights/Variable"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 256
          }
          dim {
            size: 196
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "hidden/weights/Variable/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/weights/Variable"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 256
        }
        dim {
          size: 196
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "hidden/weights/Variable/Adam_1/Assign"
  op: "Assign"
  input: "hidden/weights/Variable/Adam_1"
  input: "hidden/weights/Variable/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/weights/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "hidden/weights/Variable/Adam_1/read"
  op: "Identity"
  input: "hidden/weights/Variable/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/weights/Variable"
      }
    }
  }
}
node {
  name: "hidden/biases/Variable/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 196
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "hidden/biases/Variable/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 196
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "hidden/biases/Variable/Adam/Assign"
  op: "Assign"
  input: "hidden/biases/Variable/Adam"
  input: "hidden/biases/Variable/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "hidden/biases/Variable/Adam/read"
  op: "Identity"
  input: "hidden/biases/Variable/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
}
node {
  name: "hidden/biases/Variable/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 196
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "hidden/biases/Variable/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 196
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "hidden/biases/Variable/Adam_1/Assign"
  op: "Assign"
  input: "hidden/biases/Variable/Adam_1"
  input: "hidden/biases/Variable/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "hidden/biases/Variable/Adam_1/read"
  op: "Identity"
  input: "hidden/biases/Variable/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
}
node {
  name: "output/weights/Variable/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights/Variable"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 196
          }
          dim {
            size: 14
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "output/weights/Variable/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights/Variable"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 196
        }
        dim {
          size: 14
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "output/weights/Variable/Adam/Assign"
  op: "Assign"
  input: "output/weights/Variable/Adam"
  input: "output/weights/Variable/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "output/weights/Variable/Adam/read"
  op: "Identity"
  input: "output/weights/Variable/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights/Variable"
      }
    }
  }
}
node {
  name: "output/weights/Variable/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights/Variable"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 196
          }
          dim {
            size: 14
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "output/weights/Variable/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights/Variable"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 196
        }
        dim {
          size: 14
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "output/weights/Variable/Adam_1/Assign"
  op: "Assign"
  input: "output/weights/Variable/Adam_1"
  input: "output/weights/Variable/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "output/weights/Variable/Adam_1/read"
  op: "Identity"
  input: "output/weights/Variable/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights/Variable"
      }
    }
  }
}
node {
  name: "output/biases/Variable/Adam/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases/Variable"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 14
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "output/biases/Variable/Adam"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases/Variable"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 14
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "output/biases/Variable/Adam/Assign"
  op: "Assign"
  input: "output/biases/Variable/Adam"
  input: "output/biases/Variable/Adam/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "output/biases/Variable/Adam/read"
  op: "Identity"
  input: "output/biases/Variable/Adam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases/Variable"
      }
    }
  }
}
node {
  name: "output/biases/Variable/Adam_1/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases/Variable"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 14
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "output/biases/Variable/Adam_1"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases/Variable"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 14
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "output/biases/Variable/Adam_1/Assign"
  op: "Assign"
  input: "output/biases/Variable/Adam_1"
  input: "output/biases/Variable/Adam_1/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "output/biases/Variable/Adam_1/read"
  op: "Identity"
  input: "output/biases/Variable/Adam_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases/Variable"
      }
    }
  }
}
node {
  name: "train/Adam/learning_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0010000000474974513
      }
    }
  }
}
node {
  name: "train/Adam/beta1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.8999999761581421
      }
    }
  }
}
node {
  name: "train/Adam/beta2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.9990000128746033
      }
    }
  }
}
node {
  name: "train/Adam/epsilon"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999993922529e-09
      }
    }
  }
}
node {
  name: "train/Adam/update_hidden/weights/Variable/ApplyAdam"
  op: "ApplyAdam"
  input: "hidden/weights/Variable"
  input: "hidden/weights/Variable/Adam"
  input: "hidden/weights/Variable/Adam_1"
  input: "train/beta1_power/read"
  input: "train/beta2_power/read"
  input: "train/Adam/learning_rate"
  input: "train/Adam/beta1"
  input: "train/Adam/beta2"
  input: "train/Adam/epsilon"
  input: "train/gradients/hidden/Wx_plus_b/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/weights/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train/Adam/update_hidden/biases/Variable/ApplyAdam"
  op: "ApplyAdam"
  input: "hidden/biases/Variable"
  input: "hidden/biases/Variable/Adam"
  input: "hidden/biases/Variable/Adam_1"
  input: "train/beta1_power/read"
  input: "train/beta2_power/read"
  input: "train/Adam/learning_rate"
  input: "train/Adam/beta1"
  input: "train/Adam/beta2"
  input: "train/Adam/epsilon"
  input: "train/gradients/hidden/Wx_plus_b/add_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train/Adam/update_output/weights/Variable/ApplyAdam"
  op: "ApplyAdam"
  input: "output/weights/Variable"
  input: "output/weights/Variable/Adam"
  input: "output/weights/Variable/Adam_1"
  input: "train/beta1_power/read"
  input: "train/beta2_power/read"
  input: "train/Adam/learning_rate"
  input: "train/Adam/beta1"
  input: "train/Adam/beta2"
  input: "train/Adam/epsilon"
  input: "train/gradients/output/Wx_plus_b/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train/Adam/update_output/biases/Variable/ApplyAdam"
  op: "ApplyAdam"
  input: "output/biases/Variable"
  input: "output/biases/Variable/Adam"
  input: "output/biases/Variable/Adam_1"
  input: "train/beta1_power/read"
  input: "train/beta2_power/read"
  input: "train/Adam/learning_rate"
  input: "train/Adam/beta1"
  input: "train/Adam/beta2"
  input: "train/Adam/epsilon"
  input: "train/gradients/output/Wx_plus_b/add_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "train/Adam/mul"
  op: "Mul"
  input: "train/beta1_power/read"
  input: "train/Adam/beta1"
  input: "^train/Adam/update_hidden/weights/Variable/ApplyAdam"
  input: "^train/Adam/update_hidden/biases/Variable/ApplyAdam"
  input: "^train/Adam/update_output/weights/Variable/ApplyAdam"
  input: "^train/Adam/update_output/biases/Variable/ApplyAdam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
}
node {
  name: "train/Adam/Assign"
  op: "Assign"
  input: "train/beta1_power"
  input: "train/Adam/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "train/Adam/mul_1"
  op: "Mul"
  input: "train/beta2_power/read"
  input: "train/Adam/beta2"
  input: "^train/Adam/update_hidden/weights/Variable/ApplyAdam"
  input: "^train/Adam/update_hidden/biases/Variable/ApplyAdam"
  input: "^train/Adam/update_output/weights/Variable/ApplyAdam"
  input: "^train/Adam/update_output/biases/Variable/ApplyAdam"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
}
node {
  name: "train/Adam/Assign_1"
  op: "Assign"
  input: "train/beta2_power"
  input: "train/Adam/mul_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@hidden/biases/Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "train/Adam"
  op: "NoOp"
  input: "^train/Adam/update_hidden/weights/Variable/ApplyAdam"
  input: "^train/Adam/update_hidden/biases/Variable/ApplyAdam"
  input: "^train/Adam/update_output/weights/Variable/ApplyAdam"
  input: "^train/Adam/update_output/biases/Variable/ApplyAdam"
  input: "^train/Adam/Assign"
  input: "^train/Adam/Assign_1"
}
node {
  name: "evaluation/ArgMax/dimension"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/ArgMax"
  op: "ArgMax"
  input: "prediction/prediction"
  input: "evaluation/ArgMax/dimension"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "output_type"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/ArgMax_1/dimension"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/ArgMax_1"
  op: "ArgMax"
  input: "input/y-input"
  input: "evaluation/ArgMax_1/dimension"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "output_type"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/accuracy/correct_prediction/Equal"
  op: "Equal"
  input: "evaluation/ArgMax_1"
  input: "evaluation/ArgMax"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/Cast"
  op: "Cast"
  input: "evaluation/accuracy/correct_prediction/Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/Mean"
  op: "Mean"
  input: "evaluation/accuracy/accuracy/Cast"
  input: "evaluation/accuracy/accuracy/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_DOUBLE
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_DOUBLE
        tensor_shape {
          dim {
            size: 14
          }
          dim {
            size: 14
          }
        }
        double_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_DOUBLE
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 14
        }
        dim {
          size: 14
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix/Assign"
  op: "Assign"
  input: "evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix"
  input: "evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_DOUBLE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix/read"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix"
  attr {
    key: "T"
    value {
      type: DT_DOUBLE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 14
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2"
  op: "Cast"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2/x"
  attr {
    key: "DstT"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/LessEqual"
  op: "LessEqual"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/Const"
  input: "evaluation/ArgMax_1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/All"
  op: "All"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/LessEqual"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Const"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`labels` contains negative values"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x >= 0 did not hold element-wise:"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/Const_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "x (evaluation/ArgMax_1:0) = "
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Switch"
  op: "Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/All"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_t"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_f"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/pred_id"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/NoOp"
  op: "NoOp"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_t"
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/control_dependency"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_t"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/NoOp"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_t"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/data_0"
  op: "Const"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`labels` contains negative values"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/data_1"
  op: "Const"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x >= 0 did not hold element-wise:"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/data_2"
  op: "Const"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "x (evaluation/ArgMax_1:0) = "
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/Switch"
  op: "Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/All"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/All"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/Switch_1"
  op: "Switch"
  input: "evaluation/ArgMax_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_1"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert"
  op: "Assert"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/data_0"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/data_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/data_2"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/Switch_1"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 3
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/control_dependency_1"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_f"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_f"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Merge"
  op: "Merge"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/control_dependency_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/control_dependency"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency"
  op: "Identity"
  input: "evaluation/ArgMax_1"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Merge"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_1"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/LessEqual"
  op: "LessEqual"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/Const"
  input: "evaluation/ArgMax"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/All"
  op: "All"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/LessEqual"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Const"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`predictions` contains negative values"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x >= 0 did not hold element-wise:"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/Const_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "x (evaluation/ArgMax:0) = "
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Switch"
  op: "Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/All"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_t"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_f"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/pred_id"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/NoOp"
  op: "NoOp"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_t"
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/control_dependency"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_t"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/NoOp"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_t"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/data_0"
  op: "Const"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`predictions` contains negative values"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/data_1"
  op: "Const"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x >= 0 did not hold element-wise:"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/data_2"
  op: "Const"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "x (evaluation/ArgMax:0) = "
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/Switch"
  op: "Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/All"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/All"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/Switch_1"
  op: "Switch"
  input: "evaluation/ArgMax"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert"
  op: "Assert"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/data_0"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/data_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/data_2"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/Switch_1"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 3
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/control_dependency_1"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_f"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_f"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Merge"
  op: "Merge"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/control_dependency_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/control_dependency"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency_1"
  op: "Identity"
  input: "evaluation/ArgMax"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Merge"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Less"
  op: "Less"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/All"
  op: "All"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Less"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Const"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`labels` out of bound"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x < y did not hold element-wise:x (evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency:0) = "
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/Const_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "y (evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2:0) = "
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Switch"
  op: "Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/All"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/switch_t"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/switch_f"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/pred_id"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/NoOp"
  op: "NoOp"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/switch_t"
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/control_dependency"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/switch_t"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/NoOp"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/switch_t"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert/data_0"
  op: "Const"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`labels` out of bound"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert/data_1"
  op: "Const"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x < y did not hold element-wise:x (evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency:0) = "
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert/data_3"
  op: "Const"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "y (evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2:0) = "
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert/Switch"
  op: "Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/All"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/All"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert/Switch_1"
  op: "Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_1"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert/Switch_2"
  op: "Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert"
  op: "Assert"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert/Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert/data_0"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert/data_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert/Switch_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert/data_3"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert/Switch_2"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
        type: DT_STRING
        type: DT_INT64
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 3
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/control_dependency_1"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/switch_f"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Assert"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/switch_f"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Merge"
  op: "Merge"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/control_dependency_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/control_dependency"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency_2"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less/Assert/AssertGuard/Merge"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_1"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Less"
  op: "Less"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/All"
  op: "All"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Less"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Const"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`predictions` out of bound"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x < y did not hold element-wise:x (evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency_1:0) = "
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/Const_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "y (evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2:0) = "
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Switch"
  op: "Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/All"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_t"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_f"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/pred_id"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/NoOp"
  op: "NoOp"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_t"
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/control_dependency"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_t"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/NoOp"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_t"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/data_0"
  op: "Const"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`predictions` out of bound"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/data_1"
  op: "Const"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x < y did not hold element-wise:x (evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency_1:0) = "
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/data_3"
  op: "Const"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "y (evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2:0) = "
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/Switch"
  op: "Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/All"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/All"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/Switch_1"
  op: "Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/Switch_2"
  op: "Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert"
  op: "Assert"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/Switch"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/data_0"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/data_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/Switch_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/data_3"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/Switch_2"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
        type: DT_STRING
        type: DT_INT64
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 3
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/control_dependency_1"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_f"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_f"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Merge"
  op: "Merge"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/control_dependency_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/control_dependency"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency_3"
  op: "Identity"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency_1"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/assert_less_1/Assert/AssertGuard/Merge"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax"
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/stack"
  op: "Pack"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ToInt64_2"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/stack_1"
  op: "Pack"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency_2"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency_3"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/Rank"
  op: "Rank"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/stack_1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/sub/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/sub"
  op: "Sub"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/Rank"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/sub/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/Range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/Range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/Range"
  op: "Range"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/Range/start"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/Rank"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/Range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/sub_1"
  op: "Sub"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/sub"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/Range"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose"
  op: "Transpose"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/stack_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose/sub_1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tperm"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/ones_like/Shape"
  op: "Shape"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/control_dependency_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/ones_like/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_DOUBLE
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_DOUBLE
        tensor_shape {
        }
        double_val: 1.0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/ones_like"
  op: "Fill"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/ones_like/Shape"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/ones_like/Const"
  attr {
    key: "T"
    value {
      type: DT_DOUBLE
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/ToInt32"
  op: "Cast"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/stack"
  attr {
    key: "DstT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/zeros/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_DOUBLE
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_DOUBLE
        tensor_shape {
        }
        double_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/zeros"
  op: "Fill"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/ToInt32"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_DOUBLE
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/SparseTensorDenseAdd"
  op: "SparseTensorDenseAdd"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/transpose"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/ones_like"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/stack"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/zeros"
  attr {
    key: "T"
    value {
      type: DT_DOUBLE
    }
  }
  attr {
    key: "Tindices"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix"
  input: "evaluation/accuracy/accuracy/mean_accuracy/confusion_matrix/SparseTensorDenseAdd"
  attr {
    key: "T"
    value {
      type: DT_DOUBLE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/Sum"
  op: "Sum"
  input: "evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix/read"
  input: "evaluation/accuracy/accuracy/mean_accuracy/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_DOUBLE
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/ToFloat"
  op: "Cast"
  input: "evaluation/accuracy/accuracy/mean_accuracy/Sum"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_DOUBLE
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/DiagPart"
  op: "DiagPart"
  input: "evaluation/accuracy/accuracy/mean_accuracy/total_confusion_matrix/read"
  attr {
    key: "T"
    value {
      type: DT_DOUBLE
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/ToFloat_1"
  op: "Cast"
  input: "evaluation/accuracy/accuracy/mean_accuracy/DiagPart"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_DOUBLE
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/Greater"
  op: "Greater"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ToFloat"
  input: "evaluation/accuracy/accuracy/mean_accuracy/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/ones_like/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 14
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/ones_like/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/ones_like"
  op: "Fill"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ones_like/Shape"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ones_like/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/Select"
  op: "Select"
  input: "evaluation/accuracy/accuracy/mean_accuracy/Greater"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ToFloat"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ones_like"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/div"
  op: "RealDiv"
  input: "evaluation/accuracy/accuracy/mean_accuracy/ToFloat_1"
  input: "evaluation/accuracy/accuracy/mean_accuracy/Select"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/accuracy/accuracy/mean_accuracy/mean_accuracy"
  op: "Mean"
  input: "evaluation/accuracy/accuracy/mean_accuracy/div"
  input: "evaluation/accuracy/accuracy/mean_accuracy/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/mean_accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/mean_accuracy"
      }
    }
  }
}
node {
  name: "evaluation/mean_accuracy"
  op: "ScalarSummary"
  input: "evaluation/mean_accuracy/tags"
  input: "evaluation/accuracy/accuracy/mean_accuracy/mean_accuracy"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/accuracy_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/accuracy_1"
      }
    }
  }
}
node {
  name: "evaluation/accuracy_1"
  op: "ScalarSummary"
  input: "evaluation/accuracy_1/tags"
  input: "evaluation/accuracy/accuracy/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/group_deps"
  op: "NoOp"
  input: "^evaluation/accuracy/accuracy/Mean"
  input: "^evaluation/accuracy/accuracy/mean_accuracy/AssignAdd"
}
node {
  name: "evaluation/confusion/ArgMax/dimension"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/confusion/ArgMax"
  op: "ArgMax"
  input: "prediction/prediction"
  input: "evaluation/confusion/ArgMax/dimension"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "output_type"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/confusion/ArgMax_1/dimension"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/confusion/ArgMax_1"
  op: "ArgMax"
  input: "input/y-input"
  input: "evaluation/confusion/ArgMax_1/dimension"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "output_type"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 0
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/LessEqual"
  op: "LessEqual"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/Const"
  input: "evaluation/confusion/ArgMax_1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/All"
  op: "All"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/LessEqual"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Const"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`labels` contains negative values"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x >= 0 did not hold element-wise:"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/Const_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "x (evaluation/confusion/ArgMax_1:0) = "
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Switch"
  op: "Switch"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/All"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_t"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_f"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/pred_id"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/NoOp"
  op: "NoOp"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_t"
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/control_dependency"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_t"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/NoOp"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_t"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/data_0"
  op: "Const"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`labels` contains negative values"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/data_1"
  op: "Const"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x >= 0 did not hold element-wise:"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/data_2"
  op: "Const"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "x (evaluation/confusion/ArgMax_1:0) = "
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/Switch"
  op: "Switch"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/All"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/All"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/Switch_1"
  op: "Switch"
  input: "evaluation/confusion/ArgMax_1"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/ArgMax_1"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert"
  op: "Assert"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/Switch"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/data_0"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/data_1"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/data_2"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert/Switch_1"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 3
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/control_dependency_1"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_f"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Assert"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/switch_f"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Merge"
  op: "Merge"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/control_dependency_1"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/control_dependency"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/control_dependency"
  op: "Identity"
  input: "evaluation/confusion/ArgMax_1"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative/assert_less_equal/Assert/AssertGuard/Merge"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/ArgMax_1"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 0
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/LessEqual"
  op: "LessEqual"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/Const"
  input: "evaluation/confusion/ArgMax"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/All"
  op: "All"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/LessEqual"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Const"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`predictions` contains negative values"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x >= 0 did not hold element-wise:"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/Const_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "x (evaluation/confusion/ArgMax:0) = "
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Switch"
  op: "Switch"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/All"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_t"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_f"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/pred_id"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/NoOp"
  op: "NoOp"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_t"
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/control_dependency"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_t"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/NoOp"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_t"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/data_0"
  op: "Const"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`predictions` contains negative values"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/data_1"
  op: "Const"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x >= 0 did not hold element-wise:"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/data_2"
  op: "Const"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "x (evaluation/confusion/ArgMax:0) = "
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/Switch"
  op: "Switch"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/All"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/All"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/Switch_1"
  op: "Switch"
  input: "evaluation/confusion/ArgMax"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/ArgMax"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert"
  op: "Assert"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/Switch"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/data_0"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/data_1"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/data_2"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert/Switch_1"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 3
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/control_dependency_1"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_f"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Assert"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/switch_f"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Merge"
  op: "Merge"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/control_dependency_1"
  input: "evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/control_dependency"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/control_dependency_1"
  op: "Identity"
  input: "evaluation/confusion/ArgMax"
  input: "^evaluation/confusion/confusion_matrix/assert_non_negative_1/assert_less_equal/Assert/AssertGuard/Merge"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/ArgMax"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/Cast_2/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 14
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/Cast_2"
  op: "Cast"
  input: "evaluation/confusion/confusion_matrix/Cast_2/x"
  attr {
    key: "DstT"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Less"
  op: "Less"
  input: "evaluation/confusion/confusion_matrix/control_dependency"
  input: "evaluation/confusion/confusion_matrix/Cast_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/All"
  op: "All"
  input: "evaluation/confusion/confusion_matrix/assert_less/Less"
  input: "evaluation/confusion/confusion_matrix/assert_less/Const"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`labels` out of bound"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x < y did not hold element-wise:x (evaluation/confusion/confusion_matrix/control_dependency:0) = "
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/Const_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "y (evaluation/confusion/confusion_matrix/Cast_2:0) = "
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Switch"
  op: "Switch"
  input: "evaluation/confusion/confusion_matrix/assert_less/All"
  input: "evaluation/confusion/confusion_matrix/assert_less/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/switch_t"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/switch_f"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/pred_id"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_less/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/NoOp"
  op: "NoOp"
  input: "^evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/switch_t"
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/control_dependency"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/switch_t"
  input: "^evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/NoOp"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/switch_t"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert/data_0"
  op: "Const"
  input: "^evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`labels` out of bound"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert/data_1"
  op: "Const"
  input: "^evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x < y did not hold element-wise:x (evaluation/confusion/confusion_matrix/control_dependency:0) = "
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert/data_3"
  op: "Const"
  input: "^evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "y (evaluation/confusion/confusion_matrix/Cast_2:0) = "
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert/Switch"
  op: "Switch"
  input: "evaluation/confusion/confusion_matrix/assert_less/All"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/assert_less/All"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert/Switch_1"
  op: "Switch"
  input: "evaluation/confusion/confusion_matrix/control_dependency"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/ArgMax_1"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert/Switch_2"
  op: "Switch"
  input: "evaluation/confusion/confusion_matrix/Cast_2"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/Cast_2"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert"
  op: "Assert"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert/Switch"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert/data_0"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert/data_1"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert/Switch_1"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert/data_3"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert/Switch_2"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
        type: DT_STRING
        type: DT_INT64
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 3
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/control_dependency_1"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/switch_f"
  input: "^evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Assert"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/switch_f"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Merge"
  op: "Merge"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/control_dependency_1"
  input: "evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/control_dependency"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/control_dependency_2"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/control_dependency"
  input: "^evaluation/confusion/confusion_matrix/assert_less/Assert/AssertGuard/Merge"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/ArgMax_1"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Less"
  op: "Less"
  input: "evaluation/confusion/confusion_matrix/control_dependency_1"
  input: "evaluation/confusion/confusion_matrix/Cast_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/All"
  op: "All"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Less"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Const"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`predictions` out of bound"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x < y did not hold element-wise:x (evaluation/confusion/confusion_matrix/control_dependency_1:0) = "
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/Const_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "y (evaluation/confusion/confusion_matrix/Cast_2:0) = "
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Switch"
  op: "Switch"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/All"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_t"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_f"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Switch"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/pred_id"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/All"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/NoOp"
  op: "NoOp"
  input: "^evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_t"
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/control_dependency"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_t"
  input: "^evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/NoOp"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_t"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/data_0"
  op: "Const"
  input: "^evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "`predictions` out of bound"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/data_1"
  op: "Const"
  input: "^evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Condition x < y did not hold element-wise:x (evaluation/confusion/confusion_matrix/control_dependency_1:0) = "
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/data_3"
  op: "Const"
  input: "^evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_f"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "y (evaluation/confusion/confusion_matrix/Cast_2:0) = "
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/Switch"
  op: "Switch"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/All"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/assert_less_1/All"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/Switch_1"
  op: "Switch"
  input: "evaluation/confusion/confusion_matrix/control_dependency_1"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/ArgMax"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/Switch_2"
  op: "Switch"
  input: "evaluation/confusion/confusion_matrix/Cast_2"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/pred_id"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/Cast_2"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert"
  op: "Assert"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/Switch"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/data_0"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/data_1"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/Switch_1"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/data_3"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert/Switch_2"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
        type: DT_STRING
        type: DT_INT64
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 3
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/control_dependency_1"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_f"
  input: "^evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Assert"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/switch_f"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Merge"
  op: "Merge"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/control_dependency_1"
  input: "evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/control_dependency"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/control_dependency_3"
  op: "Identity"
  input: "evaluation/confusion/confusion_matrix/control_dependency_1"
  input: "^evaluation/confusion/confusion_matrix/assert_less_1/Assert/AssertGuard/Merge"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/ArgMax"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\016\000\000\000\016\000\000\000"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/stack_1"
  op: "Pack"
  input: "evaluation/confusion/confusion_matrix/control_dependency_2"
  input: "evaluation/confusion/confusion_matrix/control_dependency_3"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/transpose/Rank"
  op: "Rank"
  input: "evaluation/confusion/confusion_matrix/stack_1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/transpose/sub/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/transpose/sub"
  op: "Sub"
  input: "evaluation/confusion/confusion_matrix/transpose/Rank"
  input: "evaluation/confusion/confusion_matrix/transpose/sub/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/transpose/Range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/transpose/Range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/transpose/Range"
  op: "Range"
  input: "evaluation/confusion/confusion_matrix/transpose/Range/start"
  input: "evaluation/confusion/confusion_matrix/transpose/Rank"
  input: "evaluation/confusion/confusion_matrix/transpose/Range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/transpose/sub_1"
  op: "Sub"
  input: "evaluation/confusion/confusion_matrix/transpose/sub"
  input: "evaluation/confusion/confusion_matrix/transpose/Range"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/transpose"
  op: "Transpose"
  input: "evaluation/confusion/confusion_matrix/stack_1"
  input: "evaluation/confusion/confusion_matrix/transpose/sub_1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tperm"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/ones_like/Shape"
  op: "Shape"
  input: "evaluation/confusion/confusion_matrix/control_dependency_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/ones_like/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/ones_like"
  op: "Fill"
  input: "evaluation/confusion/confusion_matrix/ones_like/Shape"
  input: "evaluation/confusion/confusion_matrix/ones_like/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/ToInt64"
  op: "Cast"
  input: "evaluation/confusion/confusion_matrix/stack"
  attr {
    key: "DstT"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/zeros/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/zeros"
  op: "Fill"
  input: "evaluation/confusion/confusion_matrix/stack"
  input: "evaluation/confusion/confusion_matrix/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/confusion_matrix/SparseTensorDenseAdd"
  op: "SparseTensorDenseAdd"
  input: "evaluation/confusion/confusion_matrix/transpose"
  input: "evaluation/confusion/confusion_matrix/ones_like"
  input: "evaluation/confusion/confusion_matrix/ToInt64"
  input: "evaluation/confusion/confusion_matrix/zeros"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tindices"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/confusion/zeros"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 14
          }
          dim {
            size: 14
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion"
  op: "VariableV2"
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 14
        }
        dim {
          size: 14
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/confusion/confusion/Assign"
  op: "Assign"
  input: "evaluation/confusion/confusion"
  input: "evaluation/confusion/zeros"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/confusion/confusion/read"
  op: "Identity"
  input: "evaluation/confusion/confusion"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion"
      }
    }
  }
}
node {
  name: "evaluation/confusion/add"
  op: "Add"
  input: "evaluation/confusion/confusion/read"
  input: "evaluation/confusion/confusion_matrix/SparseTensorDenseAdd"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/MatrixSetDiag/diagonal"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 14
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "evaluation/confusion/MatrixSetDiag"
  op: "MatrixSetDiag"
  input: "evaluation/confusion/add"
  input: "evaluation/confusion/MatrixSetDiag/diagonal"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/Assign"
  op: "Assign"
  input: "evaluation/confusion/confusion"
  input: "evaluation/confusion/MatrixSetDiag"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/confusion/confusion"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/confusion/MatrixSetDiag_1/diagonal"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 14
          }
        }
        tensor_content: "\377\000\000\000\377\000\000\000\377\000\000\000\377\000\000\000\377\000\000\000\377\000\000\000\377\000\000\000\377\000\000\000\377\000\000\000\377\000\000\000\377\000\000\000\377\000\000\000\377\000\000\000\377\000\000\000"
      }
    }
  }
}
node {
  name: "evaluation/confusion/MatrixSetDiag_1"
  op: "MatrixSetDiag"
  input: "evaluation/confusion/confusion/read"
  input: "evaluation/confusion/MatrixSetDiag_1/diagonal"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/Cast"
  op: "Cast"
  input: "evaluation/confusion/MatrixSetDiag_1"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\001\000\000\000\016\000\000\000\016\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "evaluation/confusion/Reshape"
  op: "Reshape"
  input: "evaluation/confusion/Cast"
  input: "evaluation/confusion/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/confusion/confusion_1/tag"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/confusion/confusion_1"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion_1"
  op: "ImageSummary"
  input: "evaluation/confusion/confusion_1/tag"
  input: "evaluation/confusion/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "bad_color"
    value {
      tensor {
        dtype: DT_UINT8
        tensor_shape {
          dim {
            size: 4
          }
        }
        int_val: 255
        int_val: 0
        int_val: 0
        int_val: 255
      }
    }
  }
  attr {
    key: "max_images"
    value {
      i: 3
    }
  }
}
node {
  name: "evaluation/confusion/AsString"
  op: "AsString"
  input: "evaluation/confusion/confusion/read"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "fill"
    value {
      s: ""
    }
  }
  attr {
    key: "precision"
    value {
      i: -1
    }
  }
  attr {
    key: "scientific"
    value {
      b: false
    }
  }
  attr {
    key: "shortest"
    value {
      b: false
    }
  }
  attr {
    key: "width"
    value {
      i: -1
    }
  }
}
node {
  name: "evaluation/confusion/confusion-matrix/tag"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/confusion/confusion-matrix"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion-matrix/serialized_summary_metadata"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "\n\006\n\004text"
      }
    }
  }
}
node {
  name: "evaluation/confusion/confusion-matrix"
  op: "TensorSummaryV2"
  input: "evaluation/confusion/confusion-matrix/tag"
  input: "evaluation/confusion/AsString"
  input: "evaluation/confusion/confusion-matrix/serialized_summary_metadata"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
}
node {
  name: "evaluation/ArgMax_2/dimension"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/ArgMax_2"
  op: "ArgMax"
  input: "prediction/prediction"
  input: "evaluation/ArgMax_2/dimension"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "output_type"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/ArgMax_3/dimension"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/ArgMax_3"
  op: "ArgMax"
  input: "input/y-input"
  input: "evaluation/ArgMax_3/dimension"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "output_type"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/unknown/map/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/unknown/map/Shape"
  input: "evaluation/class/unknown/map/strided_slice/stack"
  input: "evaluation/class/unknown/map/strided_slice/stack_1"
  input: "evaluation/class/unknown/map/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/unknown/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/unknown/map/TensorArrayUnstack/Shape"
  input: "evaluation/class/unknown/map/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/unknown/map/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/unknown/map/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/unknown/map/TensorArrayUnstack/range/start"
  input: "evaluation/class/unknown/map/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/unknown/map/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/unknown/map/TensorArray"
  input: "evaluation/class/unknown/map/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_3"
  input: "evaluation/class/unknown/map/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_3"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/unknown/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Enter"
  op: "Enter"
  input: "evaluation/class/unknown/map/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/unknown/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/unknown/map/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/unknown/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Merge"
  op: "Merge"
  input: "evaluation/class/unknown/map/while/Enter"
  input: "evaluation/class/unknown/map/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/unknown/map/while/Enter_1"
  input: "evaluation/class/unknown/map/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/unknown/map/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/unknown/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Less"
  op: "Less"
  input: "evaluation/class/unknown/map/while/Merge"
  input: "evaluation/class/unknown/map/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/unknown/map/while/Less"
}
node {
  name: "evaluation/class/unknown/map/while/Switch"
  op: "Switch"
  input: "evaluation/class/unknown/map/while/Merge"
  input: "evaluation/class/unknown/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/unknown/map/while/Merge_1"
  input: "evaluation/class/unknown/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Identity"
  op: "Identity"
  input: "evaluation/class/unknown/map/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/unknown/map/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/unknown/map/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/unknown/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/unknown/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/unknown/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/unknown/map/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/unknown/map/while/Identity"
  input: "evaluation/class/unknown/map/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/unknown/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Equal"
  op: "Equal"
  input: "evaluation/class/unknown/map/while/TensorArrayReadV3"
  input: "evaluation/class/unknown/map/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/unknown/map/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/unknown/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/unknown/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/unknown/map/while/Identity"
  input: "evaluation/class/unknown/map/while/Equal"
  input: "evaluation/class/unknown/map/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/add/y"
  op: "Const"
  input: "^evaluation/class/unknown/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/add"
  op: "Add"
  input: "evaluation/class/unknown/map/while/Identity"
  input: "evaluation/class/unknown/map/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/unknown/map/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/unknown/map/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Exit"
  op: "Exit"
  input: "evaluation/class/unknown/map/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/unknown/map/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/unknown/map/TensorArray_1"
  input: "evaluation/class/unknown/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/unknown/map/TensorArrayStack/range/start"
  input: "evaluation/class/unknown/map/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/unknown/map/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/unknown/map/TensorArray_1"
  input: "evaluation/class/unknown/map/TensorArrayStack/range"
  input: "evaluation/class/unknown/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/unknown/map_1/Shape"
  input: "evaluation/class/unknown/map_1/strided_slice/stack"
  input: "evaluation/class/unknown/map_1/strided_slice/stack_1"
  input: "evaluation/class/unknown/map_1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/unknown/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/unknown/map_1/TensorArrayUnstack/Shape"
  input: "evaluation/class/unknown/map_1/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/unknown/map_1/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/unknown/map_1/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/unknown/map_1/TensorArrayUnstack/range/start"
  input: "evaluation/class/unknown/map_1/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/unknown/map_1/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/unknown/map_1/TensorArray"
  input: "evaluation/class/unknown/map_1/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_2"
  input: "evaluation/class/unknown/map_1/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_2"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/unknown/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Enter"
  op: "Enter"
  input: "evaluation/class/unknown/map_1/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/unknown/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/unknown/map_1/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/unknown/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Merge"
  op: "Merge"
  input: "evaluation/class/unknown/map_1/while/Enter"
  input: "evaluation/class/unknown/map_1/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/unknown/map_1/while/Enter_1"
  input: "evaluation/class/unknown/map_1/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/unknown/map_1/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/unknown/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Less"
  op: "Less"
  input: "evaluation/class/unknown/map_1/while/Merge"
  input: "evaluation/class/unknown/map_1/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/unknown/map_1/while/Less"
}
node {
  name: "evaluation/class/unknown/map_1/while/Switch"
  op: "Switch"
  input: "evaluation/class/unknown/map_1/while/Merge"
  input: "evaluation/class/unknown/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map_1/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/unknown/map_1/while/Merge_1"
  input: "evaluation/class/unknown/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map_1/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Identity"
  op: "Identity"
  input: "evaluation/class/unknown/map_1/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/unknown/map_1/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/unknown/map_1/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/unknown/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/unknown/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/unknown/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/unknown/map_1/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/unknown/map_1/while/Identity"
  input: "evaluation/class/unknown/map_1/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/unknown/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Equal"
  op: "Equal"
  input: "evaluation/class/unknown/map_1/while/TensorArrayReadV3"
  input: "evaluation/class/unknown/map_1/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/unknown/map_1/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map_1/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/unknown/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/unknown/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/unknown/map_1/while/Identity"
  input: "evaluation/class/unknown/map_1/while/Equal"
  input: "evaluation/class/unknown/map_1/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map_1/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/add/y"
  op: "Const"
  input: "^evaluation/class/unknown/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/add"
  op: "Add"
  input: "evaluation/class/unknown/map_1/while/Identity"
  input: "evaluation/class/unknown/map_1/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/unknown/map_1/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/unknown/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Exit"
  op: "Exit"
  input: "evaluation/class/unknown/map_1/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/unknown/map_1/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/unknown/map_1/TensorArray_1"
  input: "evaluation/class/unknown/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/unknown/map_1/TensorArrayStack/range/start"
  input: "evaluation/class/unknown/map_1/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/unknown/map_1/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/map_1/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/unknown/map_1/TensorArray_1"
  input: "evaluation/class/unknown/map_1/TensorArrayStack/range"
  input: "evaluation/class/unknown/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/unknown/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/unknown/precision/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/unknown/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/unknown/precision/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/unknown/precision/true_positives/Equal"
  input: "evaluation/class/unknown/precision/true_positives/Equal_1"
}
node {
  name: "evaluation/class/unknown/precision/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/unknown/precision/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/unknown/precision/true_positives/count"
  input: "evaluation/class/unknown/precision/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/unknown/precision/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/precision/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/unknown/precision/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/unknown/precision/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/unknown/precision/true_positives/ToFloat"
  input: "evaluation/class/unknown/precision/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/unknown/precision/true_positives/count"
  input: "evaluation/class/unknown/precision/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/Equal"
  op: "Equal"
  input: "evaluation/class/unknown/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/unknown/precision/false_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/unknown/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/unknown/precision/false_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/unknown/precision/false_positives/Equal"
  input: "evaluation/class/unknown/precision/false_positives/Equal_1"
}
node {
  name: "evaluation/class/unknown/precision/false_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/unknown/precision/false_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/unknown/precision/false_positives/count"
  input: "evaluation/class/unknown/precision/false_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/count/read"
  op: "Identity"
  input: "evaluation/class/unknown/precision/false_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/precision/false_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/unknown/precision/false_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/Identity"
  op: "Identity"
  input: "evaluation/class/unknown/precision/false_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/Sum"
  op: "Sum"
  input: "evaluation/class/unknown/precision/false_positives/ToFloat"
  input: "evaluation/class/unknown/precision/false_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/false_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/unknown/precision/false_positives/count"
  input: "evaluation/class/unknown/precision/false_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/add"
  op: "Add"
  input: "evaluation/class/unknown/precision/true_positives/Identity"
  input: "evaluation/class/unknown/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/Greater"
  op: "Greater"
  input: "evaluation/class/unknown/precision/add"
  input: "evaluation/class/unknown/precision/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/add_1"
  op: "Add"
  input: "evaluation/class/unknown/precision/true_positives/Identity"
  input: "evaluation/class/unknown/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/div"
  op: "RealDiv"
  input: "evaluation/class/unknown/precision/true_positives/Identity"
  input: "evaluation/class/unknown/precision/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/value"
  op: "Select"
  input: "evaluation/class/unknown/precision/Greater"
  input: "evaluation/class/unknown/precision/div"
  input: "evaluation/class/unknown/precision/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/add_2"
  op: "Add"
  input: "evaluation/class/unknown/precision/true_positives/AssignAdd"
  input: "evaluation/class/unknown/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/Greater_1"
  op: "Greater"
  input: "evaluation/class/unknown/precision/add_2"
  input: "evaluation/class/unknown/precision/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/add_3"
  op: "Add"
  input: "evaluation/class/unknown/precision/true_positives/AssignAdd"
  input: "evaluation/class/unknown/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/div_1"
  op: "RealDiv"
  input: "evaluation/class/unknown/precision/true_positives/AssignAdd"
  input: "evaluation/class/unknown/precision/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision/update_op"
  op: "Select"
  input: "evaluation/class/unknown/precision/Greater_1"
  input: "evaluation/class/unknown/precision/div_1"
  input: "evaluation/class/unknown/precision/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/precision_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/unknown/precision_1"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/precision_1"
  op: "ScalarSummary"
  input: "evaluation/class/unknown/precision_1/tags"
  input: "evaluation/class/unknown/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/unknown/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/unknown/recall/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/unknown/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/unknown/recall/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/unknown/recall/true_positives/Equal"
  input: "evaluation/class/unknown/recall/true_positives/Equal_1"
}
node {
  name: "evaluation/class/unknown/recall/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/unknown/recall/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/unknown/recall/true_positives/count"
  input: "evaluation/class/unknown/recall/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/unknown/recall/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/recall/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/unknown/recall/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/unknown/recall/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/unknown/recall/true_positives/ToFloat"
  input: "evaluation/class/unknown/recall/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/unknown/recall/true_positives/count"
  input: "evaluation/class/unknown/recall/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/Equal"
  op: "Equal"
  input: "evaluation/class/unknown/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/unknown/recall/false_negatives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/Equal_1"
  op: "Equal"
  input: "evaluation/class/unknown/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/unknown/recall/false_negatives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/unknown/recall/false_negatives/Equal"
  input: "evaluation/class/unknown/recall/false_negatives/Equal_1"
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/count/Assign"
  op: "Assign"
  input: "evaluation/class/unknown/recall/false_negatives/count"
  input: "evaluation/class/unknown/recall/false_negatives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/count/read"
  op: "Identity"
  input: "evaluation/class/unknown/recall/false_negatives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/recall/false_negatives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/ToFloat"
  op: "Cast"
  input: "evaluation/class/unknown/recall/false_negatives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/Identity"
  op: "Identity"
  input: "evaluation/class/unknown/recall/false_negatives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/Sum"
  op: "Sum"
  input: "evaluation/class/unknown/recall/false_negatives/ToFloat"
  input: "evaluation/class/unknown/recall/false_negatives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/false_negatives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/unknown/recall/false_negatives/count"
  input: "evaluation/class/unknown/recall/false_negatives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/unknown/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/add"
  op: "Add"
  input: "evaluation/class/unknown/recall/true_positives/Identity"
  input: "evaluation/class/unknown/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/Greater"
  op: "Greater"
  input: "evaluation/class/unknown/recall/add"
  input: "evaluation/class/unknown/recall/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/add_1"
  op: "Add"
  input: "evaluation/class/unknown/recall/true_positives/Identity"
  input: "evaluation/class/unknown/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/div"
  op: "RealDiv"
  input: "evaluation/class/unknown/recall/true_positives/Identity"
  input: "evaluation/class/unknown/recall/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/value"
  op: "Select"
  input: "evaluation/class/unknown/recall/Greater"
  input: "evaluation/class/unknown/recall/div"
  input: "evaluation/class/unknown/recall/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/add_2"
  op: "Add"
  input: "evaluation/class/unknown/recall/true_positives/AssignAdd"
  input: "evaluation/class/unknown/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/Greater_1"
  op: "Greater"
  input: "evaluation/class/unknown/recall/add_2"
  input: "evaluation/class/unknown/recall/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/add_3"
  op: "Add"
  input: "evaluation/class/unknown/recall/true_positives/AssignAdd"
  input: "evaluation/class/unknown/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/div_1"
  op: "RealDiv"
  input: "evaluation/class/unknown/recall/true_positives/AssignAdd"
  input: "evaluation/class/unknown/recall/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall/update_op"
  op: "Select"
  input: "evaluation/class/unknown/recall/Greater_1"
  input: "evaluation/class/unknown/recall/div_1"
  input: "evaluation/class/unknown/recall/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/recall_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/unknown/recall_1"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/recall_1"
  op: "ScalarSummary"
  input: "evaluation/class/unknown/recall_1/tags"
  input: "evaluation/class/unknown/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/mul"
  op: "Mul"
  input: "evaluation/class/unknown/mul/x"
  input: "evaluation/class/unknown/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/mul_1"
  op: "Mul"
  input: "evaluation/class/unknown/mul"
  input: "evaluation/class/unknown/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/add"
  op: "Add"
  input: "evaluation/class/unknown/recall/value"
  input: "evaluation/class/unknown/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/truediv"
  op: "RealDiv"
  input: "evaluation/class/unknown/mul_1"
  input: "evaluation/class/unknown/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/f1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/unknown/f1"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/f1"
  op: "ScalarSummary"
  input: "evaluation/class/unknown/f1/tags"
  input: "evaluation/class/unknown/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/unknown/Equal"
  op: "Equal"
  input: "evaluation/class/unknown/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/unknown/map_1/TensorArrayStack/TensorArrayGatherV3"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/Cast"
  op: "Cast"
  input: "evaluation/class/unknown/Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/unknown/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/Mean"
  op: "Mean"
  input: "evaluation/class/unknown/Cast"
  input: "evaluation/class/unknown/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/unknown/accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/unknown/accuracy"
      }
    }
  }
}
node {
  name: "evaluation/class/unknown/accuracy"
  op: "ScalarSummary"
  input: "evaluation/class/unknown/accuracy/tags"
  input: "evaluation/class/unknown/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/group_deps"
  op: "NoOp"
  input: "^evaluation/class/unknown/recall/update_op"
  input: "^evaluation/class/unknown/precision/update_op"
  input: "^evaluation/class/unknown/Mean"
  input: "^evaluation/class/unknown/truediv"
}
node {
  name: "evaluation/class/pacman/map/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/pacman/map/Shape"
  input: "evaluation/class/pacman/map/strided_slice/stack"
  input: "evaluation/class/pacman/map/strided_slice/stack_1"
  input: "evaluation/class/pacman/map/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/pacman/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/pacman/map/TensorArrayUnstack/Shape"
  input: "evaluation/class/pacman/map/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/pacman/map/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/pacman/map/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/pacman/map/TensorArrayUnstack/range/start"
  input: "evaluation/class/pacman/map/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/pacman/map/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/pacman/map/TensorArray"
  input: "evaluation/class/pacman/map/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_3"
  input: "evaluation/class/pacman/map/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_3"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/pacman/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Enter"
  op: "Enter"
  input: "evaluation/class/pacman/map/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pacman/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/pacman/map/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pacman/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Merge"
  op: "Merge"
  input: "evaluation/class/pacman/map/while/Enter"
  input: "evaluation/class/pacman/map/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/pacman/map/while/Enter_1"
  input: "evaluation/class/pacman/map/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/pacman/map/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pacman/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Less"
  op: "Less"
  input: "evaluation/class/pacman/map/while/Merge"
  input: "evaluation/class/pacman/map/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/pacman/map/while/Less"
}
node {
  name: "evaluation/class/pacman/map/while/Switch"
  op: "Switch"
  input: "evaluation/class/pacman/map/while/Merge"
  input: "evaluation/class/pacman/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/pacman/map/while/Merge_1"
  input: "evaluation/class/pacman/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Identity"
  op: "Identity"
  input: "evaluation/class/pacman/map/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/pacman/map/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/pacman/map/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pacman/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/pacman/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pacman/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/pacman/map/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/pacman/map/while/Identity"
  input: "evaluation/class/pacman/map/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/pacman/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Equal"
  op: "Equal"
  input: "evaluation/class/pacman/map/while/TensorArrayReadV3"
  input: "evaluation/class/pacman/map/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/pacman/map/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pacman/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/pacman/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/pacman/map/while/Identity"
  input: "evaluation/class/pacman/map/while/Equal"
  input: "evaluation/class/pacman/map/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/add/y"
  op: "Const"
  input: "^evaluation/class/pacman/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/add"
  op: "Add"
  input: "evaluation/class/pacman/map/while/Identity"
  input: "evaluation/class/pacman/map/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/pacman/map/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/pacman/map/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Exit"
  op: "Exit"
  input: "evaluation/class/pacman/map/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/pacman/map/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/pacman/map/TensorArray_1"
  input: "evaluation/class/pacman/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/pacman/map/TensorArrayStack/range/start"
  input: "evaluation/class/pacman/map/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/pacman/map/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/pacman/map/TensorArray_1"
  input: "evaluation/class/pacman/map/TensorArrayStack/range"
  input: "evaluation/class/pacman/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/pacman/map_1/Shape"
  input: "evaluation/class/pacman/map_1/strided_slice/stack"
  input: "evaluation/class/pacman/map_1/strided_slice/stack_1"
  input: "evaluation/class/pacman/map_1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/pacman/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/pacman/map_1/TensorArrayUnstack/Shape"
  input: "evaluation/class/pacman/map_1/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/pacman/map_1/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/pacman/map_1/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/pacman/map_1/TensorArrayUnstack/range/start"
  input: "evaluation/class/pacman/map_1/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/pacman/map_1/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/pacman/map_1/TensorArray"
  input: "evaluation/class/pacman/map_1/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_2"
  input: "evaluation/class/pacman/map_1/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_2"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/pacman/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Enter"
  op: "Enter"
  input: "evaluation/class/pacman/map_1/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pacman/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/pacman/map_1/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pacman/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Merge"
  op: "Merge"
  input: "evaluation/class/pacman/map_1/while/Enter"
  input: "evaluation/class/pacman/map_1/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/pacman/map_1/while/Enter_1"
  input: "evaluation/class/pacman/map_1/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/pacman/map_1/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pacman/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Less"
  op: "Less"
  input: "evaluation/class/pacman/map_1/while/Merge"
  input: "evaluation/class/pacman/map_1/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/pacman/map_1/while/Less"
}
node {
  name: "evaluation/class/pacman/map_1/while/Switch"
  op: "Switch"
  input: "evaluation/class/pacman/map_1/while/Merge"
  input: "evaluation/class/pacman/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map_1/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/pacman/map_1/while/Merge_1"
  input: "evaluation/class/pacman/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map_1/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Identity"
  op: "Identity"
  input: "evaluation/class/pacman/map_1/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/pacman/map_1/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/pacman/map_1/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pacman/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/pacman/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pacman/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/pacman/map_1/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/pacman/map_1/while/Identity"
  input: "evaluation/class/pacman/map_1/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/pacman/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Equal"
  op: "Equal"
  input: "evaluation/class/pacman/map_1/while/TensorArrayReadV3"
  input: "evaluation/class/pacman/map_1/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/pacman/map_1/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map_1/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pacman/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/pacman/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/pacman/map_1/while/Identity"
  input: "evaluation/class/pacman/map_1/while/Equal"
  input: "evaluation/class/pacman/map_1/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map_1/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/add/y"
  op: "Const"
  input: "^evaluation/class/pacman/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/add"
  op: "Add"
  input: "evaluation/class/pacman/map_1/while/Identity"
  input: "evaluation/class/pacman/map_1/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/pacman/map_1/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/pacman/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Exit"
  op: "Exit"
  input: "evaluation/class/pacman/map_1/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/pacman/map_1/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/pacman/map_1/TensorArray_1"
  input: "evaluation/class/pacman/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/pacman/map_1/TensorArrayStack/range/start"
  input: "evaluation/class/pacman/map_1/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/pacman/map_1/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/map_1/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/pacman/map_1/TensorArray_1"
  input: "evaluation/class/pacman/map_1/TensorArrayStack/range"
  input: "evaluation/class/pacman/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/pacman/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pacman/precision/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/pacman/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pacman/precision/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/pacman/precision/true_positives/Equal"
  input: "evaluation/class/pacman/precision/true_positives/Equal_1"
}
node {
  name: "evaluation/class/pacman/precision/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/pacman/precision/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/pacman/precision/true_positives/count"
  input: "evaluation/class/pacman/precision/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/pacman/precision/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/precision/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/pacman/precision/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/pacman/precision/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/pacman/precision/true_positives/ToFloat"
  input: "evaluation/class/pacman/precision/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/pacman/precision/true_positives/count"
  input: "evaluation/class/pacman/precision/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/Equal"
  op: "Equal"
  input: "evaluation/class/pacman/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pacman/precision/false_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/pacman/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pacman/precision/false_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/pacman/precision/false_positives/Equal"
  input: "evaluation/class/pacman/precision/false_positives/Equal_1"
}
node {
  name: "evaluation/class/pacman/precision/false_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/pacman/precision/false_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/pacman/precision/false_positives/count"
  input: "evaluation/class/pacman/precision/false_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/count/read"
  op: "Identity"
  input: "evaluation/class/pacman/precision/false_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/precision/false_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/pacman/precision/false_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/Identity"
  op: "Identity"
  input: "evaluation/class/pacman/precision/false_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/Sum"
  op: "Sum"
  input: "evaluation/class/pacman/precision/false_positives/ToFloat"
  input: "evaluation/class/pacman/precision/false_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/false_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/pacman/precision/false_positives/count"
  input: "evaluation/class/pacman/precision/false_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/add"
  op: "Add"
  input: "evaluation/class/pacman/precision/true_positives/Identity"
  input: "evaluation/class/pacman/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/Greater"
  op: "Greater"
  input: "evaluation/class/pacman/precision/add"
  input: "evaluation/class/pacman/precision/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/add_1"
  op: "Add"
  input: "evaluation/class/pacman/precision/true_positives/Identity"
  input: "evaluation/class/pacman/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/div"
  op: "RealDiv"
  input: "evaluation/class/pacman/precision/true_positives/Identity"
  input: "evaluation/class/pacman/precision/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/value"
  op: "Select"
  input: "evaluation/class/pacman/precision/Greater"
  input: "evaluation/class/pacman/precision/div"
  input: "evaluation/class/pacman/precision/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/add_2"
  op: "Add"
  input: "evaluation/class/pacman/precision/true_positives/AssignAdd"
  input: "evaluation/class/pacman/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/Greater_1"
  op: "Greater"
  input: "evaluation/class/pacman/precision/add_2"
  input: "evaluation/class/pacman/precision/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/add_3"
  op: "Add"
  input: "evaluation/class/pacman/precision/true_positives/AssignAdd"
  input: "evaluation/class/pacman/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/div_1"
  op: "RealDiv"
  input: "evaluation/class/pacman/precision/true_positives/AssignAdd"
  input: "evaluation/class/pacman/precision/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision/update_op"
  op: "Select"
  input: "evaluation/class/pacman/precision/Greater_1"
  input: "evaluation/class/pacman/precision/div_1"
  input: "evaluation/class/pacman/precision/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/precision_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/pacman/precision_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/precision_1"
  op: "ScalarSummary"
  input: "evaluation/class/pacman/precision_1/tags"
  input: "evaluation/class/pacman/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/pacman/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pacman/recall/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/pacman/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pacman/recall/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/pacman/recall/true_positives/Equal"
  input: "evaluation/class/pacman/recall/true_positives/Equal_1"
}
node {
  name: "evaluation/class/pacman/recall/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/pacman/recall/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/pacman/recall/true_positives/count"
  input: "evaluation/class/pacman/recall/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/pacman/recall/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/recall/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/pacman/recall/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/pacman/recall/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/pacman/recall/true_positives/ToFloat"
  input: "evaluation/class/pacman/recall/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/pacman/recall/true_positives/count"
  input: "evaluation/class/pacman/recall/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/Equal"
  op: "Equal"
  input: "evaluation/class/pacman/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pacman/recall/false_negatives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/Equal_1"
  op: "Equal"
  input: "evaluation/class/pacman/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pacman/recall/false_negatives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/pacman/recall/false_negatives/Equal"
  input: "evaluation/class/pacman/recall/false_negatives/Equal_1"
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/count/Assign"
  op: "Assign"
  input: "evaluation/class/pacman/recall/false_negatives/count"
  input: "evaluation/class/pacman/recall/false_negatives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/count/read"
  op: "Identity"
  input: "evaluation/class/pacman/recall/false_negatives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/recall/false_negatives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/ToFloat"
  op: "Cast"
  input: "evaluation/class/pacman/recall/false_negatives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/Identity"
  op: "Identity"
  input: "evaluation/class/pacman/recall/false_negatives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/Sum"
  op: "Sum"
  input: "evaluation/class/pacman/recall/false_negatives/ToFloat"
  input: "evaluation/class/pacman/recall/false_negatives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/false_negatives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/pacman/recall/false_negatives/count"
  input: "evaluation/class/pacman/recall/false_negatives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pacman/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/add"
  op: "Add"
  input: "evaluation/class/pacman/recall/true_positives/Identity"
  input: "evaluation/class/pacman/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/Greater"
  op: "Greater"
  input: "evaluation/class/pacman/recall/add"
  input: "evaluation/class/pacman/recall/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/add_1"
  op: "Add"
  input: "evaluation/class/pacman/recall/true_positives/Identity"
  input: "evaluation/class/pacman/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/div"
  op: "RealDiv"
  input: "evaluation/class/pacman/recall/true_positives/Identity"
  input: "evaluation/class/pacman/recall/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/value"
  op: "Select"
  input: "evaluation/class/pacman/recall/Greater"
  input: "evaluation/class/pacman/recall/div"
  input: "evaluation/class/pacman/recall/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/add_2"
  op: "Add"
  input: "evaluation/class/pacman/recall/true_positives/AssignAdd"
  input: "evaluation/class/pacman/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/Greater_1"
  op: "Greater"
  input: "evaluation/class/pacman/recall/add_2"
  input: "evaluation/class/pacman/recall/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/add_3"
  op: "Add"
  input: "evaluation/class/pacman/recall/true_positives/AssignAdd"
  input: "evaluation/class/pacman/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/div_1"
  op: "RealDiv"
  input: "evaluation/class/pacman/recall/true_positives/AssignAdd"
  input: "evaluation/class/pacman/recall/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall/update_op"
  op: "Select"
  input: "evaluation/class/pacman/recall/Greater_1"
  input: "evaluation/class/pacman/recall/div_1"
  input: "evaluation/class/pacman/recall/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/recall_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/pacman/recall_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/recall_1"
  op: "ScalarSummary"
  input: "evaluation/class/pacman/recall_1/tags"
  input: "evaluation/class/pacman/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/mul"
  op: "Mul"
  input: "evaluation/class/pacman/mul/x"
  input: "evaluation/class/pacman/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/mul_1"
  op: "Mul"
  input: "evaluation/class/pacman/mul"
  input: "evaluation/class/pacman/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/add"
  op: "Add"
  input: "evaluation/class/pacman/recall/value"
  input: "evaluation/class/pacman/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/truediv"
  op: "RealDiv"
  input: "evaluation/class/pacman/mul_1"
  input: "evaluation/class/pacman/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/f1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/pacman/f1"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/f1"
  op: "ScalarSummary"
  input: "evaluation/class/pacman/f1/tags"
  input: "evaluation/class/pacman/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pacman/Equal"
  op: "Equal"
  input: "evaluation/class/pacman/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pacman/map_1/TensorArrayStack/TensorArrayGatherV3"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/Cast"
  op: "Cast"
  input: "evaluation/class/pacman/Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pacman/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/Mean"
  op: "Mean"
  input: "evaluation/class/pacman/Cast"
  input: "evaluation/class/pacman/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pacman/accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/pacman/accuracy"
      }
    }
  }
}
node {
  name: "evaluation/class/pacman/accuracy"
  op: "ScalarSummary"
  input: "evaluation/class/pacman/accuracy/tags"
  input: "evaluation/class/pacman/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/group_deps_1"
  op: "NoOp"
  input: "^evaluation/class/pacman/recall/update_op"
  input: "^evaluation/class/pacman/precision/update_op"
  input: "^evaluation/class/pacman/Mean"
  input: "^evaluation/class/pacman/truediv"
}
node {
  name: "evaluation/class/wall/map/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/wall/map/Shape"
  input: "evaluation/class/wall/map/strided_slice/stack"
  input: "evaluation/class/wall/map/strided_slice/stack_1"
  input: "evaluation/class/wall/map/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/wall/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/wall/map/TensorArrayUnstack/Shape"
  input: "evaluation/class/wall/map/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/wall/map/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/wall/map/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/wall/map/TensorArrayUnstack/range/start"
  input: "evaluation/class/wall/map/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/wall/map/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/wall/map/TensorArray"
  input: "evaluation/class/wall/map/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_3"
  input: "evaluation/class/wall/map/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_3"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/wall/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Enter"
  op: "Enter"
  input: "evaluation/class/wall/map/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/wall/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/wall/map/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/wall/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Merge"
  op: "Merge"
  input: "evaluation/class/wall/map/while/Enter"
  input: "evaluation/class/wall/map/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/wall/map/while/Enter_1"
  input: "evaluation/class/wall/map/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/wall/map/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/wall/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Less"
  op: "Less"
  input: "evaluation/class/wall/map/while/Merge"
  input: "evaluation/class/wall/map/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/wall/map/while/Less"
}
node {
  name: "evaluation/class/wall/map/while/Switch"
  op: "Switch"
  input: "evaluation/class/wall/map/while/Merge"
  input: "evaluation/class/wall/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/wall/map/while/Merge_1"
  input: "evaluation/class/wall/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Identity"
  op: "Identity"
  input: "evaluation/class/wall/map/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/wall/map/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/wall/map/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/wall/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/wall/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/wall/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/wall/map/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/wall/map/while/Identity"
  input: "evaluation/class/wall/map/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/wall/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 2
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Equal"
  op: "Equal"
  input: "evaluation/class/wall/map/while/TensorArrayReadV3"
  input: "evaluation/class/wall/map/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/wall/map/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/wall/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/wall/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/wall/map/while/Identity"
  input: "evaluation/class/wall/map/while/Equal"
  input: "evaluation/class/wall/map/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/add/y"
  op: "Const"
  input: "^evaluation/class/wall/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/add"
  op: "Add"
  input: "evaluation/class/wall/map/while/Identity"
  input: "evaluation/class/wall/map/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/wall/map/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/wall/map/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Exit"
  op: "Exit"
  input: "evaluation/class/wall/map/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/wall/map/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/wall/map/TensorArray_1"
  input: "evaluation/class/wall/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/wall/map/TensorArrayStack/range/start"
  input: "evaluation/class/wall/map/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/wall/map/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/wall/map/TensorArray_1"
  input: "evaluation/class/wall/map/TensorArrayStack/range"
  input: "evaluation/class/wall/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/wall/map_1/Shape"
  input: "evaluation/class/wall/map_1/strided_slice/stack"
  input: "evaluation/class/wall/map_1/strided_slice/stack_1"
  input: "evaluation/class/wall/map_1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/wall/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/wall/map_1/TensorArrayUnstack/Shape"
  input: "evaluation/class/wall/map_1/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/wall/map_1/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/wall/map_1/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/wall/map_1/TensorArrayUnstack/range/start"
  input: "evaluation/class/wall/map_1/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/wall/map_1/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/wall/map_1/TensorArray"
  input: "evaluation/class/wall/map_1/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_2"
  input: "evaluation/class/wall/map_1/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_2"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/wall/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Enter"
  op: "Enter"
  input: "evaluation/class/wall/map_1/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/wall/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/wall/map_1/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/wall/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Merge"
  op: "Merge"
  input: "evaluation/class/wall/map_1/while/Enter"
  input: "evaluation/class/wall/map_1/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/wall/map_1/while/Enter_1"
  input: "evaluation/class/wall/map_1/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/wall/map_1/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/wall/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Less"
  op: "Less"
  input: "evaluation/class/wall/map_1/while/Merge"
  input: "evaluation/class/wall/map_1/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/wall/map_1/while/Less"
}
node {
  name: "evaluation/class/wall/map_1/while/Switch"
  op: "Switch"
  input: "evaluation/class/wall/map_1/while/Merge"
  input: "evaluation/class/wall/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map_1/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/wall/map_1/while/Merge_1"
  input: "evaluation/class/wall/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map_1/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Identity"
  op: "Identity"
  input: "evaluation/class/wall/map_1/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/wall/map_1/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/wall/map_1/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/wall/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/wall/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/wall/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/wall/map_1/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/wall/map_1/while/Identity"
  input: "evaluation/class/wall/map_1/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/wall/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 2
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Equal"
  op: "Equal"
  input: "evaluation/class/wall/map_1/while/TensorArrayReadV3"
  input: "evaluation/class/wall/map_1/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/wall/map_1/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map_1/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/wall/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/wall/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/wall/map_1/while/Identity"
  input: "evaluation/class/wall/map_1/while/Equal"
  input: "evaluation/class/wall/map_1/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map_1/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/add/y"
  op: "Const"
  input: "^evaluation/class/wall/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/add"
  op: "Add"
  input: "evaluation/class/wall/map_1/while/Identity"
  input: "evaluation/class/wall/map_1/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/wall/map_1/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/wall/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Exit"
  op: "Exit"
  input: "evaluation/class/wall/map_1/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/wall/map_1/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/wall/map_1/TensorArray_1"
  input: "evaluation/class/wall/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/wall/map_1/TensorArrayStack/range/start"
  input: "evaluation/class/wall/map_1/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/wall/map_1/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/map_1/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/wall/map_1/TensorArray_1"
  input: "evaluation/class/wall/map_1/TensorArrayStack/range"
  input: "evaluation/class/wall/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/wall/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/wall/precision/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/wall/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/wall/precision/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/wall/precision/true_positives/Equal"
  input: "evaluation/class/wall/precision/true_positives/Equal_1"
}
node {
  name: "evaluation/class/wall/precision/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/wall/precision/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/wall/precision/true_positives/count"
  input: "evaluation/class/wall/precision/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/wall/precision/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/precision/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/wall/precision/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/wall/precision/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/wall/precision/true_positives/ToFloat"
  input: "evaluation/class/wall/precision/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/wall/precision/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/wall/precision/true_positives/count"
  input: "evaluation/class/wall/precision/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/Equal"
  op: "Equal"
  input: "evaluation/class/wall/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/wall/precision/false_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/wall/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/wall/precision/false_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/wall/precision/false_positives/Equal"
  input: "evaluation/class/wall/precision/false_positives/Equal_1"
}
node {
  name: "evaluation/class/wall/precision/false_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/wall/precision/false_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/wall/precision/false_positives/count"
  input: "evaluation/class/wall/precision/false_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/count/read"
  op: "Identity"
  input: "evaluation/class/wall/precision/false_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/precision/false_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/wall/precision/false_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/Identity"
  op: "Identity"
  input: "evaluation/class/wall/precision/false_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/Sum"
  op: "Sum"
  input: "evaluation/class/wall/precision/false_positives/ToFloat"
  input: "evaluation/class/wall/precision/false_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/wall/precision/false_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/wall/precision/false_positives/count"
  input: "evaluation/class/wall/precision/false_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/wall/precision/add"
  op: "Add"
  input: "evaluation/class/wall/precision/true_positives/Identity"
  input: "evaluation/class/wall/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/precision/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/Greater"
  op: "Greater"
  input: "evaluation/class/wall/precision/add"
  input: "evaluation/class/wall/precision/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/precision/add_1"
  op: "Add"
  input: "evaluation/class/wall/precision/true_positives/Identity"
  input: "evaluation/class/wall/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/precision/div"
  op: "RealDiv"
  input: "evaluation/class/wall/precision/true_positives/Identity"
  input: "evaluation/class/wall/precision/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/precision/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/value"
  op: "Select"
  input: "evaluation/class/wall/precision/Greater"
  input: "evaluation/class/wall/precision/div"
  input: "evaluation/class/wall/precision/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/precision/add_2"
  op: "Add"
  input: "evaluation/class/wall/precision/true_positives/AssignAdd"
  input: "evaluation/class/wall/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/precision/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/Greater_1"
  op: "Greater"
  input: "evaluation/class/wall/precision/add_2"
  input: "evaluation/class/wall/precision/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/precision/add_3"
  op: "Add"
  input: "evaluation/class/wall/precision/true_positives/AssignAdd"
  input: "evaluation/class/wall/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/precision/div_1"
  op: "RealDiv"
  input: "evaluation/class/wall/precision/true_positives/AssignAdd"
  input: "evaluation/class/wall/precision/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/precision/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision/update_op"
  op: "Select"
  input: "evaluation/class/wall/precision/Greater_1"
  input: "evaluation/class/wall/precision/div_1"
  input: "evaluation/class/wall/precision/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/precision_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/wall/precision_1"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/precision_1"
  op: "ScalarSummary"
  input: "evaluation/class/wall/precision_1/tags"
  input: "evaluation/class/wall/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/wall/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/wall/recall/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/wall/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/wall/recall/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/wall/recall/true_positives/Equal"
  input: "evaluation/class/wall/recall/true_positives/Equal_1"
}
node {
  name: "evaluation/class/wall/recall/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/wall/recall/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/wall/recall/true_positives/count"
  input: "evaluation/class/wall/recall/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/wall/recall/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/recall/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/wall/recall/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/wall/recall/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/wall/recall/true_positives/ToFloat"
  input: "evaluation/class/wall/recall/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/wall/recall/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/wall/recall/true_positives/count"
  input: "evaluation/class/wall/recall/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/Equal"
  op: "Equal"
  input: "evaluation/class/wall/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/wall/recall/false_negatives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/Equal_1"
  op: "Equal"
  input: "evaluation/class/wall/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/wall/recall/false_negatives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/wall/recall/false_negatives/Equal"
  input: "evaluation/class/wall/recall/false_negatives/Equal_1"
}
node {
  name: "evaluation/class/wall/recall/false_negatives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/wall/recall/false_negatives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/count/Assign"
  op: "Assign"
  input: "evaluation/class/wall/recall/false_negatives/count"
  input: "evaluation/class/wall/recall/false_negatives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/count/read"
  op: "Identity"
  input: "evaluation/class/wall/recall/false_negatives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/recall/false_negatives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/ToFloat"
  op: "Cast"
  input: "evaluation/class/wall/recall/false_negatives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/Identity"
  op: "Identity"
  input: "evaluation/class/wall/recall/false_negatives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/Sum"
  op: "Sum"
  input: "evaluation/class/wall/recall/false_negatives/ToFloat"
  input: "evaluation/class/wall/recall/false_negatives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/wall/recall/false_negatives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/wall/recall/false_negatives/count"
  input: "evaluation/class/wall/recall/false_negatives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/wall/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/wall/recall/add"
  op: "Add"
  input: "evaluation/class/wall/recall/true_positives/Identity"
  input: "evaluation/class/wall/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/Greater"
  op: "Greater"
  input: "evaluation/class/wall/recall/add"
  input: "evaluation/class/wall/recall/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall/add_1"
  op: "Add"
  input: "evaluation/class/wall/recall/true_positives/Identity"
  input: "evaluation/class/wall/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall/div"
  op: "RealDiv"
  input: "evaluation/class/wall/recall/true_positives/Identity"
  input: "evaluation/class/wall/recall/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/value"
  op: "Select"
  input: "evaluation/class/wall/recall/Greater"
  input: "evaluation/class/wall/recall/div"
  input: "evaluation/class/wall/recall/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall/add_2"
  op: "Add"
  input: "evaluation/class/wall/recall/true_positives/AssignAdd"
  input: "evaluation/class/wall/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/Greater_1"
  op: "Greater"
  input: "evaluation/class/wall/recall/add_2"
  input: "evaluation/class/wall/recall/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall/add_3"
  op: "Add"
  input: "evaluation/class/wall/recall/true_positives/AssignAdd"
  input: "evaluation/class/wall/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall/div_1"
  op: "RealDiv"
  input: "evaluation/class/wall/recall/true_positives/AssignAdd"
  input: "evaluation/class/wall/recall/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall/update_op"
  op: "Select"
  input: "evaluation/class/wall/recall/Greater_1"
  input: "evaluation/class/wall/recall/div_1"
  input: "evaluation/class/wall/recall/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/recall_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/wall/recall_1"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/recall_1"
  op: "ScalarSummary"
  input: "evaluation/class/wall/recall_1/tags"
  input: "evaluation/class/wall/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/mul"
  op: "Mul"
  input: "evaluation/class/wall/mul/x"
  input: "evaluation/class/wall/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/mul_1"
  op: "Mul"
  input: "evaluation/class/wall/mul"
  input: "evaluation/class/wall/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/add"
  op: "Add"
  input: "evaluation/class/wall/recall/value"
  input: "evaluation/class/wall/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/truediv"
  op: "RealDiv"
  input: "evaluation/class/wall/mul_1"
  input: "evaluation/class/wall/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/f1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/wall/f1"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/f1"
  op: "ScalarSummary"
  input: "evaluation/class/wall/f1/tags"
  input: "evaluation/class/wall/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/wall/Equal"
  op: "Equal"
  input: "evaluation/class/wall/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/wall/map_1/TensorArrayStack/TensorArrayGatherV3"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/Cast"
  op: "Cast"
  input: "evaluation/class/wall/Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/wall/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/wall/Mean"
  op: "Mean"
  input: "evaluation/class/wall/Cast"
  input: "evaluation/class/wall/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/wall/accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/wall/accuracy"
      }
    }
  }
}
node {
  name: "evaluation/class/wall/accuracy"
  op: "ScalarSummary"
  input: "evaluation/class/wall/accuracy/tags"
  input: "evaluation/class/wall/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/group_deps_2"
  op: "NoOp"
  input: "^evaluation/class/wall/recall/update_op"
  input: "^evaluation/class/wall/precision/update_op"
  input: "^evaluation/class/wall/Mean"
  input: "^evaluation/class/wall/truediv"
}
node {
  name: "evaluation/class/blank/map/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/blank/map/Shape"
  input: "evaluation/class/blank/map/strided_slice/stack"
  input: "evaluation/class/blank/map/strided_slice/stack_1"
  input: "evaluation/class/blank/map/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/blank/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/blank/map/TensorArrayUnstack/Shape"
  input: "evaluation/class/blank/map/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/blank/map/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/blank/map/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/blank/map/TensorArrayUnstack/range/start"
  input: "evaluation/class/blank/map/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/blank/map/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/blank/map/TensorArray"
  input: "evaluation/class/blank/map/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_3"
  input: "evaluation/class/blank/map/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_3"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/blank/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Enter"
  op: "Enter"
  input: "evaluation/class/blank/map/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blank/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/blank/map/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blank/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Merge"
  op: "Merge"
  input: "evaluation/class/blank/map/while/Enter"
  input: "evaluation/class/blank/map/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/blank/map/while/Enter_1"
  input: "evaluation/class/blank/map/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/blank/map/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blank/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Less"
  op: "Less"
  input: "evaluation/class/blank/map/while/Merge"
  input: "evaluation/class/blank/map/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/blank/map/while/Less"
}
node {
  name: "evaluation/class/blank/map/while/Switch"
  op: "Switch"
  input: "evaluation/class/blank/map/while/Merge"
  input: "evaluation/class/blank/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/blank/map/while/Merge_1"
  input: "evaluation/class/blank/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Identity"
  op: "Identity"
  input: "evaluation/class/blank/map/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/blank/map/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/blank/map/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blank/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/blank/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blank/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/blank/map/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/blank/map/while/Identity"
  input: "evaluation/class/blank/map/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/blank/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 3
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Equal"
  op: "Equal"
  input: "evaluation/class/blank/map/while/TensorArrayReadV3"
  input: "evaluation/class/blank/map/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/blank/map/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blank/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/blank/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/blank/map/while/Identity"
  input: "evaluation/class/blank/map/while/Equal"
  input: "evaluation/class/blank/map/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/add/y"
  op: "Const"
  input: "^evaluation/class/blank/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/add"
  op: "Add"
  input: "evaluation/class/blank/map/while/Identity"
  input: "evaluation/class/blank/map/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/blank/map/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/blank/map/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Exit"
  op: "Exit"
  input: "evaluation/class/blank/map/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/blank/map/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/blank/map/TensorArray_1"
  input: "evaluation/class/blank/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/blank/map/TensorArrayStack/range/start"
  input: "evaluation/class/blank/map/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/blank/map/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/blank/map/TensorArray_1"
  input: "evaluation/class/blank/map/TensorArrayStack/range"
  input: "evaluation/class/blank/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/blank/map_1/Shape"
  input: "evaluation/class/blank/map_1/strided_slice/stack"
  input: "evaluation/class/blank/map_1/strided_slice/stack_1"
  input: "evaluation/class/blank/map_1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/blank/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/blank/map_1/TensorArrayUnstack/Shape"
  input: "evaluation/class/blank/map_1/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/blank/map_1/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/blank/map_1/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/blank/map_1/TensorArrayUnstack/range/start"
  input: "evaluation/class/blank/map_1/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/blank/map_1/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/blank/map_1/TensorArray"
  input: "evaluation/class/blank/map_1/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_2"
  input: "evaluation/class/blank/map_1/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_2"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/blank/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Enter"
  op: "Enter"
  input: "evaluation/class/blank/map_1/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blank/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/blank/map_1/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blank/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Merge"
  op: "Merge"
  input: "evaluation/class/blank/map_1/while/Enter"
  input: "evaluation/class/blank/map_1/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/blank/map_1/while/Enter_1"
  input: "evaluation/class/blank/map_1/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/blank/map_1/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blank/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Less"
  op: "Less"
  input: "evaluation/class/blank/map_1/while/Merge"
  input: "evaluation/class/blank/map_1/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/blank/map_1/while/Less"
}
node {
  name: "evaluation/class/blank/map_1/while/Switch"
  op: "Switch"
  input: "evaluation/class/blank/map_1/while/Merge"
  input: "evaluation/class/blank/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map_1/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/blank/map_1/while/Merge_1"
  input: "evaluation/class/blank/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map_1/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Identity"
  op: "Identity"
  input: "evaluation/class/blank/map_1/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/blank/map_1/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/blank/map_1/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blank/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/blank/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blank/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/blank/map_1/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/blank/map_1/while/Identity"
  input: "evaluation/class/blank/map_1/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/blank/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 3
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Equal"
  op: "Equal"
  input: "evaluation/class/blank/map_1/while/TensorArrayReadV3"
  input: "evaluation/class/blank/map_1/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/blank/map_1/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map_1/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blank/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/blank/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/blank/map_1/while/Identity"
  input: "evaluation/class/blank/map_1/while/Equal"
  input: "evaluation/class/blank/map_1/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map_1/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/add/y"
  op: "Const"
  input: "^evaluation/class/blank/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/add"
  op: "Add"
  input: "evaluation/class/blank/map_1/while/Identity"
  input: "evaluation/class/blank/map_1/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/blank/map_1/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/blank/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Exit"
  op: "Exit"
  input: "evaluation/class/blank/map_1/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/blank/map_1/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/blank/map_1/TensorArray_1"
  input: "evaluation/class/blank/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/blank/map_1/TensorArrayStack/range/start"
  input: "evaluation/class/blank/map_1/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/blank/map_1/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/map_1/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/blank/map_1/TensorArray_1"
  input: "evaluation/class/blank/map_1/TensorArrayStack/range"
  input: "evaluation/class/blank/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/blank/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blank/precision/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/blank/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blank/precision/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/blank/precision/true_positives/Equal"
  input: "evaluation/class/blank/precision/true_positives/Equal_1"
}
node {
  name: "evaluation/class/blank/precision/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/blank/precision/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/blank/precision/true_positives/count"
  input: "evaluation/class/blank/precision/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/blank/precision/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/precision/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/blank/precision/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/blank/precision/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/blank/precision/true_positives/ToFloat"
  input: "evaluation/class/blank/precision/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blank/precision/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/blank/precision/true_positives/count"
  input: "evaluation/class/blank/precision/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/Equal"
  op: "Equal"
  input: "evaluation/class/blank/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blank/precision/false_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/blank/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blank/precision/false_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/blank/precision/false_positives/Equal"
  input: "evaluation/class/blank/precision/false_positives/Equal_1"
}
node {
  name: "evaluation/class/blank/precision/false_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/blank/precision/false_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/blank/precision/false_positives/count"
  input: "evaluation/class/blank/precision/false_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/count/read"
  op: "Identity"
  input: "evaluation/class/blank/precision/false_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/precision/false_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/blank/precision/false_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/Identity"
  op: "Identity"
  input: "evaluation/class/blank/precision/false_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/Sum"
  op: "Sum"
  input: "evaluation/class/blank/precision/false_positives/ToFloat"
  input: "evaluation/class/blank/precision/false_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blank/precision/false_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/blank/precision/false_positives/count"
  input: "evaluation/class/blank/precision/false_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blank/precision/add"
  op: "Add"
  input: "evaluation/class/blank/precision/true_positives/Identity"
  input: "evaluation/class/blank/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/precision/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/Greater"
  op: "Greater"
  input: "evaluation/class/blank/precision/add"
  input: "evaluation/class/blank/precision/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/precision/add_1"
  op: "Add"
  input: "evaluation/class/blank/precision/true_positives/Identity"
  input: "evaluation/class/blank/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/precision/div"
  op: "RealDiv"
  input: "evaluation/class/blank/precision/true_positives/Identity"
  input: "evaluation/class/blank/precision/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/precision/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/value"
  op: "Select"
  input: "evaluation/class/blank/precision/Greater"
  input: "evaluation/class/blank/precision/div"
  input: "evaluation/class/blank/precision/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/precision/add_2"
  op: "Add"
  input: "evaluation/class/blank/precision/true_positives/AssignAdd"
  input: "evaluation/class/blank/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/precision/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/Greater_1"
  op: "Greater"
  input: "evaluation/class/blank/precision/add_2"
  input: "evaluation/class/blank/precision/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/precision/add_3"
  op: "Add"
  input: "evaluation/class/blank/precision/true_positives/AssignAdd"
  input: "evaluation/class/blank/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/precision/div_1"
  op: "RealDiv"
  input: "evaluation/class/blank/precision/true_positives/AssignAdd"
  input: "evaluation/class/blank/precision/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/precision/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision/update_op"
  op: "Select"
  input: "evaluation/class/blank/precision/Greater_1"
  input: "evaluation/class/blank/precision/div_1"
  input: "evaluation/class/blank/precision/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/precision_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/blank/precision_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/precision_1"
  op: "ScalarSummary"
  input: "evaluation/class/blank/precision_1/tags"
  input: "evaluation/class/blank/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/blank/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blank/recall/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/blank/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blank/recall/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/blank/recall/true_positives/Equal"
  input: "evaluation/class/blank/recall/true_positives/Equal_1"
}
node {
  name: "evaluation/class/blank/recall/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/blank/recall/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/blank/recall/true_positives/count"
  input: "evaluation/class/blank/recall/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/blank/recall/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/recall/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/blank/recall/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/blank/recall/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/blank/recall/true_positives/ToFloat"
  input: "evaluation/class/blank/recall/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blank/recall/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/blank/recall/true_positives/count"
  input: "evaluation/class/blank/recall/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/Equal"
  op: "Equal"
  input: "evaluation/class/blank/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blank/recall/false_negatives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/Equal_1"
  op: "Equal"
  input: "evaluation/class/blank/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blank/recall/false_negatives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/blank/recall/false_negatives/Equal"
  input: "evaluation/class/blank/recall/false_negatives/Equal_1"
}
node {
  name: "evaluation/class/blank/recall/false_negatives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/blank/recall/false_negatives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/count/Assign"
  op: "Assign"
  input: "evaluation/class/blank/recall/false_negatives/count"
  input: "evaluation/class/blank/recall/false_negatives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/count/read"
  op: "Identity"
  input: "evaluation/class/blank/recall/false_negatives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/recall/false_negatives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/ToFloat"
  op: "Cast"
  input: "evaluation/class/blank/recall/false_negatives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/Identity"
  op: "Identity"
  input: "evaluation/class/blank/recall/false_negatives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/Sum"
  op: "Sum"
  input: "evaluation/class/blank/recall/false_negatives/ToFloat"
  input: "evaluation/class/blank/recall/false_negatives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blank/recall/false_negatives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/blank/recall/false_negatives/count"
  input: "evaluation/class/blank/recall/false_negatives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blank/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blank/recall/add"
  op: "Add"
  input: "evaluation/class/blank/recall/true_positives/Identity"
  input: "evaluation/class/blank/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/Greater"
  op: "Greater"
  input: "evaluation/class/blank/recall/add"
  input: "evaluation/class/blank/recall/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall/add_1"
  op: "Add"
  input: "evaluation/class/blank/recall/true_positives/Identity"
  input: "evaluation/class/blank/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall/div"
  op: "RealDiv"
  input: "evaluation/class/blank/recall/true_positives/Identity"
  input: "evaluation/class/blank/recall/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/value"
  op: "Select"
  input: "evaluation/class/blank/recall/Greater"
  input: "evaluation/class/blank/recall/div"
  input: "evaluation/class/blank/recall/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall/add_2"
  op: "Add"
  input: "evaluation/class/blank/recall/true_positives/AssignAdd"
  input: "evaluation/class/blank/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/Greater_1"
  op: "Greater"
  input: "evaluation/class/blank/recall/add_2"
  input: "evaluation/class/blank/recall/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall/add_3"
  op: "Add"
  input: "evaluation/class/blank/recall/true_positives/AssignAdd"
  input: "evaluation/class/blank/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall/div_1"
  op: "RealDiv"
  input: "evaluation/class/blank/recall/true_positives/AssignAdd"
  input: "evaluation/class/blank/recall/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall/update_op"
  op: "Select"
  input: "evaluation/class/blank/recall/Greater_1"
  input: "evaluation/class/blank/recall/div_1"
  input: "evaluation/class/blank/recall/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/recall_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/blank/recall_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/recall_1"
  op: "ScalarSummary"
  input: "evaluation/class/blank/recall_1/tags"
  input: "evaluation/class/blank/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/mul"
  op: "Mul"
  input: "evaluation/class/blank/mul/x"
  input: "evaluation/class/blank/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/mul_1"
  op: "Mul"
  input: "evaluation/class/blank/mul"
  input: "evaluation/class/blank/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/add"
  op: "Add"
  input: "evaluation/class/blank/recall/value"
  input: "evaluation/class/blank/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/truediv"
  op: "RealDiv"
  input: "evaluation/class/blank/mul_1"
  input: "evaluation/class/blank/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/f1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/blank/f1"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/f1"
  op: "ScalarSummary"
  input: "evaluation/class/blank/f1/tags"
  input: "evaluation/class/blank/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blank/Equal"
  op: "Equal"
  input: "evaluation/class/blank/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blank/map_1/TensorArrayStack/TensorArrayGatherV3"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/Cast"
  op: "Cast"
  input: "evaluation/class/blank/Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blank/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blank/Mean"
  op: "Mean"
  input: "evaluation/class/blank/Cast"
  input: "evaluation/class/blank/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blank/accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/blank/accuracy"
      }
    }
  }
}
node {
  name: "evaluation/class/blank/accuracy"
  op: "ScalarSummary"
  input: "evaluation/class/blank/accuracy/tags"
  input: "evaluation/class/blank/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/group_deps_3"
  op: "NoOp"
  input: "^evaluation/class/blank/recall/update_op"
  input: "^evaluation/class/blank/precision/update_op"
  input: "^evaluation/class/blank/Mean"
  input: "^evaluation/class/blank/truediv"
}
node {
  name: "evaluation/class/fruit/map/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/fruit/map/Shape"
  input: "evaluation/class/fruit/map/strided_slice/stack"
  input: "evaluation/class/fruit/map/strided_slice/stack_1"
  input: "evaluation/class/fruit/map/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/fruit/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/fruit/map/TensorArrayUnstack/Shape"
  input: "evaluation/class/fruit/map/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/fruit/map/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/fruit/map/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/fruit/map/TensorArrayUnstack/range/start"
  input: "evaluation/class/fruit/map/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/fruit/map/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/fruit/map/TensorArray"
  input: "evaluation/class/fruit/map/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_3"
  input: "evaluation/class/fruit/map/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_3"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/fruit/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Enter"
  op: "Enter"
  input: "evaluation/class/fruit/map/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/fruit/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/fruit/map/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/fruit/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Merge"
  op: "Merge"
  input: "evaluation/class/fruit/map/while/Enter"
  input: "evaluation/class/fruit/map/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/fruit/map/while/Enter_1"
  input: "evaluation/class/fruit/map/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/fruit/map/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/fruit/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Less"
  op: "Less"
  input: "evaluation/class/fruit/map/while/Merge"
  input: "evaluation/class/fruit/map/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/fruit/map/while/Less"
}
node {
  name: "evaluation/class/fruit/map/while/Switch"
  op: "Switch"
  input: "evaluation/class/fruit/map/while/Merge"
  input: "evaluation/class/fruit/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/fruit/map/while/Merge_1"
  input: "evaluation/class/fruit/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Identity"
  op: "Identity"
  input: "evaluation/class/fruit/map/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/fruit/map/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/fruit/map/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/fruit/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/fruit/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/fruit/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/fruit/map/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/fruit/map/while/Identity"
  input: "evaluation/class/fruit/map/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/fruit/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 4
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Equal"
  op: "Equal"
  input: "evaluation/class/fruit/map/while/TensorArrayReadV3"
  input: "evaluation/class/fruit/map/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/fruit/map/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/fruit/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/fruit/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/fruit/map/while/Identity"
  input: "evaluation/class/fruit/map/while/Equal"
  input: "evaluation/class/fruit/map/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/add/y"
  op: "Const"
  input: "^evaluation/class/fruit/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/add"
  op: "Add"
  input: "evaluation/class/fruit/map/while/Identity"
  input: "evaluation/class/fruit/map/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/fruit/map/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/fruit/map/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Exit"
  op: "Exit"
  input: "evaluation/class/fruit/map/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/fruit/map/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/fruit/map/TensorArray_1"
  input: "evaluation/class/fruit/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/fruit/map/TensorArrayStack/range/start"
  input: "evaluation/class/fruit/map/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/fruit/map/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/fruit/map/TensorArray_1"
  input: "evaluation/class/fruit/map/TensorArrayStack/range"
  input: "evaluation/class/fruit/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/fruit/map_1/Shape"
  input: "evaluation/class/fruit/map_1/strided_slice/stack"
  input: "evaluation/class/fruit/map_1/strided_slice/stack_1"
  input: "evaluation/class/fruit/map_1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/fruit/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/fruit/map_1/TensorArrayUnstack/Shape"
  input: "evaluation/class/fruit/map_1/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/fruit/map_1/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/fruit/map_1/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/fruit/map_1/TensorArrayUnstack/range/start"
  input: "evaluation/class/fruit/map_1/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/fruit/map_1/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/fruit/map_1/TensorArray"
  input: "evaluation/class/fruit/map_1/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_2"
  input: "evaluation/class/fruit/map_1/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_2"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/fruit/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Enter"
  op: "Enter"
  input: "evaluation/class/fruit/map_1/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/fruit/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/fruit/map_1/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/fruit/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Merge"
  op: "Merge"
  input: "evaluation/class/fruit/map_1/while/Enter"
  input: "evaluation/class/fruit/map_1/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/fruit/map_1/while/Enter_1"
  input: "evaluation/class/fruit/map_1/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/fruit/map_1/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/fruit/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Less"
  op: "Less"
  input: "evaluation/class/fruit/map_1/while/Merge"
  input: "evaluation/class/fruit/map_1/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/fruit/map_1/while/Less"
}
node {
  name: "evaluation/class/fruit/map_1/while/Switch"
  op: "Switch"
  input: "evaluation/class/fruit/map_1/while/Merge"
  input: "evaluation/class/fruit/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map_1/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/fruit/map_1/while/Merge_1"
  input: "evaluation/class/fruit/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map_1/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Identity"
  op: "Identity"
  input: "evaluation/class/fruit/map_1/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/fruit/map_1/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/fruit/map_1/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/fruit/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/fruit/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/fruit/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/fruit/map_1/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/fruit/map_1/while/Identity"
  input: "evaluation/class/fruit/map_1/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/fruit/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 4
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Equal"
  op: "Equal"
  input: "evaluation/class/fruit/map_1/while/TensorArrayReadV3"
  input: "evaluation/class/fruit/map_1/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/fruit/map_1/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map_1/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/fruit/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/fruit/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/fruit/map_1/while/Identity"
  input: "evaluation/class/fruit/map_1/while/Equal"
  input: "evaluation/class/fruit/map_1/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map_1/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/add/y"
  op: "Const"
  input: "^evaluation/class/fruit/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/add"
  op: "Add"
  input: "evaluation/class/fruit/map_1/while/Identity"
  input: "evaluation/class/fruit/map_1/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/fruit/map_1/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/fruit/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Exit"
  op: "Exit"
  input: "evaluation/class/fruit/map_1/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/fruit/map_1/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/fruit/map_1/TensorArray_1"
  input: "evaluation/class/fruit/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/fruit/map_1/TensorArrayStack/range/start"
  input: "evaluation/class/fruit/map_1/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/fruit/map_1/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/map_1/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/fruit/map_1/TensorArray_1"
  input: "evaluation/class/fruit/map_1/TensorArrayStack/range"
  input: "evaluation/class/fruit/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/fruit/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/fruit/precision/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/fruit/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/fruit/precision/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/fruit/precision/true_positives/Equal"
  input: "evaluation/class/fruit/precision/true_positives/Equal_1"
}
node {
  name: "evaluation/class/fruit/precision/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/fruit/precision/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/fruit/precision/true_positives/count"
  input: "evaluation/class/fruit/precision/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/fruit/precision/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/precision/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/fruit/precision/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/fruit/precision/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/fruit/precision/true_positives/ToFloat"
  input: "evaluation/class/fruit/precision/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/fruit/precision/true_positives/count"
  input: "evaluation/class/fruit/precision/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/Equal"
  op: "Equal"
  input: "evaluation/class/fruit/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/fruit/precision/false_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/fruit/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/fruit/precision/false_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/fruit/precision/false_positives/Equal"
  input: "evaluation/class/fruit/precision/false_positives/Equal_1"
}
node {
  name: "evaluation/class/fruit/precision/false_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/fruit/precision/false_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/fruit/precision/false_positives/count"
  input: "evaluation/class/fruit/precision/false_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/count/read"
  op: "Identity"
  input: "evaluation/class/fruit/precision/false_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/precision/false_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/fruit/precision/false_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/Identity"
  op: "Identity"
  input: "evaluation/class/fruit/precision/false_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/Sum"
  op: "Sum"
  input: "evaluation/class/fruit/precision/false_positives/ToFloat"
  input: "evaluation/class/fruit/precision/false_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/false_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/fruit/precision/false_positives/count"
  input: "evaluation/class/fruit/precision/false_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/add"
  op: "Add"
  input: "evaluation/class/fruit/precision/true_positives/Identity"
  input: "evaluation/class/fruit/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/Greater"
  op: "Greater"
  input: "evaluation/class/fruit/precision/add"
  input: "evaluation/class/fruit/precision/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/add_1"
  op: "Add"
  input: "evaluation/class/fruit/precision/true_positives/Identity"
  input: "evaluation/class/fruit/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/div"
  op: "RealDiv"
  input: "evaluation/class/fruit/precision/true_positives/Identity"
  input: "evaluation/class/fruit/precision/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/value"
  op: "Select"
  input: "evaluation/class/fruit/precision/Greater"
  input: "evaluation/class/fruit/precision/div"
  input: "evaluation/class/fruit/precision/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/add_2"
  op: "Add"
  input: "evaluation/class/fruit/precision/true_positives/AssignAdd"
  input: "evaluation/class/fruit/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/Greater_1"
  op: "Greater"
  input: "evaluation/class/fruit/precision/add_2"
  input: "evaluation/class/fruit/precision/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/add_3"
  op: "Add"
  input: "evaluation/class/fruit/precision/true_positives/AssignAdd"
  input: "evaluation/class/fruit/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/div_1"
  op: "RealDiv"
  input: "evaluation/class/fruit/precision/true_positives/AssignAdd"
  input: "evaluation/class/fruit/precision/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision/update_op"
  op: "Select"
  input: "evaluation/class/fruit/precision/Greater_1"
  input: "evaluation/class/fruit/precision/div_1"
  input: "evaluation/class/fruit/precision/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/precision_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/fruit/precision_1"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/precision_1"
  op: "ScalarSummary"
  input: "evaluation/class/fruit/precision_1/tags"
  input: "evaluation/class/fruit/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/fruit/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/fruit/recall/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/fruit/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/fruit/recall/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/fruit/recall/true_positives/Equal"
  input: "evaluation/class/fruit/recall/true_positives/Equal_1"
}
node {
  name: "evaluation/class/fruit/recall/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/fruit/recall/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/fruit/recall/true_positives/count"
  input: "evaluation/class/fruit/recall/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/fruit/recall/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/recall/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/fruit/recall/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/fruit/recall/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/fruit/recall/true_positives/ToFloat"
  input: "evaluation/class/fruit/recall/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/fruit/recall/true_positives/count"
  input: "evaluation/class/fruit/recall/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/Equal"
  op: "Equal"
  input: "evaluation/class/fruit/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/fruit/recall/false_negatives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/Equal_1"
  op: "Equal"
  input: "evaluation/class/fruit/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/fruit/recall/false_negatives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/fruit/recall/false_negatives/Equal"
  input: "evaluation/class/fruit/recall/false_negatives/Equal_1"
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/count/Assign"
  op: "Assign"
  input: "evaluation/class/fruit/recall/false_negatives/count"
  input: "evaluation/class/fruit/recall/false_negatives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/count/read"
  op: "Identity"
  input: "evaluation/class/fruit/recall/false_negatives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/recall/false_negatives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/ToFloat"
  op: "Cast"
  input: "evaluation/class/fruit/recall/false_negatives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/Identity"
  op: "Identity"
  input: "evaluation/class/fruit/recall/false_negatives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/Sum"
  op: "Sum"
  input: "evaluation/class/fruit/recall/false_negatives/ToFloat"
  input: "evaluation/class/fruit/recall/false_negatives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/false_negatives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/fruit/recall/false_negatives/count"
  input: "evaluation/class/fruit/recall/false_negatives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/fruit/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/add"
  op: "Add"
  input: "evaluation/class/fruit/recall/true_positives/Identity"
  input: "evaluation/class/fruit/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/Greater"
  op: "Greater"
  input: "evaluation/class/fruit/recall/add"
  input: "evaluation/class/fruit/recall/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/add_1"
  op: "Add"
  input: "evaluation/class/fruit/recall/true_positives/Identity"
  input: "evaluation/class/fruit/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/div"
  op: "RealDiv"
  input: "evaluation/class/fruit/recall/true_positives/Identity"
  input: "evaluation/class/fruit/recall/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/value"
  op: "Select"
  input: "evaluation/class/fruit/recall/Greater"
  input: "evaluation/class/fruit/recall/div"
  input: "evaluation/class/fruit/recall/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/add_2"
  op: "Add"
  input: "evaluation/class/fruit/recall/true_positives/AssignAdd"
  input: "evaluation/class/fruit/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/Greater_1"
  op: "Greater"
  input: "evaluation/class/fruit/recall/add_2"
  input: "evaluation/class/fruit/recall/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/add_3"
  op: "Add"
  input: "evaluation/class/fruit/recall/true_positives/AssignAdd"
  input: "evaluation/class/fruit/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/div_1"
  op: "RealDiv"
  input: "evaluation/class/fruit/recall/true_positives/AssignAdd"
  input: "evaluation/class/fruit/recall/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall/update_op"
  op: "Select"
  input: "evaluation/class/fruit/recall/Greater_1"
  input: "evaluation/class/fruit/recall/div_1"
  input: "evaluation/class/fruit/recall/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/recall_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/fruit/recall_1"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/recall_1"
  op: "ScalarSummary"
  input: "evaluation/class/fruit/recall_1/tags"
  input: "evaluation/class/fruit/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/mul"
  op: "Mul"
  input: "evaluation/class/fruit/mul/x"
  input: "evaluation/class/fruit/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/mul_1"
  op: "Mul"
  input: "evaluation/class/fruit/mul"
  input: "evaluation/class/fruit/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/add"
  op: "Add"
  input: "evaluation/class/fruit/recall/value"
  input: "evaluation/class/fruit/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/truediv"
  op: "RealDiv"
  input: "evaluation/class/fruit/mul_1"
  input: "evaluation/class/fruit/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/f1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/fruit/f1"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/f1"
  op: "ScalarSummary"
  input: "evaluation/class/fruit/f1/tags"
  input: "evaluation/class/fruit/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/fruit/Equal"
  op: "Equal"
  input: "evaluation/class/fruit/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/fruit/map_1/TensorArrayStack/TensorArrayGatherV3"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/Cast"
  op: "Cast"
  input: "evaluation/class/fruit/Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/fruit/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/Mean"
  op: "Mean"
  input: "evaluation/class/fruit/Cast"
  input: "evaluation/class/fruit/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/fruit/accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/fruit/accuracy"
      }
    }
  }
}
node {
  name: "evaluation/class/fruit/accuracy"
  op: "ScalarSummary"
  input: "evaluation/class/fruit/accuracy/tags"
  input: "evaluation/class/fruit/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/group_deps_4"
  op: "NoOp"
  input: "^evaluation/class/fruit/recall/update_op"
  input: "^evaluation/class/fruit/precision/update_op"
  input: "^evaluation/class/fruit/Mean"
  input: "^evaluation/class/fruit/truediv"
}
node {
  name: "evaluation/class/blinky/map/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/blinky/map/Shape"
  input: "evaluation/class/blinky/map/strided_slice/stack"
  input: "evaluation/class/blinky/map/strided_slice/stack_1"
  input: "evaluation/class/blinky/map/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/blinky/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/blinky/map/TensorArrayUnstack/Shape"
  input: "evaluation/class/blinky/map/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/blinky/map/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/blinky/map/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/blinky/map/TensorArrayUnstack/range/start"
  input: "evaluation/class/blinky/map/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/blinky/map/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/blinky/map/TensorArray"
  input: "evaluation/class/blinky/map/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_3"
  input: "evaluation/class/blinky/map/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_3"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/blinky/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Enter"
  op: "Enter"
  input: "evaluation/class/blinky/map/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blinky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/blinky/map/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blinky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Merge"
  op: "Merge"
  input: "evaluation/class/blinky/map/while/Enter"
  input: "evaluation/class/blinky/map/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/blinky/map/while/Enter_1"
  input: "evaluation/class/blinky/map/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/blinky/map/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blinky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Less"
  op: "Less"
  input: "evaluation/class/blinky/map/while/Merge"
  input: "evaluation/class/blinky/map/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/blinky/map/while/Less"
}
node {
  name: "evaluation/class/blinky/map/while/Switch"
  op: "Switch"
  input: "evaluation/class/blinky/map/while/Merge"
  input: "evaluation/class/blinky/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/blinky/map/while/Merge_1"
  input: "evaluation/class/blinky/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Identity"
  op: "Identity"
  input: "evaluation/class/blinky/map/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/blinky/map/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/blinky/map/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blinky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/blinky/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blinky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/blinky/map/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/blinky/map/while/Identity"
  input: "evaluation/class/blinky/map/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/blinky/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 5
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Equal"
  op: "Equal"
  input: "evaluation/class/blinky/map/while/TensorArrayReadV3"
  input: "evaluation/class/blinky/map/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/blinky/map/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blinky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/blinky/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/blinky/map/while/Identity"
  input: "evaluation/class/blinky/map/while/Equal"
  input: "evaluation/class/blinky/map/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/add/y"
  op: "Const"
  input: "^evaluation/class/blinky/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/add"
  op: "Add"
  input: "evaluation/class/blinky/map/while/Identity"
  input: "evaluation/class/blinky/map/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/blinky/map/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/blinky/map/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Exit"
  op: "Exit"
  input: "evaluation/class/blinky/map/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/blinky/map/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/blinky/map/TensorArray_1"
  input: "evaluation/class/blinky/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/blinky/map/TensorArrayStack/range/start"
  input: "evaluation/class/blinky/map/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/blinky/map/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/blinky/map/TensorArray_1"
  input: "evaluation/class/blinky/map/TensorArrayStack/range"
  input: "evaluation/class/blinky/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/blinky/map_1/Shape"
  input: "evaluation/class/blinky/map_1/strided_slice/stack"
  input: "evaluation/class/blinky/map_1/strided_slice/stack_1"
  input: "evaluation/class/blinky/map_1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/blinky/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/blinky/map_1/TensorArrayUnstack/Shape"
  input: "evaluation/class/blinky/map_1/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/blinky/map_1/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/blinky/map_1/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/blinky/map_1/TensorArrayUnstack/range/start"
  input: "evaluation/class/blinky/map_1/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/blinky/map_1/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/blinky/map_1/TensorArray"
  input: "evaluation/class/blinky/map_1/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_2"
  input: "evaluation/class/blinky/map_1/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_2"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/blinky/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Enter"
  op: "Enter"
  input: "evaluation/class/blinky/map_1/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blinky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/blinky/map_1/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blinky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Merge"
  op: "Merge"
  input: "evaluation/class/blinky/map_1/while/Enter"
  input: "evaluation/class/blinky/map_1/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/blinky/map_1/while/Enter_1"
  input: "evaluation/class/blinky/map_1/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/blinky/map_1/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blinky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Less"
  op: "Less"
  input: "evaluation/class/blinky/map_1/while/Merge"
  input: "evaluation/class/blinky/map_1/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/blinky/map_1/while/Less"
}
node {
  name: "evaluation/class/blinky/map_1/while/Switch"
  op: "Switch"
  input: "evaluation/class/blinky/map_1/while/Merge"
  input: "evaluation/class/blinky/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map_1/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/blinky/map_1/while/Merge_1"
  input: "evaluation/class/blinky/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map_1/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Identity"
  op: "Identity"
  input: "evaluation/class/blinky/map_1/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/blinky/map_1/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/blinky/map_1/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blinky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/blinky/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blinky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/blinky/map_1/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/blinky/map_1/while/Identity"
  input: "evaluation/class/blinky/map_1/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/blinky/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 5
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Equal"
  op: "Equal"
  input: "evaluation/class/blinky/map_1/while/TensorArrayReadV3"
  input: "evaluation/class/blinky/map_1/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/blinky/map_1/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map_1/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/blinky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/blinky/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/blinky/map_1/while/Identity"
  input: "evaluation/class/blinky/map_1/while/Equal"
  input: "evaluation/class/blinky/map_1/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map_1/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/add/y"
  op: "Const"
  input: "^evaluation/class/blinky/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/add"
  op: "Add"
  input: "evaluation/class/blinky/map_1/while/Identity"
  input: "evaluation/class/blinky/map_1/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/blinky/map_1/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/blinky/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Exit"
  op: "Exit"
  input: "evaluation/class/blinky/map_1/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/blinky/map_1/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/blinky/map_1/TensorArray_1"
  input: "evaluation/class/blinky/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/blinky/map_1/TensorArrayStack/range/start"
  input: "evaluation/class/blinky/map_1/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/blinky/map_1/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/map_1/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/blinky/map_1/TensorArray_1"
  input: "evaluation/class/blinky/map_1/TensorArrayStack/range"
  input: "evaluation/class/blinky/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/blinky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blinky/precision/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/blinky/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blinky/precision/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/blinky/precision/true_positives/Equal"
  input: "evaluation/class/blinky/precision/true_positives/Equal_1"
}
node {
  name: "evaluation/class/blinky/precision/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/blinky/precision/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/blinky/precision/true_positives/count"
  input: "evaluation/class/blinky/precision/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/blinky/precision/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/precision/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/blinky/precision/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/blinky/precision/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/blinky/precision/true_positives/ToFloat"
  input: "evaluation/class/blinky/precision/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/blinky/precision/true_positives/count"
  input: "evaluation/class/blinky/precision/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/Equal"
  op: "Equal"
  input: "evaluation/class/blinky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blinky/precision/false_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/blinky/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blinky/precision/false_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/blinky/precision/false_positives/Equal"
  input: "evaluation/class/blinky/precision/false_positives/Equal_1"
}
node {
  name: "evaluation/class/blinky/precision/false_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/blinky/precision/false_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/blinky/precision/false_positives/count"
  input: "evaluation/class/blinky/precision/false_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/count/read"
  op: "Identity"
  input: "evaluation/class/blinky/precision/false_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/precision/false_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/blinky/precision/false_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/Identity"
  op: "Identity"
  input: "evaluation/class/blinky/precision/false_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/Sum"
  op: "Sum"
  input: "evaluation/class/blinky/precision/false_positives/ToFloat"
  input: "evaluation/class/blinky/precision/false_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/false_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/blinky/precision/false_positives/count"
  input: "evaluation/class/blinky/precision/false_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/add"
  op: "Add"
  input: "evaluation/class/blinky/precision/true_positives/Identity"
  input: "evaluation/class/blinky/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/Greater"
  op: "Greater"
  input: "evaluation/class/blinky/precision/add"
  input: "evaluation/class/blinky/precision/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/add_1"
  op: "Add"
  input: "evaluation/class/blinky/precision/true_positives/Identity"
  input: "evaluation/class/blinky/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/div"
  op: "RealDiv"
  input: "evaluation/class/blinky/precision/true_positives/Identity"
  input: "evaluation/class/blinky/precision/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/value"
  op: "Select"
  input: "evaluation/class/blinky/precision/Greater"
  input: "evaluation/class/blinky/precision/div"
  input: "evaluation/class/blinky/precision/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/add_2"
  op: "Add"
  input: "evaluation/class/blinky/precision/true_positives/AssignAdd"
  input: "evaluation/class/blinky/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/Greater_1"
  op: "Greater"
  input: "evaluation/class/blinky/precision/add_2"
  input: "evaluation/class/blinky/precision/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/add_3"
  op: "Add"
  input: "evaluation/class/blinky/precision/true_positives/AssignAdd"
  input: "evaluation/class/blinky/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/div_1"
  op: "RealDiv"
  input: "evaluation/class/blinky/precision/true_positives/AssignAdd"
  input: "evaluation/class/blinky/precision/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision/update_op"
  op: "Select"
  input: "evaluation/class/blinky/precision/Greater_1"
  input: "evaluation/class/blinky/precision/div_1"
  input: "evaluation/class/blinky/precision/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/precision_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/blinky/precision_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/precision_1"
  op: "ScalarSummary"
  input: "evaluation/class/blinky/precision_1/tags"
  input: "evaluation/class/blinky/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/blinky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blinky/recall/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/blinky/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blinky/recall/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/blinky/recall/true_positives/Equal"
  input: "evaluation/class/blinky/recall/true_positives/Equal_1"
}
node {
  name: "evaluation/class/blinky/recall/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/blinky/recall/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/blinky/recall/true_positives/count"
  input: "evaluation/class/blinky/recall/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/blinky/recall/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/recall/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/blinky/recall/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/blinky/recall/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/blinky/recall/true_positives/ToFloat"
  input: "evaluation/class/blinky/recall/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/blinky/recall/true_positives/count"
  input: "evaluation/class/blinky/recall/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/Equal"
  op: "Equal"
  input: "evaluation/class/blinky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blinky/recall/false_negatives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/Equal_1"
  op: "Equal"
  input: "evaluation/class/blinky/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blinky/recall/false_negatives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/blinky/recall/false_negatives/Equal"
  input: "evaluation/class/blinky/recall/false_negatives/Equal_1"
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/count/Assign"
  op: "Assign"
  input: "evaluation/class/blinky/recall/false_negatives/count"
  input: "evaluation/class/blinky/recall/false_negatives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/count/read"
  op: "Identity"
  input: "evaluation/class/blinky/recall/false_negatives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/recall/false_negatives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/ToFloat"
  op: "Cast"
  input: "evaluation/class/blinky/recall/false_negatives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/Identity"
  op: "Identity"
  input: "evaluation/class/blinky/recall/false_negatives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/Sum"
  op: "Sum"
  input: "evaluation/class/blinky/recall/false_negatives/ToFloat"
  input: "evaluation/class/blinky/recall/false_negatives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/false_negatives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/blinky/recall/false_negatives/count"
  input: "evaluation/class/blinky/recall/false_negatives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/blinky/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/add"
  op: "Add"
  input: "evaluation/class/blinky/recall/true_positives/Identity"
  input: "evaluation/class/blinky/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/Greater"
  op: "Greater"
  input: "evaluation/class/blinky/recall/add"
  input: "evaluation/class/blinky/recall/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/add_1"
  op: "Add"
  input: "evaluation/class/blinky/recall/true_positives/Identity"
  input: "evaluation/class/blinky/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/div"
  op: "RealDiv"
  input: "evaluation/class/blinky/recall/true_positives/Identity"
  input: "evaluation/class/blinky/recall/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/value"
  op: "Select"
  input: "evaluation/class/blinky/recall/Greater"
  input: "evaluation/class/blinky/recall/div"
  input: "evaluation/class/blinky/recall/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/add_2"
  op: "Add"
  input: "evaluation/class/blinky/recall/true_positives/AssignAdd"
  input: "evaluation/class/blinky/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/Greater_1"
  op: "Greater"
  input: "evaluation/class/blinky/recall/add_2"
  input: "evaluation/class/blinky/recall/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/add_3"
  op: "Add"
  input: "evaluation/class/blinky/recall/true_positives/AssignAdd"
  input: "evaluation/class/blinky/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/div_1"
  op: "RealDiv"
  input: "evaluation/class/blinky/recall/true_positives/AssignAdd"
  input: "evaluation/class/blinky/recall/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall/update_op"
  op: "Select"
  input: "evaluation/class/blinky/recall/Greater_1"
  input: "evaluation/class/blinky/recall/div_1"
  input: "evaluation/class/blinky/recall/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/recall_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/blinky/recall_1"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/recall_1"
  op: "ScalarSummary"
  input: "evaluation/class/blinky/recall_1/tags"
  input: "evaluation/class/blinky/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/mul"
  op: "Mul"
  input: "evaluation/class/blinky/mul/x"
  input: "evaluation/class/blinky/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/mul_1"
  op: "Mul"
  input: "evaluation/class/blinky/mul"
  input: "evaluation/class/blinky/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/add"
  op: "Add"
  input: "evaluation/class/blinky/recall/value"
  input: "evaluation/class/blinky/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/truediv"
  op: "RealDiv"
  input: "evaluation/class/blinky/mul_1"
  input: "evaluation/class/blinky/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/f1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/blinky/f1"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/f1"
  op: "ScalarSummary"
  input: "evaluation/class/blinky/f1/tags"
  input: "evaluation/class/blinky/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/blinky/Equal"
  op: "Equal"
  input: "evaluation/class/blinky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/blinky/map_1/TensorArrayStack/TensorArrayGatherV3"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/Cast"
  op: "Cast"
  input: "evaluation/class/blinky/Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/blinky/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/Mean"
  op: "Mean"
  input: "evaluation/class/blinky/Cast"
  input: "evaluation/class/blinky/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/blinky/accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/blinky/accuracy"
      }
    }
  }
}
node {
  name: "evaluation/class/blinky/accuracy"
  op: "ScalarSummary"
  input: "evaluation/class/blinky/accuracy/tags"
  input: "evaluation/class/blinky/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/group_deps_5"
  op: "NoOp"
  input: "^evaluation/class/blinky/recall/update_op"
  input: "^evaluation/class/blinky/precision/update_op"
  input: "^evaluation/class/blinky/Mean"
  input: "^evaluation/class/blinky/truediv"
}
node {
  name: "evaluation/class/inky/map/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/inky/map/Shape"
  input: "evaluation/class/inky/map/strided_slice/stack"
  input: "evaluation/class/inky/map/strided_slice/stack_1"
  input: "evaluation/class/inky/map/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/inky/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/inky/map/TensorArrayUnstack/Shape"
  input: "evaluation/class/inky/map/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/inky/map/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/inky/map/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/inky/map/TensorArrayUnstack/range/start"
  input: "evaluation/class/inky/map/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/inky/map/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/inky/map/TensorArray"
  input: "evaluation/class/inky/map/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_3"
  input: "evaluation/class/inky/map/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_3"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/inky/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Enter"
  op: "Enter"
  input: "evaluation/class/inky/map/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/inky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/inky/map/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/inky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Merge"
  op: "Merge"
  input: "evaluation/class/inky/map/while/Enter"
  input: "evaluation/class/inky/map/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/inky/map/while/Enter_1"
  input: "evaluation/class/inky/map/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/inky/map/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/inky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Less"
  op: "Less"
  input: "evaluation/class/inky/map/while/Merge"
  input: "evaluation/class/inky/map/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/inky/map/while/Less"
}
node {
  name: "evaluation/class/inky/map/while/Switch"
  op: "Switch"
  input: "evaluation/class/inky/map/while/Merge"
  input: "evaluation/class/inky/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/inky/map/while/Merge_1"
  input: "evaluation/class/inky/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Identity"
  op: "Identity"
  input: "evaluation/class/inky/map/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/inky/map/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/inky/map/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/inky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/inky/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/inky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/inky/map/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/inky/map/while/Identity"
  input: "evaluation/class/inky/map/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/inky/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 6
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Equal"
  op: "Equal"
  input: "evaluation/class/inky/map/while/TensorArrayReadV3"
  input: "evaluation/class/inky/map/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/inky/map/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/inky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/inky/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/inky/map/while/Identity"
  input: "evaluation/class/inky/map/while/Equal"
  input: "evaluation/class/inky/map/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/add/y"
  op: "Const"
  input: "^evaluation/class/inky/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/add"
  op: "Add"
  input: "evaluation/class/inky/map/while/Identity"
  input: "evaluation/class/inky/map/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/inky/map/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/inky/map/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Exit"
  op: "Exit"
  input: "evaluation/class/inky/map/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/inky/map/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/inky/map/TensorArray_1"
  input: "evaluation/class/inky/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/inky/map/TensorArrayStack/range/start"
  input: "evaluation/class/inky/map/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/inky/map/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/inky/map/TensorArray_1"
  input: "evaluation/class/inky/map/TensorArrayStack/range"
  input: "evaluation/class/inky/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/inky/map_1/Shape"
  input: "evaluation/class/inky/map_1/strided_slice/stack"
  input: "evaluation/class/inky/map_1/strided_slice/stack_1"
  input: "evaluation/class/inky/map_1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/inky/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/inky/map_1/TensorArrayUnstack/Shape"
  input: "evaluation/class/inky/map_1/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/inky/map_1/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/inky/map_1/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/inky/map_1/TensorArrayUnstack/range/start"
  input: "evaluation/class/inky/map_1/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/inky/map_1/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/inky/map_1/TensorArray"
  input: "evaluation/class/inky/map_1/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_2"
  input: "evaluation/class/inky/map_1/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_2"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/inky/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Enter"
  op: "Enter"
  input: "evaluation/class/inky/map_1/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/inky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/inky/map_1/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/inky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Merge"
  op: "Merge"
  input: "evaluation/class/inky/map_1/while/Enter"
  input: "evaluation/class/inky/map_1/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/inky/map_1/while/Enter_1"
  input: "evaluation/class/inky/map_1/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/inky/map_1/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/inky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Less"
  op: "Less"
  input: "evaluation/class/inky/map_1/while/Merge"
  input: "evaluation/class/inky/map_1/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/inky/map_1/while/Less"
}
node {
  name: "evaluation/class/inky/map_1/while/Switch"
  op: "Switch"
  input: "evaluation/class/inky/map_1/while/Merge"
  input: "evaluation/class/inky/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map_1/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/inky/map_1/while/Merge_1"
  input: "evaluation/class/inky/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map_1/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Identity"
  op: "Identity"
  input: "evaluation/class/inky/map_1/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/inky/map_1/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/inky/map_1/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/inky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/inky/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/inky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/inky/map_1/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/inky/map_1/while/Identity"
  input: "evaluation/class/inky/map_1/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/inky/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 6
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Equal"
  op: "Equal"
  input: "evaluation/class/inky/map_1/while/TensorArrayReadV3"
  input: "evaluation/class/inky/map_1/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/inky/map_1/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map_1/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/inky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/inky/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/inky/map_1/while/Identity"
  input: "evaluation/class/inky/map_1/while/Equal"
  input: "evaluation/class/inky/map_1/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map_1/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/add/y"
  op: "Const"
  input: "^evaluation/class/inky/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/add"
  op: "Add"
  input: "evaluation/class/inky/map_1/while/Identity"
  input: "evaluation/class/inky/map_1/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/inky/map_1/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/inky/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Exit"
  op: "Exit"
  input: "evaluation/class/inky/map_1/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/inky/map_1/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/inky/map_1/TensorArray_1"
  input: "evaluation/class/inky/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/inky/map_1/TensorArrayStack/range/start"
  input: "evaluation/class/inky/map_1/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/inky/map_1/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/map_1/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/inky/map_1/TensorArray_1"
  input: "evaluation/class/inky/map_1/TensorArrayStack/range"
  input: "evaluation/class/inky/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/inky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/inky/precision/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/inky/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/inky/precision/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/inky/precision/true_positives/Equal"
  input: "evaluation/class/inky/precision/true_positives/Equal_1"
}
node {
  name: "evaluation/class/inky/precision/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/inky/precision/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/inky/precision/true_positives/count"
  input: "evaluation/class/inky/precision/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/inky/precision/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/precision/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/inky/precision/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/inky/precision/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/inky/precision/true_positives/ToFloat"
  input: "evaluation/class/inky/precision/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/inky/precision/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/inky/precision/true_positives/count"
  input: "evaluation/class/inky/precision/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/Equal"
  op: "Equal"
  input: "evaluation/class/inky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/inky/precision/false_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/inky/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/inky/precision/false_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/inky/precision/false_positives/Equal"
  input: "evaluation/class/inky/precision/false_positives/Equal_1"
}
node {
  name: "evaluation/class/inky/precision/false_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/inky/precision/false_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/inky/precision/false_positives/count"
  input: "evaluation/class/inky/precision/false_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/count/read"
  op: "Identity"
  input: "evaluation/class/inky/precision/false_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/precision/false_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/inky/precision/false_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/Identity"
  op: "Identity"
  input: "evaluation/class/inky/precision/false_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/Sum"
  op: "Sum"
  input: "evaluation/class/inky/precision/false_positives/ToFloat"
  input: "evaluation/class/inky/precision/false_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/inky/precision/false_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/inky/precision/false_positives/count"
  input: "evaluation/class/inky/precision/false_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/inky/precision/add"
  op: "Add"
  input: "evaluation/class/inky/precision/true_positives/Identity"
  input: "evaluation/class/inky/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/precision/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/Greater"
  op: "Greater"
  input: "evaluation/class/inky/precision/add"
  input: "evaluation/class/inky/precision/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/precision/add_1"
  op: "Add"
  input: "evaluation/class/inky/precision/true_positives/Identity"
  input: "evaluation/class/inky/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/precision/div"
  op: "RealDiv"
  input: "evaluation/class/inky/precision/true_positives/Identity"
  input: "evaluation/class/inky/precision/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/precision/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/value"
  op: "Select"
  input: "evaluation/class/inky/precision/Greater"
  input: "evaluation/class/inky/precision/div"
  input: "evaluation/class/inky/precision/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/precision/add_2"
  op: "Add"
  input: "evaluation/class/inky/precision/true_positives/AssignAdd"
  input: "evaluation/class/inky/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/precision/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/Greater_1"
  op: "Greater"
  input: "evaluation/class/inky/precision/add_2"
  input: "evaluation/class/inky/precision/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/precision/add_3"
  op: "Add"
  input: "evaluation/class/inky/precision/true_positives/AssignAdd"
  input: "evaluation/class/inky/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/precision/div_1"
  op: "RealDiv"
  input: "evaluation/class/inky/precision/true_positives/AssignAdd"
  input: "evaluation/class/inky/precision/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/precision/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision/update_op"
  op: "Select"
  input: "evaluation/class/inky/precision/Greater_1"
  input: "evaluation/class/inky/precision/div_1"
  input: "evaluation/class/inky/precision/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/precision_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/inky/precision_1"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/precision_1"
  op: "ScalarSummary"
  input: "evaluation/class/inky/precision_1/tags"
  input: "evaluation/class/inky/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/inky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/inky/recall/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/inky/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/inky/recall/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/inky/recall/true_positives/Equal"
  input: "evaluation/class/inky/recall/true_positives/Equal_1"
}
node {
  name: "evaluation/class/inky/recall/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/inky/recall/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/inky/recall/true_positives/count"
  input: "evaluation/class/inky/recall/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/inky/recall/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/recall/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/inky/recall/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/inky/recall/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/inky/recall/true_positives/ToFloat"
  input: "evaluation/class/inky/recall/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/inky/recall/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/inky/recall/true_positives/count"
  input: "evaluation/class/inky/recall/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/Equal"
  op: "Equal"
  input: "evaluation/class/inky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/inky/recall/false_negatives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/Equal_1"
  op: "Equal"
  input: "evaluation/class/inky/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/inky/recall/false_negatives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/inky/recall/false_negatives/Equal"
  input: "evaluation/class/inky/recall/false_negatives/Equal_1"
}
node {
  name: "evaluation/class/inky/recall/false_negatives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/inky/recall/false_negatives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/count/Assign"
  op: "Assign"
  input: "evaluation/class/inky/recall/false_negatives/count"
  input: "evaluation/class/inky/recall/false_negatives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/count/read"
  op: "Identity"
  input: "evaluation/class/inky/recall/false_negatives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/recall/false_negatives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/ToFloat"
  op: "Cast"
  input: "evaluation/class/inky/recall/false_negatives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/Identity"
  op: "Identity"
  input: "evaluation/class/inky/recall/false_negatives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/Sum"
  op: "Sum"
  input: "evaluation/class/inky/recall/false_negatives/ToFloat"
  input: "evaluation/class/inky/recall/false_negatives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/inky/recall/false_negatives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/inky/recall/false_negatives/count"
  input: "evaluation/class/inky/recall/false_negatives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/inky/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/inky/recall/add"
  op: "Add"
  input: "evaluation/class/inky/recall/true_positives/Identity"
  input: "evaluation/class/inky/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/Greater"
  op: "Greater"
  input: "evaluation/class/inky/recall/add"
  input: "evaluation/class/inky/recall/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall/add_1"
  op: "Add"
  input: "evaluation/class/inky/recall/true_positives/Identity"
  input: "evaluation/class/inky/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall/div"
  op: "RealDiv"
  input: "evaluation/class/inky/recall/true_positives/Identity"
  input: "evaluation/class/inky/recall/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/value"
  op: "Select"
  input: "evaluation/class/inky/recall/Greater"
  input: "evaluation/class/inky/recall/div"
  input: "evaluation/class/inky/recall/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall/add_2"
  op: "Add"
  input: "evaluation/class/inky/recall/true_positives/AssignAdd"
  input: "evaluation/class/inky/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/Greater_1"
  op: "Greater"
  input: "evaluation/class/inky/recall/add_2"
  input: "evaluation/class/inky/recall/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall/add_3"
  op: "Add"
  input: "evaluation/class/inky/recall/true_positives/AssignAdd"
  input: "evaluation/class/inky/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall/div_1"
  op: "RealDiv"
  input: "evaluation/class/inky/recall/true_positives/AssignAdd"
  input: "evaluation/class/inky/recall/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall/update_op"
  op: "Select"
  input: "evaluation/class/inky/recall/Greater_1"
  input: "evaluation/class/inky/recall/div_1"
  input: "evaluation/class/inky/recall/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/recall_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/inky/recall_1"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/recall_1"
  op: "ScalarSummary"
  input: "evaluation/class/inky/recall_1/tags"
  input: "evaluation/class/inky/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/mul"
  op: "Mul"
  input: "evaluation/class/inky/mul/x"
  input: "evaluation/class/inky/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/mul_1"
  op: "Mul"
  input: "evaluation/class/inky/mul"
  input: "evaluation/class/inky/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/add"
  op: "Add"
  input: "evaluation/class/inky/recall/value"
  input: "evaluation/class/inky/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/truediv"
  op: "RealDiv"
  input: "evaluation/class/inky/mul_1"
  input: "evaluation/class/inky/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/f1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/inky/f1"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/f1"
  op: "ScalarSummary"
  input: "evaluation/class/inky/f1/tags"
  input: "evaluation/class/inky/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/inky/Equal"
  op: "Equal"
  input: "evaluation/class/inky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/inky/map_1/TensorArrayStack/TensorArrayGatherV3"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/Cast"
  op: "Cast"
  input: "evaluation/class/inky/Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/inky/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/inky/Mean"
  op: "Mean"
  input: "evaluation/class/inky/Cast"
  input: "evaluation/class/inky/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/inky/accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/inky/accuracy"
      }
    }
  }
}
node {
  name: "evaluation/class/inky/accuracy"
  op: "ScalarSummary"
  input: "evaluation/class/inky/accuracy/tags"
  input: "evaluation/class/inky/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/group_deps_6"
  op: "NoOp"
  input: "^evaluation/class/inky/recall/update_op"
  input: "^evaluation/class/inky/precision/update_op"
  input: "^evaluation/class/inky/Mean"
  input: "^evaluation/class/inky/truediv"
}
node {
  name: "evaluation/class/pinky/map/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/pinky/map/Shape"
  input: "evaluation/class/pinky/map/strided_slice/stack"
  input: "evaluation/class/pinky/map/strided_slice/stack_1"
  input: "evaluation/class/pinky/map/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/pinky/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/pinky/map/TensorArrayUnstack/Shape"
  input: "evaluation/class/pinky/map/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/pinky/map/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/pinky/map/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/pinky/map/TensorArrayUnstack/range/start"
  input: "evaluation/class/pinky/map/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/pinky/map/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/pinky/map/TensorArray"
  input: "evaluation/class/pinky/map/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_3"
  input: "evaluation/class/pinky/map/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_3"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/pinky/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Enter"
  op: "Enter"
  input: "evaluation/class/pinky/map/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pinky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/pinky/map/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pinky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Merge"
  op: "Merge"
  input: "evaluation/class/pinky/map/while/Enter"
  input: "evaluation/class/pinky/map/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/pinky/map/while/Enter_1"
  input: "evaluation/class/pinky/map/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/pinky/map/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pinky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Less"
  op: "Less"
  input: "evaluation/class/pinky/map/while/Merge"
  input: "evaluation/class/pinky/map/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/pinky/map/while/Less"
}
node {
  name: "evaluation/class/pinky/map/while/Switch"
  op: "Switch"
  input: "evaluation/class/pinky/map/while/Merge"
  input: "evaluation/class/pinky/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/pinky/map/while/Merge_1"
  input: "evaluation/class/pinky/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Identity"
  op: "Identity"
  input: "evaluation/class/pinky/map/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/pinky/map/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/pinky/map/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pinky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/pinky/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pinky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/pinky/map/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/pinky/map/while/Identity"
  input: "evaluation/class/pinky/map/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/pinky/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 7
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Equal"
  op: "Equal"
  input: "evaluation/class/pinky/map/while/TensorArrayReadV3"
  input: "evaluation/class/pinky/map/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/pinky/map/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pinky/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/pinky/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/pinky/map/while/Identity"
  input: "evaluation/class/pinky/map/while/Equal"
  input: "evaluation/class/pinky/map/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/add/y"
  op: "Const"
  input: "^evaluation/class/pinky/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/add"
  op: "Add"
  input: "evaluation/class/pinky/map/while/Identity"
  input: "evaluation/class/pinky/map/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/pinky/map/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/pinky/map/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Exit"
  op: "Exit"
  input: "evaluation/class/pinky/map/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/pinky/map/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/pinky/map/TensorArray_1"
  input: "evaluation/class/pinky/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/pinky/map/TensorArrayStack/range/start"
  input: "evaluation/class/pinky/map/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/pinky/map/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/pinky/map/TensorArray_1"
  input: "evaluation/class/pinky/map/TensorArrayStack/range"
  input: "evaluation/class/pinky/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/pinky/map_1/Shape"
  input: "evaluation/class/pinky/map_1/strided_slice/stack"
  input: "evaluation/class/pinky/map_1/strided_slice/stack_1"
  input: "evaluation/class/pinky/map_1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/pinky/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/pinky/map_1/TensorArrayUnstack/Shape"
  input: "evaluation/class/pinky/map_1/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/pinky/map_1/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/pinky/map_1/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/pinky/map_1/TensorArrayUnstack/range/start"
  input: "evaluation/class/pinky/map_1/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/pinky/map_1/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/pinky/map_1/TensorArray"
  input: "evaluation/class/pinky/map_1/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_2"
  input: "evaluation/class/pinky/map_1/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_2"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/pinky/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Enter"
  op: "Enter"
  input: "evaluation/class/pinky/map_1/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pinky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/pinky/map_1/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pinky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Merge"
  op: "Merge"
  input: "evaluation/class/pinky/map_1/while/Enter"
  input: "evaluation/class/pinky/map_1/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/pinky/map_1/while/Enter_1"
  input: "evaluation/class/pinky/map_1/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/pinky/map_1/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pinky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Less"
  op: "Less"
  input: "evaluation/class/pinky/map_1/while/Merge"
  input: "evaluation/class/pinky/map_1/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/pinky/map_1/while/Less"
}
node {
  name: "evaluation/class/pinky/map_1/while/Switch"
  op: "Switch"
  input: "evaluation/class/pinky/map_1/while/Merge"
  input: "evaluation/class/pinky/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map_1/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/pinky/map_1/while/Merge_1"
  input: "evaluation/class/pinky/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map_1/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Identity"
  op: "Identity"
  input: "evaluation/class/pinky/map_1/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/pinky/map_1/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/pinky/map_1/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pinky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/pinky/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pinky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/pinky/map_1/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/pinky/map_1/while/Identity"
  input: "evaluation/class/pinky/map_1/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/pinky/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 7
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Equal"
  op: "Equal"
  input: "evaluation/class/pinky/map_1/while/TensorArrayReadV3"
  input: "evaluation/class/pinky/map_1/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/pinky/map_1/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map_1/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pinky/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/pinky/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/pinky/map_1/while/Identity"
  input: "evaluation/class/pinky/map_1/while/Equal"
  input: "evaluation/class/pinky/map_1/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map_1/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/add/y"
  op: "Const"
  input: "^evaluation/class/pinky/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/add"
  op: "Add"
  input: "evaluation/class/pinky/map_1/while/Identity"
  input: "evaluation/class/pinky/map_1/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/pinky/map_1/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/pinky/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Exit"
  op: "Exit"
  input: "evaluation/class/pinky/map_1/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/pinky/map_1/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/pinky/map_1/TensorArray_1"
  input: "evaluation/class/pinky/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/pinky/map_1/TensorArrayStack/range/start"
  input: "evaluation/class/pinky/map_1/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/pinky/map_1/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/map_1/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/pinky/map_1/TensorArray_1"
  input: "evaluation/class/pinky/map_1/TensorArrayStack/range"
  input: "evaluation/class/pinky/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/pinky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pinky/precision/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/pinky/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pinky/precision/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/pinky/precision/true_positives/Equal"
  input: "evaluation/class/pinky/precision/true_positives/Equal_1"
}
node {
  name: "evaluation/class/pinky/precision/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/pinky/precision/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/pinky/precision/true_positives/count"
  input: "evaluation/class/pinky/precision/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/pinky/precision/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/precision/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/pinky/precision/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/pinky/precision/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/pinky/precision/true_positives/ToFloat"
  input: "evaluation/class/pinky/precision/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/pinky/precision/true_positives/count"
  input: "evaluation/class/pinky/precision/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/Equal"
  op: "Equal"
  input: "evaluation/class/pinky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pinky/precision/false_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/pinky/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pinky/precision/false_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/pinky/precision/false_positives/Equal"
  input: "evaluation/class/pinky/precision/false_positives/Equal_1"
}
node {
  name: "evaluation/class/pinky/precision/false_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/pinky/precision/false_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/pinky/precision/false_positives/count"
  input: "evaluation/class/pinky/precision/false_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/count/read"
  op: "Identity"
  input: "evaluation/class/pinky/precision/false_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/precision/false_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/pinky/precision/false_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/Identity"
  op: "Identity"
  input: "evaluation/class/pinky/precision/false_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/Sum"
  op: "Sum"
  input: "evaluation/class/pinky/precision/false_positives/ToFloat"
  input: "evaluation/class/pinky/precision/false_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/false_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/pinky/precision/false_positives/count"
  input: "evaluation/class/pinky/precision/false_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/add"
  op: "Add"
  input: "evaluation/class/pinky/precision/true_positives/Identity"
  input: "evaluation/class/pinky/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/Greater"
  op: "Greater"
  input: "evaluation/class/pinky/precision/add"
  input: "evaluation/class/pinky/precision/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/add_1"
  op: "Add"
  input: "evaluation/class/pinky/precision/true_positives/Identity"
  input: "evaluation/class/pinky/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/div"
  op: "RealDiv"
  input: "evaluation/class/pinky/precision/true_positives/Identity"
  input: "evaluation/class/pinky/precision/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/value"
  op: "Select"
  input: "evaluation/class/pinky/precision/Greater"
  input: "evaluation/class/pinky/precision/div"
  input: "evaluation/class/pinky/precision/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/add_2"
  op: "Add"
  input: "evaluation/class/pinky/precision/true_positives/AssignAdd"
  input: "evaluation/class/pinky/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/Greater_1"
  op: "Greater"
  input: "evaluation/class/pinky/precision/add_2"
  input: "evaluation/class/pinky/precision/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/add_3"
  op: "Add"
  input: "evaluation/class/pinky/precision/true_positives/AssignAdd"
  input: "evaluation/class/pinky/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/div_1"
  op: "RealDiv"
  input: "evaluation/class/pinky/precision/true_positives/AssignAdd"
  input: "evaluation/class/pinky/precision/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision/update_op"
  op: "Select"
  input: "evaluation/class/pinky/precision/Greater_1"
  input: "evaluation/class/pinky/precision/div_1"
  input: "evaluation/class/pinky/precision/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/precision_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/pinky/precision_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/precision_1"
  op: "ScalarSummary"
  input: "evaluation/class/pinky/precision_1/tags"
  input: "evaluation/class/pinky/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/pinky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pinky/recall/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/pinky/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pinky/recall/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/pinky/recall/true_positives/Equal"
  input: "evaluation/class/pinky/recall/true_positives/Equal_1"
}
node {
  name: "evaluation/class/pinky/recall/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/pinky/recall/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/pinky/recall/true_positives/count"
  input: "evaluation/class/pinky/recall/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/pinky/recall/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/recall/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/pinky/recall/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/pinky/recall/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/pinky/recall/true_positives/ToFloat"
  input: "evaluation/class/pinky/recall/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/pinky/recall/true_positives/count"
  input: "evaluation/class/pinky/recall/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/Equal"
  op: "Equal"
  input: "evaluation/class/pinky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pinky/recall/false_negatives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/Equal_1"
  op: "Equal"
  input: "evaluation/class/pinky/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pinky/recall/false_negatives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/pinky/recall/false_negatives/Equal"
  input: "evaluation/class/pinky/recall/false_negatives/Equal_1"
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/count/Assign"
  op: "Assign"
  input: "evaluation/class/pinky/recall/false_negatives/count"
  input: "evaluation/class/pinky/recall/false_negatives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/count/read"
  op: "Identity"
  input: "evaluation/class/pinky/recall/false_negatives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/recall/false_negatives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/ToFloat"
  op: "Cast"
  input: "evaluation/class/pinky/recall/false_negatives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/Identity"
  op: "Identity"
  input: "evaluation/class/pinky/recall/false_negatives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/Sum"
  op: "Sum"
  input: "evaluation/class/pinky/recall/false_negatives/ToFloat"
  input: "evaluation/class/pinky/recall/false_negatives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/false_negatives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/pinky/recall/false_negatives/count"
  input: "evaluation/class/pinky/recall/false_negatives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pinky/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/add"
  op: "Add"
  input: "evaluation/class/pinky/recall/true_positives/Identity"
  input: "evaluation/class/pinky/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/Greater"
  op: "Greater"
  input: "evaluation/class/pinky/recall/add"
  input: "evaluation/class/pinky/recall/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/add_1"
  op: "Add"
  input: "evaluation/class/pinky/recall/true_positives/Identity"
  input: "evaluation/class/pinky/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/div"
  op: "RealDiv"
  input: "evaluation/class/pinky/recall/true_positives/Identity"
  input: "evaluation/class/pinky/recall/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/value"
  op: "Select"
  input: "evaluation/class/pinky/recall/Greater"
  input: "evaluation/class/pinky/recall/div"
  input: "evaluation/class/pinky/recall/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/add_2"
  op: "Add"
  input: "evaluation/class/pinky/recall/true_positives/AssignAdd"
  input: "evaluation/class/pinky/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/Greater_1"
  op: "Greater"
  input: "evaluation/class/pinky/recall/add_2"
  input: "evaluation/class/pinky/recall/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/add_3"
  op: "Add"
  input: "evaluation/class/pinky/recall/true_positives/AssignAdd"
  input: "evaluation/class/pinky/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/div_1"
  op: "RealDiv"
  input: "evaluation/class/pinky/recall/true_positives/AssignAdd"
  input: "evaluation/class/pinky/recall/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall/update_op"
  op: "Select"
  input: "evaluation/class/pinky/recall/Greater_1"
  input: "evaluation/class/pinky/recall/div_1"
  input: "evaluation/class/pinky/recall/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/recall_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/pinky/recall_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/recall_1"
  op: "ScalarSummary"
  input: "evaluation/class/pinky/recall_1/tags"
  input: "evaluation/class/pinky/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/mul"
  op: "Mul"
  input: "evaluation/class/pinky/mul/x"
  input: "evaluation/class/pinky/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/mul_1"
  op: "Mul"
  input: "evaluation/class/pinky/mul"
  input: "evaluation/class/pinky/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/add"
  op: "Add"
  input: "evaluation/class/pinky/recall/value"
  input: "evaluation/class/pinky/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/truediv"
  op: "RealDiv"
  input: "evaluation/class/pinky/mul_1"
  input: "evaluation/class/pinky/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/f1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/pinky/f1"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/f1"
  op: "ScalarSummary"
  input: "evaluation/class/pinky/f1/tags"
  input: "evaluation/class/pinky/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pinky/Equal"
  op: "Equal"
  input: "evaluation/class/pinky/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pinky/map_1/TensorArrayStack/TensorArrayGatherV3"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/Cast"
  op: "Cast"
  input: "evaluation/class/pinky/Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pinky/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/Mean"
  op: "Mean"
  input: "evaluation/class/pinky/Cast"
  input: "evaluation/class/pinky/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pinky/accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/pinky/accuracy"
      }
    }
  }
}
node {
  name: "evaluation/class/pinky/accuracy"
  op: "ScalarSummary"
  input: "evaluation/class/pinky/accuracy/tags"
  input: "evaluation/class/pinky/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/group_deps_7"
  op: "NoOp"
  input: "^evaluation/class/pinky/recall/update_op"
  input: "^evaluation/class/pinky/precision/update_op"
  input: "^evaluation/class/pinky/Mean"
  input: "^evaluation/class/pinky/truediv"
}
node {
  name: "evaluation/class/clyde/map/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/clyde/map/Shape"
  input: "evaluation/class/clyde/map/strided_slice/stack"
  input: "evaluation/class/clyde/map/strided_slice/stack_1"
  input: "evaluation/class/clyde/map/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/clyde/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/clyde/map/TensorArrayUnstack/Shape"
  input: "evaluation/class/clyde/map/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/clyde/map/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/clyde/map/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/clyde/map/TensorArrayUnstack/range/start"
  input: "evaluation/class/clyde/map/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/clyde/map/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/clyde/map/TensorArray"
  input: "evaluation/class/clyde/map/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_3"
  input: "evaluation/class/clyde/map/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_3"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/clyde/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Enter"
  op: "Enter"
  input: "evaluation/class/clyde/map/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/clyde/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/clyde/map/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/clyde/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Merge"
  op: "Merge"
  input: "evaluation/class/clyde/map/while/Enter"
  input: "evaluation/class/clyde/map/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/clyde/map/while/Enter_1"
  input: "evaluation/class/clyde/map/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/clyde/map/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/clyde/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Less"
  op: "Less"
  input: "evaluation/class/clyde/map/while/Merge"
  input: "evaluation/class/clyde/map/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/clyde/map/while/Less"
}
node {
  name: "evaluation/class/clyde/map/while/Switch"
  op: "Switch"
  input: "evaluation/class/clyde/map/while/Merge"
  input: "evaluation/class/clyde/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/clyde/map/while/Merge_1"
  input: "evaluation/class/clyde/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Identity"
  op: "Identity"
  input: "evaluation/class/clyde/map/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/clyde/map/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/clyde/map/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/clyde/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/clyde/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/clyde/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/clyde/map/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/clyde/map/while/Identity"
  input: "evaluation/class/clyde/map/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/clyde/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 8
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Equal"
  op: "Equal"
  input: "evaluation/class/clyde/map/while/TensorArrayReadV3"
  input: "evaluation/class/clyde/map/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/clyde/map/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/clyde/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/clyde/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/clyde/map/while/Identity"
  input: "evaluation/class/clyde/map/while/Equal"
  input: "evaluation/class/clyde/map/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/add/y"
  op: "Const"
  input: "^evaluation/class/clyde/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/add"
  op: "Add"
  input: "evaluation/class/clyde/map/while/Identity"
  input: "evaluation/class/clyde/map/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/clyde/map/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/clyde/map/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Exit"
  op: "Exit"
  input: "evaluation/class/clyde/map/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/clyde/map/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/clyde/map/TensorArray_1"
  input: "evaluation/class/clyde/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/clyde/map/TensorArrayStack/range/start"
  input: "evaluation/class/clyde/map/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/clyde/map/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/clyde/map/TensorArray_1"
  input: "evaluation/class/clyde/map/TensorArrayStack/range"
  input: "evaluation/class/clyde/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/clyde/map_1/Shape"
  input: "evaluation/class/clyde/map_1/strided_slice/stack"
  input: "evaluation/class/clyde/map_1/strided_slice/stack_1"
  input: "evaluation/class/clyde/map_1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/clyde/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/clyde/map_1/TensorArrayUnstack/Shape"
  input: "evaluation/class/clyde/map_1/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/clyde/map_1/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/clyde/map_1/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/clyde/map_1/TensorArrayUnstack/range/start"
  input: "evaluation/class/clyde/map_1/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/clyde/map_1/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/clyde/map_1/TensorArray"
  input: "evaluation/class/clyde/map_1/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_2"
  input: "evaluation/class/clyde/map_1/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_2"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/clyde/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Enter"
  op: "Enter"
  input: "evaluation/class/clyde/map_1/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/clyde/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/clyde/map_1/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/clyde/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Merge"
  op: "Merge"
  input: "evaluation/class/clyde/map_1/while/Enter"
  input: "evaluation/class/clyde/map_1/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/clyde/map_1/while/Enter_1"
  input: "evaluation/class/clyde/map_1/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/clyde/map_1/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/clyde/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Less"
  op: "Less"
  input: "evaluation/class/clyde/map_1/while/Merge"
  input: "evaluation/class/clyde/map_1/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/clyde/map_1/while/Less"
}
node {
  name: "evaluation/class/clyde/map_1/while/Switch"
  op: "Switch"
  input: "evaluation/class/clyde/map_1/while/Merge"
  input: "evaluation/class/clyde/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map_1/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/clyde/map_1/while/Merge_1"
  input: "evaluation/class/clyde/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map_1/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Identity"
  op: "Identity"
  input: "evaluation/class/clyde/map_1/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/clyde/map_1/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/clyde/map_1/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/clyde/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/clyde/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/clyde/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/clyde/map_1/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/clyde/map_1/while/Identity"
  input: "evaluation/class/clyde/map_1/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/clyde/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 8
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Equal"
  op: "Equal"
  input: "evaluation/class/clyde/map_1/while/TensorArrayReadV3"
  input: "evaluation/class/clyde/map_1/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/clyde/map_1/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map_1/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/clyde/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/clyde/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/clyde/map_1/while/Identity"
  input: "evaluation/class/clyde/map_1/while/Equal"
  input: "evaluation/class/clyde/map_1/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map_1/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/add/y"
  op: "Const"
  input: "^evaluation/class/clyde/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/add"
  op: "Add"
  input: "evaluation/class/clyde/map_1/while/Identity"
  input: "evaluation/class/clyde/map_1/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/clyde/map_1/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/clyde/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Exit"
  op: "Exit"
  input: "evaluation/class/clyde/map_1/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/clyde/map_1/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/clyde/map_1/TensorArray_1"
  input: "evaluation/class/clyde/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/clyde/map_1/TensorArrayStack/range/start"
  input: "evaluation/class/clyde/map_1/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/clyde/map_1/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/map_1/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/clyde/map_1/TensorArray_1"
  input: "evaluation/class/clyde/map_1/TensorArrayStack/range"
  input: "evaluation/class/clyde/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/clyde/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/clyde/precision/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/clyde/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/clyde/precision/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/clyde/precision/true_positives/Equal"
  input: "evaluation/class/clyde/precision/true_positives/Equal_1"
}
node {
  name: "evaluation/class/clyde/precision/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/clyde/precision/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/clyde/precision/true_positives/count"
  input: "evaluation/class/clyde/precision/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/clyde/precision/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/precision/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/clyde/precision/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/clyde/precision/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/clyde/precision/true_positives/ToFloat"
  input: "evaluation/class/clyde/precision/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/clyde/precision/true_positives/count"
  input: "evaluation/class/clyde/precision/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/Equal"
  op: "Equal"
  input: "evaluation/class/clyde/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/clyde/precision/false_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/clyde/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/clyde/precision/false_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/clyde/precision/false_positives/Equal"
  input: "evaluation/class/clyde/precision/false_positives/Equal_1"
}
node {
  name: "evaluation/class/clyde/precision/false_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/clyde/precision/false_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/clyde/precision/false_positives/count"
  input: "evaluation/class/clyde/precision/false_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/count/read"
  op: "Identity"
  input: "evaluation/class/clyde/precision/false_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/precision/false_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/clyde/precision/false_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/Identity"
  op: "Identity"
  input: "evaluation/class/clyde/precision/false_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/Sum"
  op: "Sum"
  input: "evaluation/class/clyde/precision/false_positives/ToFloat"
  input: "evaluation/class/clyde/precision/false_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/false_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/clyde/precision/false_positives/count"
  input: "evaluation/class/clyde/precision/false_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/add"
  op: "Add"
  input: "evaluation/class/clyde/precision/true_positives/Identity"
  input: "evaluation/class/clyde/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/Greater"
  op: "Greater"
  input: "evaluation/class/clyde/precision/add"
  input: "evaluation/class/clyde/precision/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/add_1"
  op: "Add"
  input: "evaluation/class/clyde/precision/true_positives/Identity"
  input: "evaluation/class/clyde/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/div"
  op: "RealDiv"
  input: "evaluation/class/clyde/precision/true_positives/Identity"
  input: "evaluation/class/clyde/precision/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/value"
  op: "Select"
  input: "evaluation/class/clyde/precision/Greater"
  input: "evaluation/class/clyde/precision/div"
  input: "evaluation/class/clyde/precision/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/add_2"
  op: "Add"
  input: "evaluation/class/clyde/precision/true_positives/AssignAdd"
  input: "evaluation/class/clyde/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/Greater_1"
  op: "Greater"
  input: "evaluation/class/clyde/precision/add_2"
  input: "evaluation/class/clyde/precision/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/add_3"
  op: "Add"
  input: "evaluation/class/clyde/precision/true_positives/AssignAdd"
  input: "evaluation/class/clyde/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/div_1"
  op: "RealDiv"
  input: "evaluation/class/clyde/precision/true_positives/AssignAdd"
  input: "evaluation/class/clyde/precision/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision/update_op"
  op: "Select"
  input: "evaluation/class/clyde/precision/Greater_1"
  input: "evaluation/class/clyde/precision/div_1"
  input: "evaluation/class/clyde/precision/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/precision_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/clyde/precision_1"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/precision_1"
  op: "ScalarSummary"
  input: "evaluation/class/clyde/precision_1/tags"
  input: "evaluation/class/clyde/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/clyde/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/clyde/recall/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/clyde/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/clyde/recall/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/clyde/recall/true_positives/Equal"
  input: "evaluation/class/clyde/recall/true_positives/Equal_1"
}
node {
  name: "evaluation/class/clyde/recall/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/clyde/recall/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/clyde/recall/true_positives/count"
  input: "evaluation/class/clyde/recall/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/clyde/recall/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/recall/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/clyde/recall/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/clyde/recall/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/clyde/recall/true_positives/ToFloat"
  input: "evaluation/class/clyde/recall/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/clyde/recall/true_positives/count"
  input: "evaluation/class/clyde/recall/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/Equal"
  op: "Equal"
  input: "evaluation/class/clyde/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/clyde/recall/false_negatives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/Equal_1"
  op: "Equal"
  input: "evaluation/class/clyde/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/clyde/recall/false_negatives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/clyde/recall/false_negatives/Equal"
  input: "evaluation/class/clyde/recall/false_negatives/Equal_1"
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/count/Assign"
  op: "Assign"
  input: "evaluation/class/clyde/recall/false_negatives/count"
  input: "evaluation/class/clyde/recall/false_negatives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/count/read"
  op: "Identity"
  input: "evaluation/class/clyde/recall/false_negatives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/recall/false_negatives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/ToFloat"
  op: "Cast"
  input: "evaluation/class/clyde/recall/false_negatives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/Identity"
  op: "Identity"
  input: "evaluation/class/clyde/recall/false_negatives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/Sum"
  op: "Sum"
  input: "evaluation/class/clyde/recall/false_negatives/ToFloat"
  input: "evaluation/class/clyde/recall/false_negatives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/false_negatives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/clyde/recall/false_negatives/count"
  input: "evaluation/class/clyde/recall/false_negatives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/clyde/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/add"
  op: "Add"
  input: "evaluation/class/clyde/recall/true_positives/Identity"
  input: "evaluation/class/clyde/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/Greater"
  op: "Greater"
  input: "evaluation/class/clyde/recall/add"
  input: "evaluation/class/clyde/recall/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/add_1"
  op: "Add"
  input: "evaluation/class/clyde/recall/true_positives/Identity"
  input: "evaluation/class/clyde/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/div"
  op: "RealDiv"
  input: "evaluation/class/clyde/recall/true_positives/Identity"
  input: "evaluation/class/clyde/recall/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/value"
  op: "Select"
  input: "evaluation/class/clyde/recall/Greater"
  input: "evaluation/class/clyde/recall/div"
  input: "evaluation/class/clyde/recall/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/add_2"
  op: "Add"
  input: "evaluation/class/clyde/recall/true_positives/AssignAdd"
  input: "evaluation/class/clyde/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/Greater_1"
  op: "Greater"
  input: "evaluation/class/clyde/recall/add_2"
  input: "evaluation/class/clyde/recall/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/add_3"
  op: "Add"
  input: "evaluation/class/clyde/recall/true_positives/AssignAdd"
  input: "evaluation/class/clyde/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/div_1"
  op: "RealDiv"
  input: "evaluation/class/clyde/recall/true_positives/AssignAdd"
  input: "evaluation/class/clyde/recall/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall/update_op"
  op: "Select"
  input: "evaluation/class/clyde/recall/Greater_1"
  input: "evaluation/class/clyde/recall/div_1"
  input: "evaluation/class/clyde/recall/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/recall_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/clyde/recall_1"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/recall_1"
  op: "ScalarSummary"
  input: "evaluation/class/clyde/recall_1/tags"
  input: "evaluation/class/clyde/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/mul"
  op: "Mul"
  input: "evaluation/class/clyde/mul/x"
  input: "evaluation/class/clyde/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/mul_1"
  op: "Mul"
  input: "evaluation/class/clyde/mul"
  input: "evaluation/class/clyde/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/add"
  op: "Add"
  input: "evaluation/class/clyde/recall/value"
  input: "evaluation/class/clyde/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/truediv"
  op: "RealDiv"
  input: "evaluation/class/clyde/mul_1"
  input: "evaluation/class/clyde/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/f1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/clyde/f1"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/f1"
  op: "ScalarSummary"
  input: "evaluation/class/clyde/f1/tags"
  input: "evaluation/class/clyde/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/clyde/Equal"
  op: "Equal"
  input: "evaluation/class/clyde/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/clyde/map_1/TensorArrayStack/TensorArrayGatherV3"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/Cast"
  op: "Cast"
  input: "evaluation/class/clyde/Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/clyde/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/Mean"
  op: "Mean"
  input: "evaluation/class/clyde/Cast"
  input: "evaluation/class/clyde/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/clyde/accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/clyde/accuracy"
      }
    }
  }
}
node {
  name: "evaluation/class/clyde/accuracy"
  op: "ScalarSummary"
  input: "evaluation/class/clyde/accuracy/tags"
  input: "evaluation/class/clyde/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/group_deps_8"
  op: "NoOp"
  input: "^evaluation/class/clyde/recall/update_op"
  input: "^evaluation/class/clyde/precision/update_op"
  input: "^evaluation/class/clyde/Mean"
  input: "^evaluation/class/clyde/truediv"
}
node {
  name: "evaluation/class/frightened_ghost/map/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/frightened_ghost/map/Shape"
  input: "evaluation/class/frightened_ghost/map/strided_slice/stack"
  input: "evaluation/class/frightened_ghost/map/strided_slice/stack_1"
  input: "evaluation/class/frightened_ghost/map/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/frightened_ghost/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/Shape"
  input: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/range/start"
  input: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/frightened_ghost/map/TensorArray"
  input: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_3"
  input: "evaluation/class/frightened_ghost/map/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_3"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/frightened_ghost/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Enter"
  op: "Enter"
  input: "evaluation/class/frightened_ghost/map/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/frightened_ghost/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/frightened_ghost/map/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/frightened_ghost/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Merge"
  op: "Merge"
  input: "evaluation/class/frightened_ghost/map/while/Enter"
  input: "evaluation/class/frightened_ghost/map/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/frightened_ghost/map/while/Enter_1"
  input: "evaluation/class/frightened_ghost/map/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/frightened_ghost/map/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/frightened_ghost/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Less"
  op: "Less"
  input: "evaluation/class/frightened_ghost/map/while/Merge"
  input: "evaluation/class/frightened_ghost/map/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/frightened_ghost/map/while/Less"
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Switch"
  op: "Switch"
  input: "evaluation/class/frightened_ghost/map/while/Merge"
  input: "evaluation/class/frightened_ghost/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/frightened_ghost/map/while/Merge_1"
  input: "evaluation/class/frightened_ghost/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Identity"
  op: "Identity"
  input: "evaluation/class/frightened_ghost/map/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/frightened_ghost/map/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/frightened_ghost/map/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/frightened_ghost/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/frightened_ghost/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/frightened_ghost/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/frightened_ghost/map/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/frightened_ghost/map/while/Identity"
  input: "evaluation/class/frightened_ghost/map/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/frightened_ghost/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 9
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Equal"
  op: "Equal"
  input: "evaluation/class/frightened_ghost/map/while/TensorArrayReadV3"
  input: "evaluation/class/frightened_ghost/map/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/frightened_ghost/map/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/frightened_ghost/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/frightened_ghost/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/frightened_ghost/map/while/Identity"
  input: "evaluation/class/frightened_ghost/map/while/Equal"
  input: "evaluation/class/frightened_ghost/map/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/add/y"
  op: "Const"
  input: "^evaluation/class/frightened_ghost/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/add"
  op: "Add"
  input: "evaluation/class/frightened_ghost/map/while/Identity"
  input: "evaluation/class/frightened_ghost/map/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/frightened_ghost/map/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/frightened_ghost/map/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Exit"
  op: "Exit"
  input: "evaluation/class/frightened_ghost/map/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/frightened_ghost/map/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/frightened_ghost/map/TensorArray_1"
  input: "evaluation/class/frightened_ghost/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/frightened_ghost/map/TensorArrayStack/range/start"
  input: "evaluation/class/frightened_ghost/map/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/frightened_ghost/map/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/frightened_ghost/map/TensorArray_1"
  input: "evaluation/class/frightened_ghost/map/TensorArrayStack/range"
  input: "evaluation/class/frightened_ghost/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/frightened_ghost/map_1/Shape"
  input: "evaluation/class/frightened_ghost/map_1/strided_slice/stack"
  input: "evaluation/class/frightened_ghost/map_1/strided_slice/stack_1"
  input: "evaluation/class/frightened_ghost/map_1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/frightened_ghost/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/Shape"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/range/start"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/frightened_ghost/map_1/TensorArray"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_2"
  input: "evaluation/class/frightened_ghost/map_1/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_2"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/frightened_ghost/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Enter"
  op: "Enter"
  input: "evaluation/class/frightened_ghost/map_1/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/frightened_ghost/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/frightened_ghost/map_1/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/frightened_ghost/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Merge"
  op: "Merge"
  input: "evaluation/class/frightened_ghost/map_1/while/Enter"
  input: "evaluation/class/frightened_ghost/map_1/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/frightened_ghost/map_1/while/Enter_1"
  input: "evaluation/class/frightened_ghost/map_1/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/frightened_ghost/map_1/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/frightened_ghost/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Less"
  op: "Less"
  input: "evaluation/class/frightened_ghost/map_1/while/Merge"
  input: "evaluation/class/frightened_ghost/map_1/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/frightened_ghost/map_1/while/Less"
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Switch"
  op: "Switch"
  input: "evaluation/class/frightened_ghost/map_1/while/Merge"
  input: "evaluation/class/frightened_ghost/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map_1/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/frightened_ghost/map_1/while/Merge_1"
  input: "evaluation/class/frightened_ghost/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map_1/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Identity"
  op: "Identity"
  input: "evaluation/class/frightened_ghost/map_1/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/frightened_ghost/map_1/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/frightened_ghost/map_1/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/frightened_ghost/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/frightened_ghost/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/frightened_ghost/map_1/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/frightened_ghost/map_1/while/Identity"
  input: "evaluation/class/frightened_ghost/map_1/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/frightened_ghost/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 9
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Equal"
  op: "Equal"
  input: "evaluation/class/frightened_ghost/map_1/while/TensorArrayReadV3"
  input: "evaluation/class/frightened_ghost/map_1/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/frightened_ghost/map_1/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map_1/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/frightened_ghost/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/frightened_ghost/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/frightened_ghost/map_1/while/Identity"
  input: "evaluation/class/frightened_ghost/map_1/while/Equal"
  input: "evaluation/class/frightened_ghost/map_1/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map_1/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/add/y"
  op: "Const"
  input: "^evaluation/class/frightened_ghost/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/add"
  op: "Add"
  input: "evaluation/class/frightened_ghost/map_1/while/Identity"
  input: "evaluation/class/frightened_ghost/map_1/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/frightened_ghost/map_1/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/frightened_ghost/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Exit"
  op: "Exit"
  input: "evaluation/class/frightened_ghost/map_1/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/frightened_ghost/map_1/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/frightened_ghost/map_1/TensorArray_1"
  input: "evaluation/class/frightened_ghost/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/range/start"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/frightened_ghost/map_1/TensorArray_1"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/range"
  input: "evaluation/class/frightened_ghost/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/frightened_ghost/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/frightened_ghost/precision/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/frightened_ghost/precision/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/frightened_ghost/precision/true_positives/Equal"
  input: "evaluation/class/frightened_ghost/precision/true_positives/Equal_1"
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/frightened_ghost/precision/true_positives/count"
  input: "evaluation/class/frightened_ghost/precision/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/frightened_ghost/precision/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/precision/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/frightened_ghost/precision/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/frightened_ghost/precision/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/frightened_ghost/precision/true_positives/ToFloat"
  input: "evaluation/class/frightened_ghost/precision/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/frightened_ghost/precision/true_positives/count"
  input: "evaluation/class/frightened_ghost/precision/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/Equal"
  op: "Equal"
  input: "evaluation/class/frightened_ghost/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/frightened_ghost/precision/false_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/frightened_ghost/precision/false_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/frightened_ghost/precision/false_positives/Equal"
  input: "evaluation/class/frightened_ghost/precision/false_positives/Equal_1"
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/frightened_ghost/precision/false_positives/count"
  input: "evaluation/class/frightened_ghost/precision/false_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/count/read"
  op: "Identity"
  input: "evaluation/class/frightened_ghost/precision/false_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/precision/false_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/frightened_ghost/precision/false_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/Identity"
  op: "Identity"
  input: "evaluation/class/frightened_ghost/precision/false_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/Sum"
  op: "Sum"
  input: "evaluation/class/frightened_ghost/precision/false_positives/ToFloat"
  input: "evaluation/class/frightened_ghost/precision/false_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/false_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/frightened_ghost/precision/false_positives/count"
  input: "evaluation/class/frightened_ghost/precision/false_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/add"
  op: "Add"
  input: "evaluation/class/frightened_ghost/precision/true_positives/Identity"
  input: "evaluation/class/frightened_ghost/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/Greater"
  op: "Greater"
  input: "evaluation/class/frightened_ghost/precision/add"
  input: "evaluation/class/frightened_ghost/precision/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/add_1"
  op: "Add"
  input: "evaluation/class/frightened_ghost/precision/true_positives/Identity"
  input: "evaluation/class/frightened_ghost/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/div"
  op: "RealDiv"
  input: "evaluation/class/frightened_ghost/precision/true_positives/Identity"
  input: "evaluation/class/frightened_ghost/precision/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/value"
  op: "Select"
  input: "evaluation/class/frightened_ghost/precision/Greater"
  input: "evaluation/class/frightened_ghost/precision/div"
  input: "evaluation/class/frightened_ghost/precision/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/add_2"
  op: "Add"
  input: "evaluation/class/frightened_ghost/precision/true_positives/AssignAdd"
  input: "evaluation/class/frightened_ghost/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/Greater_1"
  op: "Greater"
  input: "evaluation/class/frightened_ghost/precision/add_2"
  input: "evaluation/class/frightened_ghost/precision/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/add_3"
  op: "Add"
  input: "evaluation/class/frightened_ghost/precision/true_positives/AssignAdd"
  input: "evaluation/class/frightened_ghost/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/div_1"
  op: "RealDiv"
  input: "evaluation/class/frightened_ghost/precision/true_positives/AssignAdd"
  input: "evaluation/class/frightened_ghost/precision/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision/update_op"
  op: "Select"
  input: "evaluation/class/frightened_ghost/precision/Greater_1"
  input: "evaluation/class/frightened_ghost/precision/div_1"
  input: "evaluation/class/frightened_ghost/precision/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/frightened_ghost/precision_1"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/precision_1"
  op: "ScalarSummary"
  input: "evaluation/class/frightened_ghost/precision_1/tags"
  input: "evaluation/class/frightened_ghost/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/frightened_ghost/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/frightened_ghost/recall/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/frightened_ghost/recall/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/frightened_ghost/recall/true_positives/Equal"
  input: "evaluation/class/frightened_ghost/recall/true_positives/Equal_1"
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/frightened_ghost/recall/true_positives/count"
  input: "evaluation/class/frightened_ghost/recall/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/frightened_ghost/recall/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/recall/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/frightened_ghost/recall/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/frightened_ghost/recall/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/frightened_ghost/recall/true_positives/ToFloat"
  input: "evaluation/class/frightened_ghost/recall/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/frightened_ghost/recall/true_positives/count"
  input: "evaluation/class/frightened_ghost/recall/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/Equal"
  op: "Equal"
  input: "evaluation/class/frightened_ghost/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/Equal_1"
  op: "Equal"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/Equal"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/Equal_1"
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/count/Assign"
  op: "Assign"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/count"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/count/read"
  op: "Identity"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/recall/false_negatives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/ToFloat"
  op: "Cast"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/Identity"
  op: "Identity"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/Sum"
  op: "Sum"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/ToFloat"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/false_negatives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/count"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/frightened_ghost/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/add"
  op: "Add"
  input: "evaluation/class/frightened_ghost/recall/true_positives/Identity"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/Greater"
  op: "Greater"
  input: "evaluation/class/frightened_ghost/recall/add"
  input: "evaluation/class/frightened_ghost/recall/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/add_1"
  op: "Add"
  input: "evaluation/class/frightened_ghost/recall/true_positives/Identity"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/div"
  op: "RealDiv"
  input: "evaluation/class/frightened_ghost/recall/true_positives/Identity"
  input: "evaluation/class/frightened_ghost/recall/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/value"
  op: "Select"
  input: "evaluation/class/frightened_ghost/recall/Greater"
  input: "evaluation/class/frightened_ghost/recall/div"
  input: "evaluation/class/frightened_ghost/recall/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/add_2"
  op: "Add"
  input: "evaluation/class/frightened_ghost/recall/true_positives/AssignAdd"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/Greater_1"
  op: "Greater"
  input: "evaluation/class/frightened_ghost/recall/add_2"
  input: "evaluation/class/frightened_ghost/recall/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/add_3"
  op: "Add"
  input: "evaluation/class/frightened_ghost/recall/true_positives/AssignAdd"
  input: "evaluation/class/frightened_ghost/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/div_1"
  op: "RealDiv"
  input: "evaluation/class/frightened_ghost/recall/true_positives/AssignAdd"
  input: "evaluation/class/frightened_ghost/recall/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall/update_op"
  op: "Select"
  input: "evaluation/class/frightened_ghost/recall/Greater_1"
  input: "evaluation/class/frightened_ghost/recall/div_1"
  input: "evaluation/class/frightened_ghost/recall/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/frightened_ghost/recall_1"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/recall_1"
  op: "ScalarSummary"
  input: "evaluation/class/frightened_ghost/recall_1/tags"
  input: "evaluation/class/frightened_ghost/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/mul"
  op: "Mul"
  input: "evaluation/class/frightened_ghost/mul/x"
  input: "evaluation/class/frightened_ghost/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/mul_1"
  op: "Mul"
  input: "evaluation/class/frightened_ghost/mul"
  input: "evaluation/class/frightened_ghost/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/add"
  op: "Add"
  input: "evaluation/class/frightened_ghost/recall/value"
  input: "evaluation/class/frightened_ghost/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/truediv"
  op: "RealDiv"
  input: "evaluation/class/frightened_ghost/mul_1"
  input: "evaluation/class/frightened_ghost/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/f1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/frightened_ghost/f1"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/f1"
  op: "ScalarSummary"
  input: "evaluation/class/frightened_ghost/f1/tags"
  input: "evaluation/class/frightened_ghost/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/Equal"
  op: "Equal"
  input: "evaluation/class/frightened_ghost/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/frightened_ghost/map_1/TensorArrayStack/TensorArrayGatherV3"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/Cast"
  op: "Cast"
  input: "evaluation/class/frightened_ghost/Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/Mean"
  op: "Mean"
  input: "evaluation/class/frightened_ghost/Cast"
  input: "evaluation/class/frightened_ghost/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/frightened_ghost/accuracy"
      }
    }
  }
}
node {
  name: "evaluation/class/frightened_ghost/accuracy"
  op: "ScalarSummary"
  input: "evaluation/class/frightened_ghost/accuracy/tags"
  input: "evaluation/class/frightened_ghost/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/group_deps_9"
  op: "NoOp"
  input: "^evaluation/class/frightened_ghost/recall/update_op"
  input: "^evaluation/class/frightened_ghost/precision/update_op"
  input: "^evaluation/class/frightened_ghost/Mean"
  input: "^evaluation/class/frightened_ghost/truediv"
}
node {
  name: "evaluation/class/pellet/map/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/pellet/map/Shape"
  input: "evaluation/class/pellet/map/strided_slice/stack"
  input: "evaluation/class/pellet/map/strided_slice/stack_1"
  input: "evaluation/class/pellet/map/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/pellet/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/pellet/map/TensorArrayUnstack/Shape"
  input: "evaluation/class/pellet/map/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/pellet/map/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/pellet/map/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/pellet/map/TensorArrayUnstack/range/start"
  input: "evaluation/class/pellet/map/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/pellet/map/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/pellet/map/TensorArray"
  input: "evaluation/class/pellet/map/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_3"
  input: "evaluation/class/pellet/map/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_3"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/pellet/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Enter"
  op: "Enter"
  input: "evaluation/class/pellet/map/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pellet/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/pellet/map/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pellet/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Merge"
  op: "Merge"
  input: "evaluation/class/pellet/map/while/Enter"
  input: "evaluation/class/pellet/map/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/pellet/map/while/Enter_1"
  input: "evaluation/class/pellet/map/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/pellet/map/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pellet/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Less"
  op: "Less"
  input: "evaluation/class/pellet/map/while/Merge"
  input: "evaluation/class/pellet/map/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/pellet/map/while/Less"
}
node {
  name: "evaluation/class/pellet/map/while/Switch"
  op: "Switch"
  input: "evaluation/class/pellet/map/while/Merge"
  input: "evaluation/class/pellet/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/pellet/map/while/Merge_1"
  input: "evaluation/class/pellet/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Identity"
  op: "Identity"
  input: "evaluation/class/pellet/map/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/pellet/map/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/pellet/map/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pellet/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/pellet/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pellet/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/pellet/map/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/pellet/map/while/Identity"
  input: "evaluation/class/pellet/map/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/pellet/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 10
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Equal"
  op: "Equal"
  input: "evaluation/class/pellet/map/while/TensorArrayReadV3"
  input: "evaluation/class/pellet/map/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/pellet/map/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pellet/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/pellet/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/pellet/map/while/Identity"
  input: "evaluation/class/pellet/map/while/Equal"
  input: "evaluation/class/pellet/map/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/add/y"
  op: "Const"
  input: "^evaluation/class/pellet/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/add"
  op: "Add"
  input: "evaluation/class/pellet/map/while/Identity"
  input: "evaluation/class/pellet/map/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/pellet/map/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/pellet/map/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Exit"
  op: "Exit"
  input: "evaluation/class/pellet/map/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/pellet/map/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/pellet/map/TensorArray_1"
  input: "evaluation/class/pellet/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/pellet/map/TensorArrayStack/range/start"
  input: "evaluation/class/pellet/map/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/pellet/map/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/pellet/map/TensorArray_1"
  input: "evaluation/class/pellet/map/TensorArrayStack/range"
  input: "evaluation/class/pellet/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/pellet/map_1/Shape"
  input: "evaluation/class/pellet/map_1/strided_slice/stack"
  input: "evaluation/class/pellet/map_1/strided_slice/stack_1"
  input: "evaluation/class/pellet/map_1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/pellet/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/pellet/map_1/TensorArrayUnstack/Shape"
  input: "evaluation/class/pellet/map_1/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/pellet/map_1/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/pellet/map_1/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/pellet/map_1/TensorArrayUnstack/range/start"
  input: "evaluation/class/pellet/map_1/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/pellet/map_1/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/pellet/map_1/TensorArray"
  input: "evaluation/class/pellet/map_1/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_2"
  input: "evaluation/class/pellet/map_1/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_2"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/pellet/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Enter"
  op: "Enter"
  input: "evaluation/class/pellet/map_1/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pellet/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/pellet/map_1/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pellet/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Merge"
  op: "Merge"
  input: "evaluation/class/pellet/map_1/while/Enter"
  input: "evaluation/class/pellet/map_1/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/pellet/map_1/while/Enter_1"
  input: "evaluation/class/pellet/map_1/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/pellet/map_1/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pellet/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Less"
  op: "Less"
  input: "evaluation/class/pellet/map_1/while/Merge"
  input: "evaluation/class/pellet/map_1/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/pellet/map_1/while/Less"
}
node {
  name: "evaluation/class/pellet/map_1/while/Switch"
  op: "Switch"
  input: "evaluation/class/pellet/map_1/while/Merge"
  input: "evaluation/class/pellet/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map_1/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/pellet/map_1/while/Merge_1"
  input: "evaluation/class/pellet/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map_1/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Identity"
  op: "Identity"
  input: "evaluation/class/pellet/map_1/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/pellet/map_1/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/pellet/map_1/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pellet/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/pellet/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pellet/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/pellet/map_1/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/pellet/map_1/while/Identity"
  input: "evaluation/class/pellet/map_1/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/pellet/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 10
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Equal"
  op: "Equal"
  input: "evaluation/class/pellet/map_1/while/TensorArrayReadV3"
  input: "evaluation/class/pellet/map_1/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/pellet/map_1/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map_1/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/pellet/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/pellet/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/pellet/map_1/while/Identity"
  input: "evaluation/class/pellet/map_1/while/Equal"
  input: "evaluation/class/pellet/map_1/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map_1/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/add/y"
  op: "Const"
  input: "^evaluation/class/pellet/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/add"
  op: "Add"
  input: "evaluation/class/pellet/map_1/while/Identity"
  input: "evaluation/class/pellet/map_1/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/pellet/map_1/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/pellet/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Exit"
  op: "Exit"
  input: "evaluation/class/pellet/map_1/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/pellet/map_1/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/pellet/map_1/TensorArray_1"
  input: "evaluation/class/pellet/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/pellet/map_1/TensorArrayStack/range/start"
  input: "evaluation/class/pellet/map_1/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/pellet/map_1/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/map_1/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/pellet/map_1/TensorArray_1"
  input: "evaluation/class/pellet/map_1/TensorArrayStack/range"
  input: "evaluation/class/pellet/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/pellet/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pellet/precision/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/pellet/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pellet/precision/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/pellet/precision/true_positives/Equal"
  input: "evaluation/class/pellet/precision/true_positives/Equal_1"
}
node {
  name: "evaluation/class/pellet/precision/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/pellet/precision/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/pellet/precision/true_positives/count"
  input: "evaluation/class/pellet/precision/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/pellet/precision/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/precision/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/pellet/precision/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/pellet/precision/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/pellet/precision/true_positives/ToFloat"
  input: "evaluation/class/pellet/precision/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/pellet/precision/true_positives/count"
  input: "evaluation/class/pellet/precision/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/Equal"
  op: "Equal"
  input: "evaluation/class/pellet/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pellet/precision/false_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/pellet/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pellet/precision/false_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/pellet/precision/false_positives/Equal"
  input: "evaluation/class/pellet/precision/false_positives/Equal_1"
}
node {
  name: "evaluation/class/pellet/precision/false_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/pellet/precision/false_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/pellet/precision/false_positives/count"
  input: "evaluation/class/pellet/precision/false_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/count/read"
  op: "Identity"
  input: "evaluation/class/pellet/precision/false_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/precision/false_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/pellet/precision/false_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/Identity"
  op: "Identity"
  input: "evaluation/class/pellet/precision/false_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/Sum"
  op: "Sum"
  input: "evaluation/class/pellet/precision/false_positives/ToFloat"
  input: "evaluation/class/pellet/precision/false_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/false_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/pellet/precision/false_positives/count"
  input: "evaluation/class/pellet/precision/false_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/precision/false_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/add"
  op: "Add"
  input: "evaluation/class/pellet/precision/true_positives/Identity"
  input: "evaluation/class/pellet/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/Greater"
  op: "Greater"
  input: "evaluation/class/pellet/precision/add"
  input: "evaluation/class/pellet/precision/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/add_1"
  op: "Add"
  input: "evaluation/class/pellet/precision/true_positives/Identity"
  input: "evaluation/class/pellet/precision/false_positives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/div"
  op: "RealDiv"
  input: "evaluation/class/pellet/precision/true_positives/Identity"
  input: "evaluation/class/pellet/precision/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/value"
  op: "Select"
  input: "evaluation/class/pellet/precision/Greater"
  input: "evaluation/class/pellet/precision/div"
  input: "evaluation/class/pellet/precision/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/add_2"
  op: "Add"
  input: "evaluation/class/pellet/precision/true_positives/AssignAdd"
  input: "evaluation/class/pellet/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/Greater_1"
  op: "Greater"
  input: "evaluation/class/pellet/precision/add_2"
  input: "evaluation/class/pellet/precision/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/add_3"
  op: "Add"
  input: "evaluation/class/pellet/precision/true_positives/AssignAdd"
  input: "evaluation/class/pellet/precision/false_positives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/div_1"
  op: "RealDiv"
  input: "evaluation/class/pellet/precision/true_positives/AssignAdd"
  input: "evaluation/class/pellet/precision/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision/update_op"
  op: "Select"
  input: "evaluation/class/pellet/precision/Greater_1"
  input: "evaluation/class/pellet/precision/div_1"
  input: "evaluation/class/pellet/precision/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/precision_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/pellet/precision_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/precision_1"
  op: "ScalarSummary"
  input: "evaluation/class/pellet/precision_1/tags"
  input: "evaluation/class/pellet/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/pellet/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pellet/recall/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/pellet/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pellet/recall/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/pellet/recall/true_positives/Equal"
  input: "evaluation/class/pellet/recall/true_positives/Equal_1"
}
node {
  name: "evaluation/class/pellet/recall/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/pellet/recall/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/pellet/recall/true_positives/count"
  input: "evaluation/class/pellet/recall/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/pellet/recall/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/recall/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/pellet/recall/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/pellet/recall/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/pellet/recall/true_positives/ToFloat"
  input: "evaluation/class/pellet/recall/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/pellet/recall/true_positives/count"
  input: "evaluation/class/pellet/recall/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/recall/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/Equal"
  op: "Equal"
  input: "evaluation/class/pellet/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pellet/recall/false_negatives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/Equal_1"
  op: "Equal"
  input: "evaluation/class/pellet/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pellet/recall/false_negatives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/pellet/recall/false_negatives/Equal"
  input: "evaluation/class/pellet/recall/false_negatives/Equal_1"
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/count/Assign"
  op: "Assign"
  input: "evaluation/class/pellet/recall/false_negatives/count"
  input: "evaluation/class/pellet/recall/false_negatives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/count/read"
  op: "Identity"
  input: "evaluation/class/pellet/recall/false_negatives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/recall/false_negatives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/ToFloat"
  op: "Cast"
  input: "evaluation/class/pellet/recall/false_negatives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/Identity"
  op: "Identity"
  input: "evaluation/class/pellet/recall/false_negatives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/Sum"
  op: "Sum"
  input: "evaluation/class/pellet/recall/false_negatives/ToFloat"
  input: "evaluation/class/pellet/recall/false_negatives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/false_negatives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/pellet/recall/false_negatives/count"
  input: "evaluation/class/pellet/recall/false_negatives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/pellet/recall/false_negatives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/add"
  op: "Add"
  input: "evaluation/class/pellet/recall/true_positives/Identity"
  input: "evaluation/class/pellet/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/Greater/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/Greater"
  op: "Greater"
  input: "evaluation/class/pellet/recall/add"
  input: "evaluation/class/pellet/recall/Greater/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/add_1"
  op: "Add"
  input: "evaluation/class/pellet/recall/true_positives/Identity"
  input: "evaluation/class/pellet/recall/false_negatives/Identity"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/div"
  op: "RealDiv"
  input: "evaluation/class/pellet/recall/true_positives/Identity"
  input: "evaluation/class/pellet/recall/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/value/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/value"
  op: "Select"
  input: "evaluation/class/pellet/recall/Greater"
  input: "evaluation/class/pellet/recall/div"
  input: "evaluation/class/pellet/recall/value/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/add_2"
  op: "Add"
  input: "evaluation/class/pellet/recall/true_positives/AssignAdd"
  input: "evaluation/class/pellet/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/Greater_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/Greater_1"
  op: "Greater"
  input: "evaluation/class/pellet/recall/add_2"
  input: "evaluation/class/pellet/recall/Greater_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/add_3"
  op: "Add"
  input: "evaluation/class/pellet/recall/true_positives/AssignAdd"
  input: "evaluation/class/pellet/recall/false_negatives/AssignAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/div_1"
  op: "RealDiv"
  input: "evaluation/class/pellet/recall/true_positives/AssignAdd"
  input: "evaluation/class/pellet/recall/add_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/update_op/e"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall/update_op"
  op: "Select"
  input: "evaluation/class/pellet/recall/Greater_1"
  input: "evaluation/class/pellet/recall/div_1"
  input: "evaluation/class/pellet/recall/update_op/e"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/recall_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/pellet/recall_1"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/recall_1"
  op: "ScalarSummary"
  input: "evaluation/class/pellet/recall_1/tags"
  input: "evaluation/class/pellet/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/mul"
  op: "Mul"
  input: "evaluation/class/pellet/mul/x"
  input: "evaluation/class/pellet/recall/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/mul_1"
  op: "Mul"
  input: "evaluation/class/pellet/mul"
  input: "evaluation/class/pellet/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/add"
  op: "Add"
  input: "evaluation/class/pellet/recall/value"
  input: "evaluation/class/pellet/precision/value"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/truediv"
  op: "RealDiv"
  input: "evaluation/class/pellet/mul_1"
  input: "evaluation/class/pellet/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/f1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/pellet/f1"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/f1"
  op: "ScalarSummary"
  input: "evaluation/class/pellet/f1/tags"
  input: "evaluation/class/pellet/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/pellet/Equal"
  op: "Equal"
  input: "evaluation/class/pellet/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/pellet/map_1/TensorArrayStack/TensorArrayGatherV3"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/Cast"
  op: "Cast"
  input: "evaluation/class/pellet/Equal"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/pellet/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/Mean"
  op: "Mean"
  input: "evaluation/class/pellet/Cast"
  input: "evaluation/class/pellet/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/pellet/accuracy/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "evaluation/class/pellet/accuracy"
      }
    }
  }
}
node {
  name: "evaluation/class/pellet/accuracy"
  op: "ScalarSummary"
  input: "evaluation/class/pellet/accuracy/tags"
  input: "evaluation/class/pellet/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/group_deps_10"
  op: "NoOp"
  input: "^evaluation/class/pellet/recall/update_op"
  input: "^evaluation/class/pellet/precision/update_op"
  input: "^evaluation/class/pellet/Mean"
  input: "^evaluation/class/pellet/truediv"
}
node {
  name: "evaluation/class/power_pellet/map/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/power_pellet/map/Shape"
  input: "evaluation/class/power_pellet/map/strided_slice/stack"
  input: "evaluation/class/power_pellet/map/strided_slice/stack_1"
  input: "evaluation/class/power_pellet/map/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/power_pellet/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_3"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/power_pellet/map/TensorArrayUnstack/Shape"
  input: "evaluation/class/power_pellet/map/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/power_pellet/map/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/power_pellet/map/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/power_pellet/map/TensorArrayUnstack/range/start"
  input: "evaluation/class/power_pellet/map/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/power_pellet/map/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/power_pellet/map/TensorArray"
  input: "evaluation/class/power_pellet/map/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_3"
  input: "evaluation/class/power_pellet/map/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_3"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/power_pellet/map/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Enter"
  op: "Enter"
  input: "evaluation/class/power_pellet/map/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/power_pellet/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/power_pellet/map/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/power_pellet/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Merge"
  op: "Merge"
  input: "evaluation/class/power_pellet/map/while/Enter"
  input: "evaluation/class/power_pellet/map/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/power_pellet/map/while/Enter_1"
  input: "evaluation/class/power_pellet/map/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/power_pellet/map/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/power_pellet/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Less"
  op: "Less"
  input: "evaluation/class/power_pellet/map/while/Merge"
  input: "evaluation/class/power_pellet/map/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/power_pellet/map/while/Less"
}
node {
  name: "evaluation/class/power_pellet/map/while/Switch"
  op: "Switch"
  input: "evaluation/class/power_pellet/map/while/Merge"
  input: "evaluation/class/power_pellet/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/power_pellet/map/while/Merge_1"
  input: "evaluation/class/power_pellet/map/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Identity"
  op: "Identity"
  input: "evaluation/class/power_pellet/map/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/power_pellet/map/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/power_pellet/map/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/power_pellet/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/power_pellet/map/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/power_pellet/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/power_pellet/map/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/power_pellet/map/while/Identity"
  input: "evaluation/class/power_pellet/map/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/power_pellet/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 11
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Equal"
  op: "Equal"
  input: "evaluation/class/power_pellet/map/while/TensorArrayReadV3"
  input: "evaluation/class/power_pellet/map/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/power_pellet/map/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/power_pellet/map/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/power_pellet/map/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/power_pellet/map/while/Identity"
  input: "evaluation/class/power_pellet/map/while/Equal"
  input: "evaluation/class/power_pellet/map/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/add/y"
  op: "Const"
  input: "^evaluation/class/power_pellet/map/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/add"
  op: "Add"
  input: "evaluation/class/power_pellet/map/while/Identity"
  input: "evaluation/class/power_pellet/map/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/power_pellet/map/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/power_pellet/map/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Exit"
  op: "Exit"
  input: "evaluation/class/power_pellet/map/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/power_pellet/map/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/power_pellet/map/TensorArray_1"
  input: "evaluation/class/power_pellet/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/power_pellet/map/TensorArrayStack/range/start"
  input: "evaluation/class/power_pellet/map/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/power_pellet/map/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/power_pellet/map/TensorArray_1"
  input: "evaluation/class/power_pellet/map/TensorArrayStack/range"
  input: "evaluation/class/power_pellet/map/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/power_pellet/map_1/Shape"
  input: "evaluation/class/power_pellet/map_1/strided_slice/stack"
  input: "evaluation/class/power_pellet/map_1/strided_slice/stack_1"
  input: "evaluation/class/power_pellet/map_1/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArray"
  op: "TensorArrayV3"
  input: "evaluation/class/power_pellet/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/Shape"
  op: "Shape"
  input: "evaluation/ArgMax_2"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/strided_slice/stack"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/strided_slice/stack_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/strided_slice/stack_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/strided_slice"
  op: "StridedSlice"
  input: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/Shape"
  input: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/strided_slice/stack"
  input: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/strided_slice/stack_1"
  input: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/strided_slice/stack_2"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 1
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/range/start"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/range/delta"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/range"
  op: "Range"
  input: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/range/start"
  input: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/strided_slice"
  input: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  op: "TensorArrayScatterV3"
  input: "evaluation/class/power_pellet/map_1/TensorArray"
  input: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/range"
  input: "evaluation/ArgMax_2"
  input: "evaluation/class/power_pellet/map_1/TensorArray:1"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/ArgMax_2"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArray_1"
  op: "TensorArrayV3"
  input: "evaluation/class/power_pellet/map_1/strided_slice"
  attr {
    key: "clear_after_read"
    value {
      b: true
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "dynamic_size"
    value {
      b: false
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
        unknown_rank: true
      }
    }
  }
  attr {
    key: "tensor_array_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Enter"
  op: "Enter"
  input: "evaluation/class/power_pellet/map_1/Const"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/power_pellet/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Enter_1"
  op: "Enter"
  input: "evaluation/class/power_pellet/map_1/TensorArray_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/power_pellet/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: false
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Merge"
  op: "Merge"
  input: "evaluation/class/power_pellet/map_1/while/Enter"
  input: "evaluation/class/power_pellet/map_1/while/NextIteration"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Merge_1"
  op: "Merge"
  input: "evaluation/class/power_pellet/map_1/while/Enter_1"
  input: "evaluation/class/power_pellet/map_1/while/NextIteration_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Less/Enter"
  op: "Enter"
  input: "evaluation/class/power_pellet/map_1/strided_slice"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/power_pellet/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Less"
  op: "Less"
  input: "evaluation/class/power_pellet/map_1/while/Merge"
  input: "evaluation/class/power_pellet/map_1/while/Less/Enter"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/LoopCond"
  op: "LoopCond"
  input: "evaluation/class/power_pellet/map_1/while/Less"
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Switch"
  op: "Switch"
  input: "evaluation/class/power_pellet/map_1/while/Merge"
  input: "evaluation/class/power_pellet/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map_1/while/Merge"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Switch_1"
  op: "Switch"
  input: "evaluation/class/power_pellet/map_1/while/Merge_1"
  input: "evaluation/class/power_pellet/map_1/while/LoopCond"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map_1/while/Merge_1"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Identity"
  op: "Identity"
  input: "evaluation/class/power_pellet/map_1/while/Switch:1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Identity_1"
  op: "Identity"
  input: "evaluation/class/power_pellet/map_1/while/Switch_1:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/TensorArrayReadV3/Enter"
  op: "Enter"
  input: "evaluation/class/power_pellet/map_1/TensorArray"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/power_pellet/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/TensorArrayReadV3/Enter_1"
  op: "Enter"
  input: "evaluation/class/power_pellet/map_1/TensorArrayUnstack/TensorArrayScatter/TensorArrayScatterV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/power_pellet/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/TensorArrayReadV3"
  op: "TensorArrayReadV3"
  input: "evaluation/class/power_pellet/map_1/while/TensorArrayReadV3/Enter"
  input: "evaluation/class/power_pellet/map_1/while/Identity"
  input: "evaluation/class/power_pellet/map_1/while/TensorArrayReadV3/Enter_1"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Equal/y"
  op: "Const"
  input: "^evaluation/class/power_pellet/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: 11
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Equal"
  op: "Equal"
  input: "evaluation/class/power_pellet/map_1/while/TensorArrayReadV3"
  input: "evaluation/class/power_pellet/map_1/while/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  op: "Enter"
  input: "evaluation/class/power_pellet/map_1/TensorArray_1"
  attr {
    key: "T"
    value {
      type: DT_RESOURCE
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map_1/while/Equal"
      }
    }
  }
  attr {
    key: "frame_name"
    value {
      s: "evaluation/class/power_pellet/map_1/while/while_context"
    }
  }
  attr {
    key: "is_constant"
    value {
      b: true
    }
  }
  attr {
    key: "parallel_iterations"
    value {
      i: 10
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  op: "TensorArrayWriteV3"
  input: "evaluation/class/power_pellet/map_1/while/TensorArrayWrite/TensorArrayWriteV3/Enter"
  input: "evaluation/class/power_pellet/map_1/while/Identity"
  input: "evaluation/class/power_pellet/map_1/while/Equal"
  input: "evaluation/class/power_pellet/map_1/while/Identity_1"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map_1/while/Equal"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/add/y"
  op: "Const"
  input: "^evaluation/class/power_pellet/map_1/while/Identity"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/add"
  op: "Add"
  input: "evaluation/class/power_pellet/map_1/while/Identity"
  input: "evaluation/class/power_pellet/map_1/while/add/y"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/NextIteration"
  op: "NextIteration"
  input: "evaluation/class/power_pellet/map_1/while/add"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/NextIteration_1"
  op: "NextIteration"
  input: "evaluation/class/power_pellet/map_1/while/TensorArrayWrite/TensorArrayWriteV3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Exit"
  op: "Exit"
  input: "evaluation/class/power_pellet/map_1/while/Switch"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/while/Exit_1"
  op: "Exit"
  input: "evaluation/class/power_pellet/map_1/while/Switch_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayStack/TensorArraySizeV3"
  op: "TensorArraySizeV3"
  input: "evaluation/class/power_pellet/map_1/TensorArray_1"
  input: "evaluation/class/power_pellet/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayStack/range/start"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayStack/range/delta"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayStack/range"
  op: "Range"
  input: "evaluation/class/power_pellet/map_1/TensorArrayStack/range/start"
  input: "evaluation/class/power_pellet/map_1/TensorArrayStack/TensorArraySizeV3"
  input: "evaluation/class/power_pellet/map_1/TensorArrayStack/range/delta"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map_1/TensorArray_1"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/map_1/TensorArrayStack/TensorArrayGatherV3"
  op: "TensorArrayGatherV3"
  input: "evaluation/class/power_pellet/map_1/TensorArray_1"
  input: "evaluation/class/power_pellet/map_1/TensorArrayStack/range"
  input: "evaluation/class/power_pellet/map_1/while/Exit_1"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/map_1/TensorArray_1"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "element_shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/Equal"
  op: "Equal"
  input: "evaluation/class/power_pellet/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/power_pellet/precision/true_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/Equal_1"
  op: "Equal"
  input: "evaluation/class/power_pellet/map_1/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/power_pellet/precision/true_positives/Equal_1/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/LogicalAnd"
  op: "LogicalAnd"
  input: "evaluation/class/power_pellet/precision/true_positives/Equal"
  input: "evaluation/class/power_pellet/precision/true_positives/Equal_1"
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/assert_type/statically_determined_correct_type"
  op: "NoOp"
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/count/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/count"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/count/Assign"
  op: "Assign"
  input: "evaluation/class/power_pellet/precision/true_positives/count"
  input: "evaluation/class/power_pellet/precision/true_positives/count/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/count/read"
  op: "Identity"
  input: "evaluation/class/power_pellet/precision/true_positives/count"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/precision/true_positives/count"
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/ToFloat"
  op: "Cast"
  input: "evaluation/class/power_pellet/precision/true_positives/LogicalAnd"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/Identity"
  op: "Identity"
  input: "evaluation/class/power_pellet/precision/true_positives/count/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/Sum"
  op: "Sum"
  input: "evaluation/class/power_pellet/precision/true_positives/ToFloat"
  input: "evaluation/class/power_pellet/precision/true_positives/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/true_positives/AssignAdd"
  op: "AssignAdd"
  input: "evaluation/class/power_pellet/precision/true_positives/count"
  input: "evaluation/class/power_pellet/precision/true_positives/Sum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@evaluation/class/power_pellet/precision/true_positives/count"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/false_positives/Equal/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: false
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/false_positives/Equal"
  op: "Equal"
  input: "evaluation/class/power_pellet/map/TensorArrayStack/TensorArrayGatherV3"
  input: "evaluation/class/power_pellet/precision/false_positives/Equal/y"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/false_positives/Equal_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "evaluation/class/power_pellet/precision/false_positives/Equal_1"
  op: "Equal"
  attr {
    key: "T"