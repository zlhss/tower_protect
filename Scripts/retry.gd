extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass

func _on_heart_game_end() -> void:
	self.visible = true
	self.play("retry")
	pass # Replace with function body.


func _on_button_game_restart() -> void:
	self.visible = false
	self.pause()
	pass # Replace with function body.
