"""Constants that are used throughout the vision training session."""

# The number of unique classes in the dataset.
NUM_CLASSES = 14

# Column name for the images in the data_frame.
IMAGE = 'image'

# Column name for the labels in the data_frame.
LABEL = 'label'

# The number of pixels in the tile.
TILE_SIZE = 8 * 8

# The number of color components per pixel.
NUM_COLOR_COMPONENTS = 4

# The number of bytes that a single image takes up.
IMAGE_BUFFER_LENGTH = TILE_SIZE * NUM_COLOR_COMPONENTS

# Array of all of the string versions of the labels.
LABEL_NAMES = ['unknown', 'pacman', 'wall', 'blank', 'fruit', 'blinky', 'inky', 'pinky',
               'clyde', 'frightened_ghost', 'pellet', 'power_pellet', 'text', 'ignore']

RELATIVE_EXPORT_DIR = '/../model/'

MODEL_NAME = 'model'

GRAPH_PB_NAME = 'graph.pbtxt'

FROZEN_PB_NAME = 'frozen_model.pb'

FINALIZED_PB_NAME = 'finalized_model.pb'
