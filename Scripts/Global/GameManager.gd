extends Node

signal item_selected(Sprite2D)

var tilemap

func _ready():
	item_selected.connect(self.item_select)

func item_select(sprite: Sprite2D):
	var item = ResourceLoader.load("res://Buildings/Item.tscn").instantiate()
	item.texture = sprite.texture
	
	# Obtener el nodo Area2D que es padre de CollisionShape2D
	var area2d = item.get_node("Area2D")
	if area2d:
		# Obtener CollisionShape2D dentro de Area2D
		var collision_shape = area2d.get_node("CollisionShape2D")
		if collision_shape:
			var shape = collision_shape.shape
			
			# Verificar que la forma de colisión sea de tipo RectangleShape2D
			if shape is RectangleShape2D:
				# Ajustar el tamaño de la colisión para que coincida con la textura
				var texture_size = sprite.texture.get_size()
				shape.extents = texture_size / 2  # Ajuste tanto en X como en Y
				
				# Obtener los ColorRect "Ok" y "Deny" como hijos de CollisionShape2D
				var ok = area2d.get_node("Ok")  # Suponiendo que "Ok" es un ColorRect
				var deny = area2d.get_node("Deny")  # Suponiendo que "Deny" es un ColorRect
				
				# Ajustar la posición de los ColorRect
				if ok and deny:
					var offset_y = shape.extents.y  # Posición en Y es la mitad de la altura de la textura (parte inferior)
					
					# Colocar ambos ColorRects en la parte inferior y centrados
					ok.rect_min_size.x = texture_size.x / 2  # Ajustar el ancho de Ok al 50% del tamaño de la textura
					deny.rect_min_size.x = texture_size.x / 2  # Ajustar el ancho de Deny al 50% del tamaño de la textura
					
					# Centrarlos horizontalmente, usando el tamaño de la textura y restando el ancho de los ColorRects
					ok.rect_position = Vector2((texture_size.x - ok.rect_min_size.x) / 2, offset_y)
					deny.rect_position = Vector2((texture_size.x - deny.rect_min_size.x) / 2, offset_y - ok.rect_min_size.y)  # Justo debajo de Ok
		else:
			print("Error: No se encontró el nodo CollisionShape2D en Area2D.")
	else:
		print("Error: No se encontró el nodo Area2D en item.")
	
	if sprite.texture and sprite.texture.get_size().y > 16:
		item.offset.y = -16
	
	get_tree().call_group("map", "place_object", item)
