extends Node2D

# Carga la escena Intro
var intro_scene: PackedScene = preload("res://Intro.tscn")
var intro_instance: Node = null
@onready var backgroundmusic = $BackgroundMusic

func _ready() -> void:
	# Instancia y añade la escena Intro
	intro_instance = intro_scene.instantiate()
	add_child(intro_instance)
	intro_instance.tree_exited.connect(_on_intro_instance_removed)

func _on_intro_instance_removed() -> void:
	backgroundmusic.play(0.0)
