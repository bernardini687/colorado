# frozen_string_literal: true

require 'gosu'

# utility modules
require_relative 'tiles'
require_relative 'input'

# entities
require_relative 'world'
require_relative 'actor'
require_relative 'human'
require_relative 'cat'
require_relative 'base_scan'
require_relative 'left_scan'
require_relative 'right_scan'

# game
require_relative 'game'

Game.new.show
