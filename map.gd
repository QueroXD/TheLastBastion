extends Node2D

# Exportamos la escena buildable_sprite.tscn para poder asignarla desde el editor
@export var buildable_sprite_scene: PackedScene

func _ready():
	pass  # No es necesario nada aquí por ahora

# Usamos _unhandled_input() para recibir los eventos del ratón
func _unhandled_input(event: InputEvent) -> void:
	# Verificamos si el evento es un clic del ratón
	if event is InputEventMouseButton:
		# Si el clic es con el botón izquierdo y el botón fue presionado
		if event.button_index == MouseButton.ButtonLeft and event.pressed:
			# Instanciamos el sprite de la escena
			var buildable_sprite = buildable_sprite_scene.instantiate()
			
			# Establecemos la posición del sprite al lugar donde se hizo clic
			buildable_sprite.position = get_local_mouse_position()
			
			# Añadimos el sprite a la escena
			add_child(buildable_sprite)
