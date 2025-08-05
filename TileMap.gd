extends TileMap

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("draw"):
		var tile : Vector2 = local_to_map(get_global_mouse_position())
		
		set_cell(0, tile, 0, Vector2i(0,0))
		
	
	
	var used_cells = get_used_cells(0)
	var a = []
	for i in used_cells:
		var vector2 = Vector2i(i.x, i.y)
		a.append(vector2)
	for vec in a:
		var current_tile = vec
		
		a.erase(vec)
		
		for other_tile in a:
			if other_tile.y == current_tile.y:
				#other_tile = local_to_map(other_tile)
				#current_tile = local_to_map(current_tile)
				var x = other_tile.x - current_tile.x
				var y = x
				Global.global_other_tile = other_tile
				Global.global_current_tile = current_tile
				Global.x= x
				Global.y = y
				Global.all_cells = used_cells
				queue_redraw()
		
		
func _draw():

	var first = Vector2i(map_to_local(Global.global_current_tile))
	
	var second = Vector2i(first.x+(Global.x*16), first.y)
	
	var third = Vector2i(second.x, second.y+(Global.y*16))
	
	var fourth = Vector2i(third.x - (Global.x*16), third.y)
	
	var all_cells = get_used_cells(0)
	if local_to_map(fourth) in all_cells and local_to_map(third) in all_cells:
		draw_line(first, second, Color.AQUA, 10, false)
		draw_line(second, third, Color.AQUA, 10, false)
		draw_line(third, fourth, Color.AQUA, 10, false)
		draw_line(fourth, first, Color.AQUA, 10, false)
