extends Control

onready var score_list = $"Container/ScoreBoard/ScoreList"

func _ready():
	var scoreboard = GameSaver.ScoreBoard
	
	#get_node("Container/ScoreBoard/ScoreList").add_constant_override("vseparation",30);
	var grid = GridContainer.new()
	grid.set_columns(3)

	for item in scoreboard.values():
		#grid.size_flags_vertical = SIZE_EXPAND_FILL
		#grid.size_flags_horizontal = SIZE_EXPAND_FILL
		
		var nom = Label.new()
		var position = Label.new()
		var time = Label.new()
	
		nom.add_font_override("font", load("res://assets/fonts/scoreboard_labels.tres"))
		position.add_font_override("font", load("res://assets/fonts/scoreboard_labels.tres"))
		time.add_font_override("font", load("res://assets/fonts/scoreboard_labels.tres"))
		nom.add_color_override("font_color", Color.black)
		position.add_color_override("font_color", Color.black)
		time.add_color_override("font_color", Color.black)
	
		nom.set_align(HALIGN_CENTER)
		position.set_align(HALIGN_CENTER)
		time.set_align(HALIGN_CENTER)
	
		nom.size_flags_horizontal = SIZE_EXPAND_FILL
		nom.size_flags_vertical = SIZE_EXPAND_FILL
		position.size_flags_horizontal = SIZE_EXPAND_FILL
		position.size_flags_vertical = SIZE_EXPAND_FILL
		time.size_flags_horizontal = SIZE_EXPAND_FILL
		time.size_flags_vertical = SIZE_EXPAND_FILL
		
		var seconds = str(item.time / float(1000))
		
		nom.set_text(item.name)
		position.set_text(str(item.position))
		time.set_text(seconds + " seconds")
		
		grid.add_child(nom)
		grid.add_child(position)
		grid.add_child(time)
		
		score_list.add_child(grid)
