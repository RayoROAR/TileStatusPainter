class_name TileStatusHandler
extends TileMap_Utils


var painting_status: int = 0


# hace el set_cell con la funcion añadida de checkear si esa casilla que queremos pintar existe en el atlas del tileset
func update_cell(layer: int, tile_coords: Vector2i, tile_atlasCoords: Vector2i, sourceID: int = 0):
	if TILESET.get_source(sourceID).has_tile(tile_atlasCoords): # if tile exists in the atlas
		set_cell(layer, tile_coords, sourceID, tile_atlasCoords)



#func _unhandled_input(event) -> void: # use this for discrete input detection
func _input(_event) -> void:
	# simple debug para mostrar las coordenadas de una tile en el tilemap
	if Input.is_action_just_pressed("debug"): # middle mouse click
		var mouse_pos = get_global_mouse_position()
		var tile_coords = floor(mouse_pos / 8)
		print(tile_coords)
	
	
	# pulsar una tecla [1,2,3,4] selecciona el status. Hacer click, lo pinta
	if Input.is_action_just_pressed("paint_iron"): # tecla "1"
		painting_status = 1
		print("Currently painting with IRON")
		
	elif Input.is_action_just_pressed("paint_copper"): # tecla "2"
		painting_status = 2
		print("Currently painting with COPPER")
		
	elif Input.is_action_just_pressed("paint_grass"): # tecla "3"
		painting_status = 3
		print("Currently painting with GRASS")
		
	elif Input.is_action_just_pressed("paint_charred"): # tecla "4"
		painting_status = 4
		print("Currently painting with CHARRED")
		
		
	elif Input.is_action_just_pressed("stop_painting"): # tecla "5"
		painting_status = 0
	
	
	if Input.is_action_pressed("paint"): # LeftClick
		if painting_status != 0:
			var mouse_pos = get_global_mouse_position()
			var tile_coords = floor(mouse_pos / 8)
			var atlas_coords = get_cell_atlas_coords(0, tile_coords)
			
			# solo pintaremos la tile si no es del status que queremos pintar
			if atlas_coords.y != painting_status - 1:
				# la tile que queremos pintar sera la misma pero de diferente status (desplazamos la Y)
				atlas_coords.y = painting_status - 1 # (las coordenadas empiezan por 0 asi que restamos 1)
				
				update_cell(0, tile_coords, atlas_coords)
