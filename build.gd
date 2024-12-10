extends Control

@onready var build = $"."        # Nodo "Build"
@onready var box = $box          # Nodo "box" (TextureRect)
@onready var grid_container = $box/GridContainer  # Nodo "GridContainer" dentro de "box"

const OBJECTS_FOLDER = "res://Objects"

var current_scene = null  # Para mantener la referencia de la escena cargada

func _ready():
	if not box:
		print("Error: El nodo 'box' no se encontró.")
		return
	if not build:
		print("Error: El nodo 'build' no se encontró.")
		return
	if not grid_container:
		print("Error: El nodo 'GridContainer' no se encontró dentro de 'box'.")
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
	
	# Añadir el botón al GridContainer dentro de "box"
	grid_container.add_child(button)
	print("Botón agregado:", scene_name)

func _on_button_pressed(scene_name):
	if not box:
		print("Error: El nodo 'box' no está disponible para cargar la escena.")
		return

	var scene_path = OBJECTS_FOLDER + "/" + scene_name
	var scene = load(scene_path).instantiate()

	if scene:
		clear_box()
		scene.modulate = Color(1, 1, 1, 0.5)  # Reduce la opacidad
		box.add_child(scene)
		current_scene = scene  # Guardamos la referencia de la escena cargada
		close_popup()  # Cierra el popup al presionar el botón
		
		# Cargar el contenido en la escena principal (main.tscn)
		var main_scene = get_tree().root.get_node("Main")  # Accede a la escena principal en el árbol
		if main_scene:
			main_scene.add_child(scene)  # Agregar la escena cargada a la escena principal

func clear_box():
	if not box:
		print("Error: No se puede limpiar un nodo 'box' inexistente.")
		return
	for child in box.get_children():
		child.queue_free()

func close_popup():
	hide()
