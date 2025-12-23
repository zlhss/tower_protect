extends Node2D

@onready var timer: Timer = $Timer
var enemys = []
const ENEMY = preload("res://sences/enemy.tscn")

func _on_timer_timeout() -> void:

	var instance = ENEMY.instantiate()
	var where = randi_range(1,4)
	if where == 1:
		instance.position = Vector2(randf_range(0,1214),randf_range(0,128))
	elif where == 2:
		instance.position = Vector2(randf_range(0,214),randf_range(0,700))
	elif where == 3:
		instance.position = Vector2(randf_range(0,1214),randf_range(555,700))
	elif where == 4:
		instance.position = Vector2(randf_range(923,1214),randf_range(0,700))
	
	add_child(instance)
	enemys.push_back(instance)
	pass # Replace with function body.


func _on_heart_game_end() -> void:
	timer.wait_time = 1
	timer.stop()
	pass # Replace with function body.


func _on_button_game_restart() -> void:
	timer.start()
	pass # Replace with function body.


func _on_dia_clean() -> void:
	for enemy in enemys:
		if is_instance_valid(enemy):
			enemy.queue_free()  
	enemys = [] 
