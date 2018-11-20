extends Node2D

const Bar = preload('res://scenes/Bar.tscn')
const SpeedUpItem = preload('res://scenes/SpeedUpItem.tscn')

export (int) var bar_speed = 1
export (int) var bar_accel_speed = 2

var span = 0
var next_pop_span = rand_range(1, Constant.BAR_POP_MAX_SPAN)
var bars = []

func get_start_pos():
    var w = randi() % Constant.SCREEN.WIDTH
    var h = Constant.SCREEN.HEIGHT

    if w < Constant.WALL_DEPTH:
        w = Constant.WALL_DEPTH
    if w > Constant.SCREEN.WIDTH - Constant.WALL_DEPTH - Constant.BAR_WIDTH:
        w = Constant.SCREEN.WIDTH - Constant.WALL_DEPTH - Constant.BAR_WIDTH

    return Vector2(w, h)

func pop_bar(delta):

    span += delta

    if bars.size() == 0 || span > next_pop_span && bars.size() < Constant.BAR_COUNT:

        span = 0

        var bar = Bar.instance()
        var item = bar.get_node('SpeedUpItem')
        bar.position = get_start_pos()
        bars.append(bar)

        add_child(bar)

        if has_node('Player'):
            Status.score += 1
            setScore(Status.score)
        
        if randi() % 5 == 1:
            item.visible = true

        if bar_speed < Constant.BAR_MAX_SPEED:
            bar_speed += (delta * bar_accel_speed)
        if bar_speed > Constant.BAR_MAX_SPEED:
            bar_speed = Constant.BAR_MAX_SPEED
            
        next_pop_span = rand_range(1, Constant.BAR_POP_MAX_SPAN)

func move_bar(delta):
    for bar in bars:
        bar.position.y -= bar_speed
        if bar.position.y < -Constant.BAR_DEPTH:
            remove_child(bar)
            bars.remove(bars.find(bar))

func dead():
    $Dead.position = Vector2($Player.position.x, $Player.position.y)
    $Dead.emitting = true
    $Player.queue_free()

func _physics_process(delta):
    pop_bar(delta)
    move_bar(delta)

    if has_node('Player'):
        if $Player.position.y > Constant.SCREEN.HEIGHT || $Player.position.y <= Constant.WALL_DEPTH:
            dead()
            yield(get_tree().create_timer(5.0), 'timeout')
            get_tree().change_scene('res://scenes/result/Result.tscn')

func setScore(score):
    $Score.text = 'Score: ' + str(score)

func _ready():
    rand_seed(OS.get_ticks_msec())
    randomize()
    Status.score = 0
    setScore(Status.score)
    $Player.position = Vector2(Constant.SCREEN.WIDTH / 2, Constant.SCREEN.HEIGHT / 2)
