extends Control

var currentOption

func _ready():
	$Menu/CenterRow/Options/StartButton.grab_focus()
	for option in $Menu/CenterRow/Options.get_children():
		option.connect("pressed",self,"_on_Button_pressed",[option])

func _on_Button_pressed(option):
	currentOption = option
	$FadeIn.show()
	$FadeIn.fade_in()
	
func _on_FadeIn_fade_finished():
	if currentOption.is_quit_button:
		get_tree().quit()
	else:
		get_tree().change_scene(currentOption.scene_to_load)
