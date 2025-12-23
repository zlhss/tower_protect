extends Area2D

@onready var enemy_animation: AnimatedSprite2D = $AnimatedSprite2D
var bad = 1
var num = 1
var new = 0
const ENEMY = preload("res://sences/enemy.tscn")

signal add_score
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enemy_animation.play("idle")
	self.position -= (self.position - Vector2(600,270)).normalized()/7
