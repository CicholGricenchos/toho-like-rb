class Bullet
  attr_accessor :position, :alive, :demage
  def initialize
    @alive = true
  end

  def update
    update_velocity
    update_position

    update_alive
  end

  def draw

  end

  def alive?
    @alive
  end

  def update_velocity

  end

  def update_position
    @position = @position + @velocity
  end

  def update_alive

  end

  def calc_direction
    Gosu.angle(0, 0, *@velocity)
  end

  def hitted _
    @alive = false
  end
end