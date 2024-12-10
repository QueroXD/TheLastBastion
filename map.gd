extends Node2D

func _ready():
	add_to_group("map")
	GameManager.tilemap = $Floor
	
func place_object(obj):
	$Build.add_child(obj)
