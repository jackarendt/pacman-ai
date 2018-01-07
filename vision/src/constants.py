"""Constants that are used throughout the vision training session."""

# Column name for the images in the data_frame.
IMAGE = 'image'

# Column name for the labels in the data_frame.
LABEL = 'label'

# Name of the labels file.
LABEL_FILE_NAME = 'labels.csv'

# The number of pixels in the tile.
TILE_SIZE = 8 * 8

# The number of color components per pixel.
NUM_COLOR_COMPONENTS = 4

# The number of bytes that a single image takes up.
IMAGE_BUFFER_LENGTH = TILE_SIZE * NUM_COLOR_COMPONENTS

# The name of the model.
MODEL_NAME = 'model'

# The protobuf in text format.
GRAPH_PB_NAME = 'graph.pbtxt'

# Name of the frozen model (binary proto file).
FROZEN_PB_NAME = 'frozen_model.pb'

# Name of the finalized model (binary proto file).
FINALIZED_PB_NAME = 'finalized_model.pb'
