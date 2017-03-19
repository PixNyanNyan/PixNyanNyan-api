##
# Constants used in PixNyanNyan
##

# Content limit
MAX_IMAGE_KB_SIZE = ENV.fetch('MAX_IMAGE_KB_SIZE'){ 5120 }.to_i
MAX_POST_MESSAGE_WORDCOUNT = ENV.fetch('MAX_POST_MESSAGE_WORDCOUNT'){ 1000 }.to_i
