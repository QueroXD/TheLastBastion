extends Button

@export var item_name: String

var texture: Texture  # Guardar la textura asociada al botón

func _ready():
	var folder_path = "res://Buildings/"
	var dir = DirAccess.open(folder_path)
	var textures = []
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png"):
				textures.append(load(folder_path + file_name))
			file_name = dir.get_next()
		dir.list_dir_end()

	if textures.size() > 0:
		var index = get_index()
		if index < textures.size():
			texture = textures[index]
			
			# Configurar el TextureRect
			var slot_rect = $SlotRect
			slot_rect.texture = texture
			slot_rect.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED


func _on_button_down() -> void:
	# Cuando el botón es presionado, creamos un Sprite2D con la textura y lo pasamos
	if texture:
		var sprite = Sprite2D.new()
		sprite.texture = texture  # Asignamos la textura al Sprite2D
		GameManager.item_select(sprite)  # Pasamos el Sprite2D a GameManager
