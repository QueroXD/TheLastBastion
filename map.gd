extends Node2D

func _ready():
	GameManager.tilemap = $Floor
	
func place_object(obj):
	$Build.add_child(obj)
