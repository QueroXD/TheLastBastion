extends Sprite2D

func _ready():
	pass

func _process(delta):
	var local_mouse_position = GameManager.tilemap.to_local(get_global_mouse_position())
	var mouse_tile = GameManager.tilemap.local_to_map(local_mouse_position)
	var local_pos = GameManager.tilemap.map_to_local(mouse_tile)
	var world_pos = GameManager.tilemap.to_global(local_pos)
	
	global_position = world_pos
	
	if $Area2D.get_overlapping_areas().size() > 0:
		$Deny.show()
		$Ok.hide()
	else:
		$Ok.show()
		$Deny.hide()

func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
		var arr = $Area2D.get_overlapping_areas()
		for obj in arr:
			obj.get_parent().queue_free()
		
		set_process(false)
		set_process_unhandled_input(false)
		$Area2D.monitoring = false
		
		$Ok.hide()
		$Deny.hide()
