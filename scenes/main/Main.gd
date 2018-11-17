extends Node2D

const Constant = preload('res://scenes/constant.gd')
const Bar = preload('res://scenes/Bar.tscn')

var span = Constant.BAR_POP_SPAN
var bars = []

func get_start_pos():
    rand_seed(OS.get_ticks_msec())
    randomize()

    var w = randi() % Constant.SCREEN.WIDTH
    var h = Constant.SCREEN.HEIGHT

    if w < Constant.WALL_DEPTH:
        w = Constant.WALL_DEPTH
    if w > Constant.SCREEN.WIDTH - Constant.WALL_DEPTH - Constant.BAR_WIDTH:
        w = Constant.SCREEN.WIDTH - Constant.WALL_DEPTH - Constant.BAR_WIDTH

    return Vector2(w, h)

func pop_bar(delta):

    span -= delta

    if bars.size() == 0 || span < 0 && bars.size() < Constant.BAR_COUNT:
        var bar = Bar.instance()
        bars.append(bar)
        bar.position = get_start_pos()
        add_child(bar)
        span = Constant.BAR_POP_SPAN
        
func move_bar(delta):
    for bar in bars:
        bar.position.y -= 1
        if bar.position.y < -Constant.BAR_DEPTH:
            remove_child(bar)
            bars.remove(bars.find(bar))

func dead():
    $Dead.position = Vector2($Player.position.x, Constant.SCREEN.HEIGHT)
    $Dead.emitting = true
    $Player.queue_free()

func _physics_process(delta):
    pop_bar(delta)
    move_bar(delta)
    
    if has_node('Player') and $Player.position.y > Constant.SCREEN.HEIGHT:
        dead()
        yield(get_tree().create_timer(5.0), 'timeout')
        get_tree().change_scene('res://scenes/result/Result.tscn')

func _ready():
    $Player.position = Vector2(Constant.SCREEN.WIDTH / 2, Constant.SCREEN.HEIGHT / 2)
