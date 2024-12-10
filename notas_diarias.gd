extends Node2D

# Función que se ejecuta al presionar el botón Cerrar
func _on_ButtonCerrar_pressed():
	# Remueve este nodo de la escena principal
	queue_free()

# Conecta la señal del botón Cerrar al método
func _ready():
	# Conectar el botón de cerrar
	$Nota/Cerrar.connect("pressed", Callable(self, "_on_ButtonCerrar_pressed"))
	
	# Accede al nodo Label llamado Titulo y actualiza su texto con la variable global
	var titulo_label = $Nota/Titulo
	var texto_label = $Nota/NotaDiaria
	if titulo_label:
		titulo_label.text = "Dia actual: " + Global.mi_variable
		
	if texto_label:
		# Ruta del archivo basado en la variable global
		var file_path = "res://Assets/NotasDiarias/" + Global.mi_variable + ".txt"
		# Intentamos leer el archivo
		var file = FileAccess.open(file_path, FileAccess.READ)
		if file:
			# Si el archivo existe, leer su contenido y asignarlo al Label
			var content = file.get_as_text()
			file.close()
			texto_label.text = content
		else:
			# Si no se encuentra el archivo, mostrar un mensaje de error en el Label
			texto_label.text = "No se encontró la nota para el día: " + Global.mi_variable
