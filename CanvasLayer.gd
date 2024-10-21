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

func _ready():
	set_process_input(true)  # Permitir la detección de input

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		# Inicia las animaciones cuando se haga click
		start_game_animation()

func start_game_animation():
	# Crear y agregar el Tween para la interpolación
	var tween = Tween.new()
	add_child(tween)

	# Animación del título hacia arriba y desvanecimiento
	tween.interpolate_property(titulo, "position:y", titulo.position.y, titulo.position.y - 100, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(titulo, "modulate:a", 1.0, 0.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	# Mueve las nubes hacia fuera de la pantalla
	tween.interpolate_property(nube_izq, "position:x", nube_izq.position.x, nube_izq.position.x - 200, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(nube_der, "position:x", nube_der.position.x, nube_der.position.x + 200, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(nube_bajo, "position:y", nube_bajo.position.y, nube_bajo.position.y + 200, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(nube_arriba, "position:y", nube_arriba.position.y, nube_arriba.position.y - 200, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	# Interpolación de la cámara (zoom hacia dentro)
	tween.interpolate_property(camera, "zoom", camera.zoom, Vector2(1.0, 1.0), 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	# Inicia el Tween
	tween.start()

	# Elimina el texto "Start" después de un tiempo
	start_text.queue_free()
