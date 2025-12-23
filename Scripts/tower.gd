extends Area2D

const BULLET = preload("res://sences/bullet.tscn")

@onready var tower_anime: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"../player"


var left_shoot = 1
var cooldown = 5
var holding = 0
var dir = 1
var game_end = false

signal can_hold
signal  cant_hold
signal  shoot
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if holding:
		if  dir == 1:
			tower_anime.flip_h = false
		else:
			tower_anime.flip_h = true
		self.position.x = player.position.x
		self.position.y = player.position.y - 40
	if cooldown <= 0 and not holding:
		tower_anime.play("shoot")
		atteck()

	elif holding:
		tower_anime.play("idle")
		cooldown -= delta * 8
		left_shoot = 1
	else:
		cooldown -= delta * 4
		left_shoot = 1
	pass
	
func atteck():
	if not game_end:
		if left_shoot > 0:
			self.left_shoot -= 1
			var instance = BULLET.instantiate()
			instance.position = position
			get_parent().add_child(instance)
		else:
			cooldown = 3
		

func _on_body_entered(body: Node2D) -> void:
	can_hold.emit()
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	cant_hold.emit()
	pass # Replace with function body.


func _on_player_holding() -> void:
	var player: CharacterBody2D = $"../player"

	self.holding = 1

	pass # Replace with function body.


func _on_player_unholding() -> void:
	var player: CharacterBody2D = $"../player"
	
	if Input.is_action_just_released("hold") and holding:
		self.position.y = self.position.y + 40
		
		if	player.velocity.x == 0:
			self.position.x = self.position.x + 40 * dir
		else:
			self.position += player.velocity / 10
	self.holding = 0
	pass # Replace with function body.


func _on_player_left_putdown() -> void:
	if holding:
		self.dir = -1
	pass # Replace with function body.


func _on_player_right_putdown() -> void:
	if holding:
		self.dir = 1
	pass # Replace with function body.


func _on_heart_game_end() -> void:
	game_end = true
	pass # Replace with function body.


func _on_touch_screen_button_game_restart() -> void:
	game_end = false
	position = Vector2(687,286)
	if self.dir == -1:
		tower_anime.flip_h = false
		dir = 1
	pass # Replace with function body.
	pass # Replace with function body.
