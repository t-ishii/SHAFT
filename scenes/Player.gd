extends KinematicBody2D

export (int) var speed = 200 # pixels / second

const Constant = preload("res://scenes/constant.gd")

var velocity = Vector2()

func get_input():
    velocity = Vector2(0, Constant.GRAVITY)

    if Input.is_action_pressed('right'):
        velocity.x += 1
    if Input.is_action_pressed('left'):
        velocity.x -= 1
    print([velocity, velocity.normalized()])

    # ベクトルを標準化した値に対してspeedの値を乗せる
    velocity = velocity.normalized() * speed

func _physics_process(delta):
    get_input()
    move_and_slide(velocity)
