# frozen_string_literal: true

require 'gosu'

# utility modules
require_relative 'tiles'
require_relative 'keys'

# entities
require_relative 'world'
require_relative 'actor'
require_relative 'human'
require_relative 'cat'
require_relative 'scan'

# game
require_relative 'game'

Game.new.show
