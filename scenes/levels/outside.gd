extends LevelParent

var inside_level_scene: String = "res://scenes/levels/inside.tscn"

func _on_gate_player_entered_gate():
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.change_scene(inside_level_scene)


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, "zoom", house_zoom, 1).set_trans(Tween.TRANS_QUAD)

func _on_house_player_left():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, "zoom", default_zoom, 1)
