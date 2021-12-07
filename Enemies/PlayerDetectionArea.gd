extends Area2D

var player = null

func can_see_player():
	return player != null

#when a player enters this detection zone
func _on_PlayerDetectionArea_body_entered(body):
	player = body

#when a player exits this detection zone
func _on_PlayerDetectionArea_body_exited(body):
	player = null
