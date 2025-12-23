extends CharacterBody2D

enum State{
	IDLE,
	RUNNING,
	HOLDING_STAND,
	HOLDING_RUN,
	
}
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#塔的方向
@onready var tower_dir = 1
#速度
var SPEED = 500
#实在不知道怎么写区分扣血
var bad = 0
#是否正在拿
signal holding
signal unholding
signal left_putdown
signal right_putdown
#用了判断能不能拿塔
var can_hold = false
# Called when the node enters the scene tree for the first time.
var dir

func _ready() -> void:
	
	velocity = Vector2(0,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		left_putdown.emit()
	if Input.is_action_pressed("right"):
		right_putdown.emit()
	move()
	move_and_slide()
	pass

#塔能不能拿起来
func _on_tower_can_hold() -> void:
	self.can_hold = true
	pass # Replace with function body.


func _on_tower_cant_hold() -> void:
	self.can_hold = false
	pass # Replace with function body.
	
func move():
	var dir = Input.get_vector("left","right","up","down")
	if not is_zero_approx(dir.x):
		animated_sprite_2d.flip_h = dir.x < 0
	velocity = dir * SPEED 



func get_next_state(state:State) -> State:
	
	dir = Input.get_vector("left","right","up","down")
	var is_holding = Input.is_action_pressed("hold") and can_hold == true
	var is_unholding = Input.is_action_just_released("hold")
	var is_moving = (dir != Vector2(0,0))
	
	
	match state:
		
		State.IDLE:
			if is_holding and not is_moving:
				return State.HOLDING_STAND	
			if is_moving and not is_holding:
				return State.RUNNING
			if not is_moving and not is_holding:
				return State.IDLE
			if is_holding and is_moving:
				return State.HOLDING_RUN
			
		State.HOLDING_RUN:
			if is_holding and not is_moving:
				return State.HOLDING_STAND	
			if is_moving and not is_holding:
				return State.RUNNING
			if not is_moving and not is_holding:
				return State.IDLE
			if is_holding and is_moving:
				return State.HOLDING_RUN
			
		State.HOLDING_STAND:
			if is_holding and not is_moving:
				return State.HOLDING_STAND	
			if is_moving and not is_holding:
				return State.RUNNING
			if not is_moving and not is_holding:
				return State.IDLE
			if is_holding and is_moving:
				return State.HOLDING_RUN
			
		State.RUNNING:	
			if is_holding and not is_moving:
				return State.HOLDING_STAND	
			if is_moving and not is_holding:
				return State.RUNNING
			if not is_moving and not is_holding:
				return State.IDLE
			if is_holding and is_moving:
				return State.HOLDING_RUN
			
			
	return state
		
func transition_state(from : State , to : State) -> void:
	match to:
		State.IDLE:
			animated_sprite_2d.play("idle")
			unholding.emit()
		State.HOLDING_RUN:
			animated_sprite_2d.play("hold_run")
			holding.emit()
		State.HOLDING_STAND:
			animated_sprite_2d.play("hold")
			holding.emit()
		State.RUNNING:	
			animated_sprite_2d.play("run")
			unholding.emit()

func tick_physics(state : State,delta :float) -> void:
	match state:
		State.IDLE:
			move()
		State.HOLDING_RUN:
			move()
		State.HOLDING_STAND:
			move()
		State.RUNNING:	
			move()



func _on_heart_game_end() -> void:
	self.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	pass # Replace with function body.



func _on_touch_screen_button_game_restart() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	position = Vector2(648,270)
	pass # Replace with function body.
