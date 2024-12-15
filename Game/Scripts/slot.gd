extends Button

@export var item_name: String

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
			textures.append(load(file_path))

	if textures.size() > 0:
		var index = get_index()
		if index < textures.size():
			texture = textures[index]
			$SlotRect.texture = texture
			$SlotRect.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED

func _on_button_down() -> void:
	# Cuando el botón es presionado, creamos un Sprite2D con la textura y lo pasamos
	if texture:
		var sprite = Sprite2D.new()
		sprite.texture = texture  # Asignamos la textura al Sprite2D
		GameManager.item_select(sprite)  # Pasamos el Sprite2D a GameManager
