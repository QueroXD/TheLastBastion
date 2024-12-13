extends Button

@export var item_name: String

var texture: Texture  # Guardar la textura asociada al botón

func _ready():
	var folder_path = "res://Buildings/"
	var dir = DirAccess.open(folder_path)

	# Lista para almacenar los archivos .png de la carpeta
	var textures = []
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png"):
				# Cargar todas las texturas en la lista
				textures.append(load(folder_path + file_name))
			file_name = dir.get_next()
		dir.list_dir_end()

	# Asignamos una textura específica al botón si hay alguna
	if textures.size() > 0:
		var index = get_index()  # Usamos el índice del botón para asignar una textura
		if index < textures.size():
			texture = textures[index]
			self.icon = texture  # Asignamos la textura al botón visualmente

func _on_button_down() -> void:
	# Cuando el botón es presionado, creamos un Sprite2D con la textura y lo pasamos
	if texture:
		var sprite = Sprite2D.new()
		sprite.texture = texture  # Asignamos la textura al Sprite2D
		GameManager.item_select(sprite)  # Pasamos el Sprite2D a GameManager
