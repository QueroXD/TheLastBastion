extends Node

signal item_selected

var tilemap

func _ready():
	# Conectar la señal "item_selected" a la función "item_select" 
	item_selected.connect(self.item_select)

func item_select(texture: Sprite2D):
	var item = ResourceLoader.load("res://Buildings/Item.tscn").instantiate()
	item.texture = texture
	
	if texture.get_size().y > 16:
		item.offset.y = -16
	
	# Llamar al grupo de objetos en la escena para colocar el item
	get_tree().call_group("MapGroup", "place_object", item)
