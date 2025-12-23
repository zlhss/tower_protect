extends TouchScreenButton

signal game_restart
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	pass # Replace with function body.

func _on_pressed() -> void:
	game_restart.emit()
	pass # Replace with function body.


func _on_heart_game_end() -> void:
	self.visible = true
	pass # Replace with function body.


func _on_game_restart() -> void:
	self.visible = false
	pass # Replace with function body.
