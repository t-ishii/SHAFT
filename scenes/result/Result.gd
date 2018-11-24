extends CanvasLayer

func _on_Retry_pressed():
    get_tree().change_scene(Constant.MAIN_SCENE)

func _on_Title_pressed():
    get_tree().change_scene(Constant.TITLE_SCENE)

func _ready():
    $Score.text = 'Score: ' + str(Status.score)
