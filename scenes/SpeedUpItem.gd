extends Node2D

func _on_Area2D_body_entered(body):
    if visible and body.name == 'Player':
        body.emit_signal('get_item')
        $Anime.play('get')
