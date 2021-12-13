tool
extends TextureProgress

func initialize(current,maximum):
	max_value = maximum
	value = current
	
func _on_Player_experience_gained(data):
	for line in data:
		var target_exp = line[0]
		var max_exp = line[1]
		max_value = max_exp
		yield(animate_value(target_exp),"completed")
		if abs(max_value - value) < 0.01:
			value = min_value

func animate_value(target,tween_duration=1.0):
	$Tween.interpolate_property(self,'value',value,target,tween_duration,Tween.TRANS_SINE,Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	
func _ready():
	initialize(PlayerStats.experience,PlayerStats.experience_required)
	PlayerStats.connect("on_experience_change",self,"_on_Player_experience_gained")
