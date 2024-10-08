extends TextureButton

# Este método se llama cuando el nodo se instancia en la escena
func _ready():
	# Conectar la señal 'pressed' a la función que maneja la pausa
	connect("pressed", self, "_on_Boton_de_Pausa_pressed")

	# Asegurarte que el botón funcione cuando el juego esté en pausa
	pause_mode = Node.PAUSE_MODE_PROCESS

	# Fijar la posición del botón en la esquina superior izquierda
	rect_position = Vector2(10, 10)  # Ajusta las coordenadas si es necesario

# Función que maneja la pausa del juego
func _on_Boton_de_Pausa_pressed():
	# Alternar el estado de pausa
	get_tree().paused = not get_tree().paused
