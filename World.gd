extends Node2D

export(Vector2) var dirt_noise_limit = Vector2(1,0.1)
export(Vector2) var clif_noise_limit = Vector2(-0.5,-1)
export(Vector2) var environment_noise_limit = Vector2(0.1,-0.3)

onready var noise : OpenSimplexNoise = OpenSimplexNoise.new()
onready var bushScene = preload("res://World/Bush.tscn")
var startvec = Vector2(-32*100/2,-32*100/2)
var endvec = Vector2(32*100/2,32*100/2)

func _ready():
	randomize()
	noise.seed = randi()
	#Open simplex noise configuration variables
	noise.octaves = 9
	noise.period = 4
	noise.lacunarity = 1.5
	noise.persistence = 0.1
	
	generate_clif_map()
	generate_road_map()
	generate_environment()
	
	
func generate_road_map():
	for x in range(startvec.x/32,endvec.x/32):
		for y in range(startvec.y/32,endvec.y/32):
			var temp_noise = noise.get_noise_2d(x,y)
			if temp_noise < dirt_noise_limit.x and temp_noise > dirt_noise_limit.y:
				$DirtPathTileMap.set_cell(x,y,0)
	$DirtPathTileMap.update_bitmask_region()

func generate_clif_map():
	for x in range(startvec.x/32,endvec.x/32):
		for y in range(startvec.y/32,endvec.y/32):
			var temp_noise = noise.get_noise_2d(x,y)
			if temp_noise < clif_noise_limit.x and temp_noise > clif_noise_limit.y:
				$CliffTileMap.set_cell(x,y,0)
				$DirtPathTileMap.set_cell(x,y,0)
	$CliffTileMap.update_bitmask_region()
	
func generate_environment():
	for x in range(startvec.x/32,endvec.x/32):
		for y in range(startvec.y/32,endvec.y/32):
			var temp_noise = noise.get_noise_2d(x,y)
			if temp_noise < environment_noise_limit.x and temp_noise > environment_noise_limit.y:
				var chance = randi()%10
				if chance < 2:
					var bush = bushScene.instance()
					$YSort/Environment.add_child(bush)
					bush.global_position = Vector2(x*32,y*32)
