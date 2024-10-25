extends CanvasLayer

# Referencias a los nodos en el CanvasLayer
onready var titulo = $TitleGame  # Label para el título del juego
onready var start_text = $start  # Label para el texto "Start"
onready var nube_izq = $nubeIzq  # Sprite de la nube izquierda
onready var nube_der = $nubeDer  # Sprite de la nube derecha
onready var nube_bajo = $nubeBajo  # Sprite de la nube inferior
onready var nube_arriba = $nubeArriba  # Sprite de la nube superior
onready var camera = $"../Camera2D"  # Referencia a la Camera2D (subir un nivel en el árbol)

var transition_speed = 300  # Velocidad de la animación de las nubes
var game_started = false  # Variable para rastrear si el juego ha comenzado

func _ready():
	set_process_input(true)  # Permitir la detección de input
	

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if not game_started:  # Verificar si el juego ya ha comenzado
			game_started = true  # Marcar que el juego ha comenzado
			start_game_animation()

func start_game_animation():
	# Crear y agregar el Tween para la interpolación
	var tween = Tween.new()
	add_child(tween)

	# Verificar que el nodo del título aún es válido
	if is_instance_valid(titulo):
		# Animación del título hacia arriba y desvanecimiento
		tween.interpolate_property(titulo, "position:y", titulo.position.y, titulo.position.y - 100, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.interpolate_property(titulo, "modulate:a", 1.0, 0.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

		# Conectar la señal del Tween para saber cuándo la animación del título ha terminado
		tween.connect("tween_completed", self, "_on_tween_completed")

	# Verificar que las nubes son válidas
	if is_instance_valid(nube_izq):
		tween.interpolate_property(nube_izq, "position:x", nube_izq.position.x, nube_izq.position.x - 500, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if is_instance_valid(nube_der):
		tween.interpolate_property(nube_der, "position:x", nube_der.position.x, nube_der.position.x + 500, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if is_instance_valid(nube_bajo):
		tween.interpolate_property(nube_bajo, "position:y", nube_bajo.position.y, nube_bajo.position.y + 500, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if is_instance_valid(nube_arriba):
		tween.interpolate_property(nube_arriba, "position:y", nube_arriba.position.y, nube_arriba.position.y - 500, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	# Verificar que la cámara es válida
	if is_instance_valid(camera):
		# Interpolación de la cámara (zoom hacia dentro)
		tween.interpolate_property(camera, "zoom", camera.zoom, Vector2(5.6, 5.6), 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	# Inicia el Tween
	tween.start()

	# Verificar que el texto "Start" es válido antes de eliminarlo
	if is_instance_valid(start_text):
		start_text.queue_free()

# Función que se llama cuando el Tween termina
func _on_tween_completed(object, key):
	if object == titulo and key == "modulate:a":
		if is_instance_valid(titulo):
			titulo.queue_free()  # Eliminar el título después de la animación
