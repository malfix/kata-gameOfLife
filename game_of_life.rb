require 'set'
class GameOfLife
  def initialize(*live_cells)
    @x = 100
    @y = 40
    @cells_alive = Set.new
    @tick = 0.1
    live_cells.each { | cell | @cells_alive.add(cell) }
  end

  def start_life
    while true
      display_status
      sleep @tick
      next_step
    end
  end

  def next_step
    next_state  = Set.new
    @cells_alive.each do |cells|
      (-1).upto(1) do |x|
        (-1).upto(1) do |y|
          current_x = cells[0] + x
          current_y = cells[1] + y
          next_state.add([current_x, current_y]) if is_alive(current_x, current_y)
        end
      end
    end
    @cells_alive = next_state
  end

  def is_alive(check_x,check_y)
    count_alive_neightbour = 0
    (-1).upto(1) do |x|
      (-1).upto(1) do |y|
        current_x = check_x + x
        current_y = check_y + y
        next if current_x == check_x &&  current_y == check_y
        count_alive_neightbour+=1 if @cells_alive === [current_x, current_y]
      end
    end
    (count_alive_neightbour == 3) || (count_alive_neightbour == 2 && @cells_alive === [check_x, check_y])
  end

  def display_status
    display = ''
    0.upto(@y) do |y|
      0.upto(@x) do |x|
        display+=(@cells_alive === [x,y] ? '*' : ' ' )
      end
      display+= "\n"
    end
    system 'clear'
    print display
  end

  def add_block(x, y)
    @cells_alive.add([x+0, y+0])
    @cells_alive.add([x+1, y+0])
    @cells_alive.add([x+0, y+1])
    @cells_alive.add([x+1, y+1])
  end

  def add_beheive(x, y)
    @cells_alive.add([x+1, y+0])
    @cells_alive.add([x+2, y+0])
    @cells_alive.add([x+0, y+1])
    @cells_alive.add([x+3, y+1])
    @cells_alive.add([x+1, y+2])
    @cells_alive.add([x+2, y+2])
  end


  def add_loaf(x, y)
    @cells_alive.add([x+1, y+0])
    @cells_alive.add([x+2, y+0])
    @cells_alive.add([x+0, y+1])
    @cells_alive.add([x+3, y+1])
    @cells_alive.add([x+1, y+2])
    @cells_alive.add([x+3, y+2])
    @cells_alive.add([x+2, y+3])
  end

  def add_boat(x, y)
    @cells_alive.add([x+0, y+0])
    @cells_alive.add([x+1, y+0])
    @cells_alive.add([x+0, y+1])
    @cells_alive.add([x+2, y+1])
    @cells_alive.add([x+1, y+2])
  end

  def add_tub(x, y)
    @cells_alive.add([x+1, y+0])
    @cells_alive.add([x+0, y+1])
    @cells_alive.add([x+2, y+1])
    @cells_alive.add([x+1, y+2])
  end

  def add_blinker(x, y)
    @cells_alive.add([x+1, y+0])
    @cells_alive.add([x+1, y+1])
    @cells_alive.add([x+1, y+2])
  end

  def add_toad(x, y)
    @cells_alive.add([x+2, y+0])
    @cells_alive.add([x+0, y+1])
    @cells_alive.add([x+3, y+1])
    @cells_alive.add([x+0, y+2])
    @cells_alive.add([x+3, y+2])
    @cells_alive.add([x+1, y+3])
  end

  def add_beacon(x, y)
    add_block(x,y)
    add_block(x+2,y+2)
  end

  def add_diehard(x, y)
    @cells_alive.add([x+0, y+1])
    @cells_alive.add([x+1, y+1])
    @cells_alive.add([x+1, y+2])
    @cells_alive.add([x+6, y+0])
    @cells_alive.add([x+5, y+2])
    @cells_alive.add([x+6, y+2])
    @cells_alive.add([x+7, y+2])
  end


  def add_ghianda(x, y)
    @cells_alive.add([x+1, y+0])
    @cells_alive.add([x+3, y+1])
    @cells_alive.add([x+0, y+2])
    @cells_alive.add([x+1, y+2])
    @cells_alive.add([x+3, y+2])
    @cells_alive.add([x+4, y+2])
    @cells_alive.add([x+5, y+2])
  end

  def add_glider(x, y)
    @cells_alive.add([x+1, y+0])
    @cells_alive.add([x+2, y+1])
    @cells_alive.add([x+0, y+2])
    @cells_alive.add([x+1, y+2])
    @cells_alive.add([x+2, y+2])
  end

  def add_spaceship(x, y)
    @cells_alive.add([x+1, y+0])
    @cells_alive.add([x+2, y+0])
    @cells_alive.add([x+3, y+0])
    @cells_alive.add([x+4, y+0])
    @cells_alive.add([x+0, y+1])
    @cells_alive.add([x+4, y+1])
    @cells_alive.add([x+4, y+2])
    @cells_alive.add([x+0, y+3])
    @cells_alive.add([x+3, y+3])
  end
end


a = GameOfLife.new()
a.add_block(1,1)
a.add_beheive(10,10)
a.add_loaf(5,5)
a.add_boat(13,5)
a.add_tub(5,13)
a.add_blinker(20,13)
a.add_toad(29,13)
a.add_beacon(29,20)
a.add_diehard(40,30)
a.add_ghianda(60,30)
a.add_glider(60,0)
a.add_spaceship(0,30)
a.start_life
