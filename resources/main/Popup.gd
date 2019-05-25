extends AcceptDialog

onready var nickname = $VBoxContainer2/VBoxContainer/NicknameInput

func _ready():
	add_cancel("Do not save");
