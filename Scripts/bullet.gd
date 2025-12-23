extends Area2D

@onready var tower: Area2D = $"../tower"

var speed = 2
var dir = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tower: Area2D = $"../tower"
	dir = tower.dir
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += dir * speed
	pass



func _on_area_entered(area: Area2D) -> void:
	if area.has_node("bad"):
		area.queue_free()
