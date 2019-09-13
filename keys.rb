module Keys
  def self.left?
    Gosu.button_down?(Gosu::KB_LEFT) || Gosu.button_down?(Gosu::KB_H)
  end

  def self.right?
    Gosu.button_down?(Gosu::KB_RIGHT) || Gosu.button_down?(Gosu::KB_L)
  end
end
