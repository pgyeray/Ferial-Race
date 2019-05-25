extends Area2D
# Finish area script

func _process(delta):
	for body in get_overlapping_bodies():
		## Player ends -- logics for first time
		if body.name == "MainCamel" and not Global.finished:
			Global.finished = true;
			GameSaver.elapsed_racetime = OS.get_ticks_msec() - GameSaver.init_race;
			set_popup_labels(GameSaver.elapsed_racetime, GameSaver.player_position);
			Global.show_popup();

		## An oponent ends -- logics for first time
		elif body.name != "MainCamel" and not body.finished:
			body.stop();
			if not Global.finished:
				GameSaver.player_position += 1;
				
func set_popup_labels(time, position):
	var pos_label = get_node("/root/SplitScreen/Popup/VBoxContainer2/VBoxContainer/Position");
	var time_label = get_node("/root/SplitScreen/Popup/VBoxContainer2/VBoxContainer/Time");
	pos_label.text = pos_label.text + str(position);
	time_label.text = time_label.text + str(time / float(1000)) + " sec.";
