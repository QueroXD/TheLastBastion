extends Node2D

@onready var build = $"."
@onready var box = $box

# Ruta a la carpeta de objetos
const OBJECTS_FOLDER = "res://Objects"

func _ready():
	if not box:
		print("Error: El nodo 'box' no se encontró. Verifica la estructura de tu escena.")
		return
	if not build:
		print("Error: El nodo 'build' no se encontró. Verifica la estructura de tu escena.")
		return
	load_buttons()

func load_buttons():
	var dir = DirAccess.open(OBJECTS_FOLDER)
	if dir:
		for file_name in dir.get_files():
			if file_name.ends_with(".tscn"):
				create_button(file_name)

func create_button(scene_name):
	var button = Button.new()
	button.text = scene_name.replace(".tscn", "")
	button.set_meta("scene_name", scene_name)
	button.connect("pressed", Callable(self, "_on_button_pressed").bind(scene_name))
	
	# Verifica si el botón se añadió correctamente
	build.add_child(button)
	print("Botón agregado:", scene_name)  # Imprime si el botón fue agregado

func _on_button_pressed(scene_name):
	if not box:
		print("Error: El nodo 'box' no está disponible para cargar la escena.")
		return
	var scene_path = OBJECTS_FOLDER + "/" + scene_name
	var scene = load(scene_path).instantiate()
	if scene:
		clear_box()
		scene.modulate = Color(1, 1, 1, 0.5) # Reduce la opacidad
		box.add_child(scene)

func clear_box():
	if not box:
		print("Error: No se puede limpiar un nodo 'box' inexistente.")
		return
	for child in box.get_children():
		child.queue_free()

func close_popup():
	hide()
