extends TouchScreenButton

const DRAG_RADIUS := 64.0

var finger_index := -1
var drag_offset: Vector2

@onready var rest_pos := global_position


func _input(event: InputEvent) -> void:
	var st := event as InputEventScreenTouch
	if st:
		if st.pressed and finger_index == -1:
			var global_pos := st.position * get_canvas_transform()
			var local_pos := global_pos * get_global_transform()  # to_local(global_pos)
			var rect := Rect2(Vector2.ZERO, texture_normal.get_size())
			if rect.has_point(local_pos):
				# 按下
				finger_index = st.index
				drag_offset = global_pos - global_position
		elif not st.pressed and st.index == finger_index:
			# 松开
			Input.action_release("left")
			Input.action_release("right")
			Input.action_release("down")
			Input.action_release("up")
			finger_index = -1
			global_position = rest_pos
	
	var sd := event as InputEventScreenDrag
	if sd and sd.index == finger_index:
		# 拖动
		var wish_pos = sd.position * get_canvas_transform() - drag_offset
		var movement = (wish_pos - rest_pos).limit_length(DRAG_RADIUS)
		global_position = rest_pos + movement
		
		movement /= DRAG_RADIUS
		if movement.x > 0:
			Input.action_release("left")
			Input.action_press("right", movement.x)
		elif movement.x < 0:
			Input.action_release("right")
			Input.action_press("left", -movement.x)
		if movement.y < 0:
			Input.action_release("down")
			Input.action_press("up", -movement.y)		
		elif movement.y > 0:
			Input.action_release("up")
			Input.action_press("down", movement.y)
