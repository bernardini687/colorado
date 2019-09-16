# frozen_string_literal: true

require 'gosu'

# utility modules
require_relative 'tiles'
require_relative 'input'

# entities
require_relative 'world/world'
require_relative 'actor/actor'
require_relative 'human/human'
require_relative 'cat/cat'
require_relative 'scan/base_scan'
require_relative 'scan/left_scan'
require_relative 'scan/right_scan'

# game
require_relative 'game/game'

Game.new.show
