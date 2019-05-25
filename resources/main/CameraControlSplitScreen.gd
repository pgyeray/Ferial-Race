extends Node
### Screen runtime script ###

onready var player_camera = $Screen/RaceView/Viewport/Camera2D
onready var race_scope =  $Screen/RaceView/Viewport/Race
onready var init_time

func _ready():
	Global.load_player_sprite()
	Global.load_popup()
	Global._set_it_up();

func _physics_process(delta):
	player_camera.global_position = race_scope.get_node("MainCamel").global_position
	
func _on_Popup_confirmed():
	GameSaver.nickname = Global.popup.nickname.text;
	GameSaver.save_score();
	print(GameSaver.ScoreBoard.values())

func _on_Popup_popup_hide():
	get_tree().change_scene('res://resources/main/TitleScreen.tscn')
