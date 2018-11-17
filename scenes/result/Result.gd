extends Node2D

func _on_Retry_pressed():
    get_tree().change_scene('res://scenes/main/Main.tscn')

func _on_Title_pressed():
    get_tree().change_scene('res://scenes/title/Title.tscn')
