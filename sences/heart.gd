extends Node2D
@onready var h_1: AnimatedSprite2D = $h1
@onready var h_2: AnimatedSprite2D = $h2
@onready var h_3: AnimatedSprite2D = $h3
@onready var h_4: AnimatedSprite2D = $h4
var heart_num = 4
signal game_end
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	h_1.play("full")
	h_2.play("full")
	h_3.play("full")
	h_4.play("full")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if heart_num == 4:
		h_1.play("full")
		h_2.play("full")
		h_3.play("full")
		h_4.play("full")	
	if heart_num == 3:
		h_4.play("empty")
	if heart_num == 2:
		h_3.play("empty")
	if heart_num == 1:
		h_2.play("empty")
	if heart_num <= 0:
		h_1.play("empty")	
		#game_end.emit()
	pass


func _on_dia_heart_down() -> void:
	heart_num -= 1
	pass # Replace with function body.




func _on_touch_screen_button_game_restart() -> void:
	heart_num = 4
	pass # Replace with function body.
