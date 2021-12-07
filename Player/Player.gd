extends KinematicBody2D

const acceleration : float = 500.0
const max_speed : float = 80.0
const friction : float = 500.0
var velocity : Vector2 = Vector2.ZERO

#states that our character can be in
enum {
	WALK,
	KICK,
	PUNCH,
	SPECIAL,
	DIE
}
#default state
var state = WALK

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		WALK:
			walk_state(delta)
		KICK:
			kick_state(delta)
		PUNCH:
			punch_state(delta)
		SPECIAL:
			special_state(delta)

func walk_state(delta):
	var input : Vector2 = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()
	
	if input != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position",input)
		animationTree.set("parameters/Walk/blend_position",input)
		animationTree.set("parameters/Kick/blend_position",input)
		animationTree.set("parameters/Punch/blend_position",input)
		animationTree.set("parameters/Special/blend_position",input)
		animationState.travel("Walk")
		velocity = velocity.move_toward(input * max_speed, acceleration * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO,friction*delta)
	
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("kick"):
		state = KICK
	elif Input.is_action_just_pressed("punch"):
		state = PUNCH
	elif Input.is_action_just_pressed("special"):
		state = SPECIAL
	
func kick_state(_delta):
	velocity = Vector2.ZERO
	animationState.travel("Kick")
	
func on_attack_end():
	state = WALK
	
func punch_state(_delta):
	velocity = Vector2.ZERO
	animationState.travel("Punch")

func special_state(_delta):
	velocity = Vector2.ZERO
	animationState.travel("Special")
	

