extends Sprite2D

@onready var hammer = $Hammer

func _ready():
	pass

func _process(_delta):
	var local_mouse_position = GameManager.tilemap.to_local(get_global_mouse_position())
	var mouse_tile = GameManager.tilemap.local_to_map(local_mouse_position)
	var local_pos = GameManager.tilemap.map_to_local(mouse_tile)
	var world_pos = GameManager.tilemap.to_global(local_pos)
	
	global_position = world_pos
	
	if $Area2D.get_overlapping_areas().size() > 0:
		$Area2D/CollisionShape2D/Deny.show()
		$Area2D/CollisionShape2D/Ok.hide()
	else:
		$Area2D/CollisionShape2D/Ok.show()
		$Area2D/CollisionShape2D/Deny.hide()

func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
		hammer.play(0.0)
		#Global.poblacion += 15
		var arr = $Area2D.get_overlapping_areas()
		for obj in arr:
			obj.get_parent().queue_free()
		
		set_process(false)
		set_process_unhandled_input(false)
		$Area2D.monitoring = false
		
		$Area2D/CollisionShape2D/Ok.hide()
		$Area2D/CollisionShape2D/Deny.hide()
