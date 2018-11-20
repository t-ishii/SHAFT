extends KinematicBody2D

var on_air_time = 100
var velocity = Vector2()
var jumping = false
var prev_jump_pressed = false

var speed = 1

signal get_item

func _physics_process(delta):
    var force = Vector2(0, Constant.GRAVITY)

    var pressed_r = Input.is_action_pressed('right')
    var pressed_l = Input.is_action_pressed('left')
    var pressed_j = Input.is_action_pressed('jump')

    var stop = true
    
    if pressed_l:
        if velocity.x <= Constant.PLAYER.SPEED.MIN and velocity.x > -Constant.PLAYER.SPEED.MAX:
            force.x -= Constant.PLAYER.SPEED.FORCE * speed
            stop = false
    elif pressed_r:
        if velocity.x >= -Constant.PLAYER.SPEED.MIN and velocity.x < Constant.PLAYER.SPEED.MAX:
            force.x += Constant.PLAYER.SPEED.FORCE * speed
            stop = false

    if stop:
        var vsign = sign(velocity.x)
        var vlen = abs(velocity.x)
        
        vlen -= Constant.PLAYER.SPEED.STOP * delta
        if vlen < 0:
            vlen = 0
            
        velocity.x = vlen * vsign
    
    velocity += force * delta
    velocity = move_and_slide(velocity, Vector2(0, -1))
    
    if is_on_floor():
        on_air_time = 0
    
    if jumping and velocity.y > 0:
        jumping = false
    
    if on_air_time < Constant.PLAYER.JUMP.MAX_TIME and pressed_j and not prev_jump_pressed and not jumping:
        velocity.y = -Constant.PLAYER.JUMP.SPEED
        jumping = true

    on_air_time += delta
    prev_jump_pressed = pressed_j

func inc_speed():
    speed += 0.1

func _ready():
    connect('get_item', self, 'inc_speed')
