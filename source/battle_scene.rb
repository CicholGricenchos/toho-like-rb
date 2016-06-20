class BattleScene

  attr_accessor :battle_area, :score_area, :player_bullets, :enemies, :enemy_bullets, :effects, :items

  class << self
    attr_accessor :instance
  end

  def initialize
    @player_bullets = []
    @enemy_bullets = []
    @enemies = []
    @effects = []
    @items = []

    @battle_area = Rect[[0,0], [550,600]]
    @score_area = Rect[[550,0], [800,600]]
    @player = ReimuPlayer.new @battle_area
    @enemies << Yousei4.new(Vector[300,300])
    @enemies << Yousei4.new(Vector[500,300])

    @font = Gosu::Font.new(20)

  end

  def update
    @player.update

    process_collisions

    @player_bullets.map &:update
    @player_bullets.select! &:alive?
    @enemies.map &:update
    @enemies.select! &:alive?
    @enemy_bullets.map &:update
    @enemy_bullets.select! &:alive?
    @effects.map &:update
    @effects.select! &:alive?
    @items.map &:update
    @items.map &:alive?

  end

  def draw
    Gosu.draw_rect(*@battle_area[0], *@battle_area[1], Gosu::Color::WHITE)
    Gosu.draw_rect(*@score_area[0], *@score_area[1], Gosu::Color::BLACK)
    @player.draw
    @player_bullets.map &:draw
    @enemies.map &:draw
    @enemy_bullets.map &:draw
    @effects.map &:draw
    @items.map &:draw
    @font.draw("Bullets: #{@player_bullets.count + @enemy_bullets.count}", *@score_area.relative(10, 10), 1, 1.0, 1.0, 0xff_ffffff)
    @font.draw("FPS: #{Gosu.fps}", *@score_area.relative(10, 30), 1, 1.0, 1.0, 0xff_ffffff)
  end

  def process_collisions
    @player_bullets.each do |bullet|
      @enemies.each do |enemy|
        if collision?(enemy.collision_body, bullet.collision_body) && enemy.alive? && bullet.alive?
          enemy.hitted_by bullet
          bullet.hitted enemy
        end
      end
    end

    @enemy_bullets.each do |bullet|
      if graze? @player, bullet, 0.5
        @player.graze bullet
      end

      if collision? @player, bullet
        @player.hitted_by bullet
      end
    end
  end

  def add_bullet bullet, from
    if from == :player
      @player_bullets << bullet
    else
      @enemy_bullets << bullet
    end
  end
end