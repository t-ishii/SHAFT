extends CanvasLayer

func _on_Button_pressed():
    var result = get_tree().change_scene(Constant.MAIN_SCENE)
    if result > 0:
        print('Error Code: ', result)
