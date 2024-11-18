extends Node2D


# Función que se ejecuta al presionar el botón Cerrar
func _on_ButtonCerrar_pressed():
	# Remueve este nodo de la escena principal
	queue_free()

# Conecta la señal del botón Cerrar al método
func _ready():
	# Utiliza Callable para la conexión en Godot 4
	$TextureRect/Cerrar.connect("pressed", Callable(self, "_on_ButtonCerrar_pressed"))
	
