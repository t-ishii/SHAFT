extends Node2D

const Constant = preload('res://scenes/constant.gd')

func _on_Button_pressed():
    get_tree().change_scene(Constant.MAIN_SCENE)
