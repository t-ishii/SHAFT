extends Node2D

var Constant = preload('res://scenes/constant.gd')
var Bar = preload('res://assets/Bar.tscn')

var bar_count = 0
var bar = Bar.instance()

func get_start_pos():
    rand_seed(OS.get_ticks_msec())
    randomize()

    var w = randi() % Constant.SCREEN.WIDTH
    var h = Constant.SCREEN.HEIGHT

    if w < Constant.WALL_DEPTH:
        w = Constant.WALL_DEPTH
    if w > Constant.SCREEN.WIDTH - Constant.WALL_DEPTH - Constant.BAR_WIDTH:
        w = Constant.SCREEN.WIDTH - Constant.WALL_DEPTH - Constant.BAR_WIDTH

    return Vector2(w, h - 50)

func _physics_process(delta):
    if (bar_count < Constant.BAR_COUNT):
        bar_count += 1
        bar.position = get_start_pos()
        get_parent().add_child(bar)
