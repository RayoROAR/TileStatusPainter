@tool
class_name TileStatusHandler
extends TileMap

const TILESET: TileSet = preload("res://tileset.tres")

var paint_mode: bool = false

var curr_tile_coords: Vector2i

#TODO: Implement Ctrl+Z as Alt+E

# hace el set_cell con la funcion añadida de checkear si esa casilla que queremos pintar existe en el atlas del tileset
func update_cell(layer: int, tile_coords: Vector2i, tile_atlasCoords: Vector2i, sourceID: int = 0):
	if TILESET.get_source(sourceID).has_tile(tile_atlasCoords): # if tile exists in the atlas
		set_cell(layer, tile_coords, sourceID, tile_atlasCoords)


func _ready():
	pass


func _process(delta):
	# pulsar una tecla [1,2,3,4] pinta el status sobre la tile debajo del mouse
	if Input.is_key_pressed(KEY_ALT):
		paint_mode = true
		
		var mouse_pos = get_global_mouse_position()
		curr_tile_coords = floor(mouse_pos / 8)
		
		# default behavior
		if Input.is_key_pressed(KEY_1): paint(curr_tile_coords, 1) # IRON
		elif Input.is_key_pressed(KEY_2): paint(curr_tile_coords, 2) # COPPER
		elif Input.is_key_pressed(KEY_3): paint(curr_tile_coords, 3) # GRASS
		elif Input.is_key_pressed(KEY_4): paint(curr_tile_coords, 4) # CHARRED
	else:
		paint_mode = false
	
	queue_redraw()


func _draw():
	if paint_mode:
		draw_rect(Rect2(curr_tile_coords*8, Vector2(8,8)), Color(0, 1, 1, 0.3))


func paint(tile_coords: Vector2i, status: int):
	var atlas_coords = get_cell_atlas_coords(0, tile_coords)
	# solo pintaremos la tile si no es del status que queremos pintar
	if atlas_coords.y != status - 1:
		# la tile que queremos pintar sera la misma pero de diferente status (desplazamos la Y)
		atlas_coords.y = status - 1 # (las coordenadas empiezan por 0 asi que restamos 1)
		
		update_cell(0, tile_coords, atlas_coords)
		print("painted ", tile_coords, " as ",status)
