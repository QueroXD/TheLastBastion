extends Control

@onready var label_nota_diaria = $TextureRect/Label  # Referencia al Label dentro de la escena

func _ready():
	print("El método _ready() se está ejecutando.")
	# Accedemos a la variable global desde el Singleton
	var mi_variable = Global.mi_variable

	# Construimos la ruta del archivo basado en la variable global
	var file_path = "res://Assets/NotasDiarias/" + mi_variable + ".txt"
	print("Intentando cargar el archivo desde la ruta:", file_path)

	# Intentamos leer el archivo
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		# Leemos todo el contenido del archivo
		var content = file.get_as_text()
		file.close()
		
		# Asignamos el texto leído al Label
		label_nota_diaria.text = content
		print("Contenido del archivo cargado con éxito:", content)
	else:
		# Si no se encuentra el archivo, mostramos un mensaje de error en el Label
		label_nota_diaria.text = "No se encontró la nota para la fecha: " + mi_variable
		print("Error: No se pudo encontrar o abrir el archivo en la ruta:", file_path)
