extends Node2D

# Carga la escena Intro
var intro_scene: PackedScene = preload("res://Intro.tscn")
var intro_instance: Node = null
@onready var cameraHud = $Camera2D 
@onready var backgroundmusic = $BackgroundMusic

func _ready() -> void:
	# Instancia y añade la escena Intro
	cameraHud.modulate.a = 0.0  # Inicia con opacidad 0
	intro_instance = intro_scene.instantiate()
	add_child(intro_instance)
	intro_instance.tree_exited.connect(_on_intro_instance_removed)

func _on_intro_instance_removed() -> void:
	backgroundmusic.play(0.0)
	var tween = create_tween()
	tween.tween_property(cameraHud, "modulate:a", 1.0, 2.0)  # Aumenta opacidad en 2 segundos

@onready var particle_system = $CanvasLayer/Snow
@onready var camera = $Camera2D

var base_gravity = Vector2(45.0, 98.0)
var gravity_increase_factor = 15.0
var current_gravity = base_gravity

var last_position = Vector2.ZERO

func _process(delta):
	if camera.position != last_position:
		current_gravity = base_gravity * gravity_increase_factor
	else:
		current_gravity = base_gravity
	
	last_position = camera.position

	update_particle_gravity(current_gravity)

func update_particle_gravity(gravity: Vector2):
	if particle_system is GPUParticles2D:
		if particle_system.process_material is ParticleProcessMaterial:
			var gravity_3d = Vector3(gravity.x, gravity.y, 0)
			particle_system.process_material.gravity = gravity_3d
		else:
			print("El material de procesamiento no es válido. Asegúrate de que sea ParticleProcessMaterial.")
	elif particle_system is CPUParticles2D:
		particle_system.gravity = gravity
	else:
		print("Error: Nodo no válido para sistema de partículas.")
