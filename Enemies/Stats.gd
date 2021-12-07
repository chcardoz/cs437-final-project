extends Node

export(int) var max_health : int = 1
onready var health : int = max_health setget set_health

signal no_health
signal on_health_change(newhealth)

func set_health(value):
	health = value
	emit_signal("on_health_change",health)
	if health <=0 :
		emit_signal("no_health")


