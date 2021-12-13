extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var fullHeart = $FullHeart
onready var emptyHeart = $EmptyHeart

func set_hearts(value):
	hearts = clamp(value,0,max_hearts)
	if fullHeart != null:
		fullHeart.rect_size.x = hearts * 15

func set_max_hearts(value):
	max_hearts = max(value,1)
	self.hearts = min(hearts,max_hearts)
	if emptyHeart != null:
		emptyHeart.rect_size.x = max_hearts * 15
	
func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.connect("on_health_change",self,"set_hearts")
	PlayerStats.connect("on_max_health_change",self,"set_max_hearts")
