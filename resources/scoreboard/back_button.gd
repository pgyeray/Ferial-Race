extends Button

export(String) var scene_to_load

func _on_Button_pressed():
	get_tree().change_scene('res://resources/main/TitleScreen.tscn')
