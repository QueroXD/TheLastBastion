extends Node

signal item_selected(Sprite2D)

var tilemap

func _ready():
	item_selected.connect(self.item_select)
	
func item_select(sprite: Sprite2D):
	var item = ResourceLoader.load("res://Buildings/Item.tscn").instantiate()
	item.texture = sprite.texture
	
	if sprite.texture and sprite.texture.get_size().y > 16:
		item.offset.y = -16
	
	get_tree().call_group("map", "place_object", item)
