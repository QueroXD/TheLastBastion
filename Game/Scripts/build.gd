extends Node2D

# Función que se ejecuta al presionar el botón Cerrar
func _on_ButtonCerrar_pressed():
	# Remueve este nodo de la escena principal
	queue_free()

# Conecta la señal del botón Cerrar al método
func _ready():
	# Conectar el botón de cerrar
	$CanvasLayer/MenuBuild/Cerrar.connect("pressed", Callable(self, "_on_ButtonCerrar_pressed"))

func _on_slot_pressed() -> void:
	queue_free()

func _on_slot_2_pressed() -> void:
	queue_free()

func _on_slot_3_pressed() -> void:
	queue_free()
