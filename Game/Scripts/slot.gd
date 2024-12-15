extends Button

@export var item_name: String = ""  # Inicializamos con una cadena vacía

var texture: Texture

func _ready():
	var folder_path = "res://Buildings/"
	var textures = []
	var files = [
		"casa.png",
		"fabrica.png",
		"granja.png",
		"LightHouse.png"
	]

	for file_name in files:
		var file_path = folder_path + file_name
		if ResourceLoader.exists(file_path):
			textures.append({"texture": load(file_path), "name": file_name})  # Guardamos textura y nombre

	if textures.size() > 0:
		var index = get_index()
		if index < textures.size():
			var selected_texture = textures[index]
			texture = selected_texture["texture"]
			item_name = selected_texture["name"]  # Asignamos el nombre asociado
			$SlotRect.texture = texture
			$SlotRect.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED

func _on_button_down() -> void:
	# Cuando el botón es presionado, creamos un Sprite2D con la textura y lo pasamos
	if texture:
		var sprite = Sprite2D.new()
		sprite.texture = texture  # Asignamos la textura al Sprite2D
		GameManager.item_select(sprite)  # Pasamos el Sprite2D a GameManager
		if item_name == "casa.png":  # Comparamos con el nombre correcto
			Global.poblacion += 40
		if item_name == "LightHouse.png":  # Comparamos con el nombre correcto
			Global.poblacion += 15
		if item_name == "granja.png":  # Comparamos con el nombre correcto
			Global.comida += 120
		if item_name == "fabrica.png":  # Comparamos con el nombre correcto
			Global.recursos += 180
