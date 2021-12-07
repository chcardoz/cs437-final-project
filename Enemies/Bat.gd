extends KinematicBody2D

export(float) var acceleration : float = 300.0
export(float) var max_speed : float = 50.0
export(float) var velocity_friction : float = 200.0
export(float) var knockback_friction : float = 200.0
var knockback : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
export(float) var knockback_amount : float = 120
onready var batStats = $Stats
onready var playerDetectionArea = $PlayerDetectionArea
onready var sprite = $AnimatedSprite

#states the bat enemy can be in
enum {
	IDLE,
	WANDER,
	CHASE
}

#initial state
var state = IDLE

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO,knockback_friction*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO,velocity_friction*delta)
			seek_player()
			
		WANDER:
			pass
		CHASE:
			var player = playerDetectionArea.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction*max_speed,acceleration*delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
	
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionArea.can_see_player():
		state = CHASE

func _on_Hurtbox_area_entered(area):
	batStats.health -= area.damage
	knockback = area.knockback_vector * knockback_amount

func _on_Stats_no_health():
	queue_free()
