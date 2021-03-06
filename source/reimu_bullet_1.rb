class ReimuBullet1 < Bullet

  class << self
    attr_accessor :image
  end

  def initialize params = {}, &block
    super(params, &block)

    @speed = 25
    @demage = 5

    set params
  end

  def initialize_sprite
    self.class.image ||= Gosu::Image.new("image/pl_shot.png", rect: [34, 129, 13, 50])
    @width = 13
    @height = 50
  end

  def update
    super
  end

  def draw
    draw_indicator *@position
    self.class.image.draw_rot *@position, 0, display_direction, 0.5, 0.0, 1, 1, 0xccffffff
  end

  def collision_body
    [@position, 0]
  end

end