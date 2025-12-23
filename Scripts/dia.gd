extends Area2D

@onready var timer: Timer = $Timer

signal heart_down
signal clean

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.has_node("bad"):
		heart_down.emit()
		clean.emit()
		timer.start()
		self.collision_layer = 2
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	self.collision_layer = 1
	timer.stop()
	timer.wait_time = 1
	pass # Replace with function body.


func _on_touch_screen_button_game_restart() -> void:
	pass # Replace with function body.
