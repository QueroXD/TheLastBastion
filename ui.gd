extends Control

@onready var build_scene = preload("res://Build.tscn")
var build_instance: Node2D

# Método que se ejecuta cuando se presiona el botón "Construction"
func _on_Construction_pressed():
	# Desactiva el botón para que no se pueda presionar
	$Menu/Construction.disabled = true
	
	# Instancia y agrega la escena Build
	build_instance = build_scene.instantiate()
	add_child(build_instance)

	# Conectamos la señal de "scene_exited" para volver a habilitar el botón cuando se cierre la escena
	build_instance.connect("tree_exited", Callable(self, "_on_build_scene_closed"))

# Método que se ejecuta cuando se cierra la escena Build
func _on_build_scene_closed():
	# Habilitamos nuevamente el botón
	$Menu/Construction.disabled = false
	

# Conexión de la señal al presionar el botón "Construction"
@onready var button_construction = $Menu/Construction

func _ready():
	# Verifica si el botón "Construction" se ha cargado correctamente
	if button_construction:
		button_construction.connect("pressed", Callable(self, "_on_Construction_pressed"))
	else:
		print("No se pudo encontrar el botón 'Construction'")
