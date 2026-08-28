extends CharacterBody2D

@export var speed: float = 50
@onready var anim = $AnimatedSprite2D

var last_direction = "down"

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	update_animation(direction)

func update_animation(direction: Vector2) -> void:
	if direction.length() == 0:
		if last_direction == "left":
			anim.flip_h = true
			anim.play("idle_right")
		else:
			anim.flip_h = false
			anim.play("idle_" + last_direction)
		return
	
	var anim_dir = last_direction
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim_dir = "right"
			anim.flip_h = false
		else:
			anim_dir = "left"
			anim.flip_h = true
	else:
		anim_dir = "down" if direction.y > 0 else "up"
		anim.flip_h = false
		
	last_direction = anim_dir
	
	var anim_to_play = "right" if anim_dir == "left" else anim_dir
	anim.play("move_"+ anim_to_play)	
	
	
