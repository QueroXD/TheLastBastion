extends Control

@onready var build_scene = preload("res://Build.tscn")
var build_instance: Node2D

# Método que se ejecuta cuando se presiona el botón "Construction"
func _on_Construction_pressed():
	build_instance = build_scene.instantiate()
	add_child(build_instance)

# Conexión de la señal al presionar el botón "Construction"
@onready var button_construction = $TextureRect/Construction

func _ready():
	# Verifica si el botón "Construction" se ha cargado correctamente
	if button_construction:
		button_construction.connect("pressed", Callable(self, "_on_Construction_pressed"))
	else:
		print("No se pudo encontrar el botón 'Construction'")
