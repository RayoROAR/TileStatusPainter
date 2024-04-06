class_name TileMap_Utils
extends TileMap


enum TileStatusID {
	IRON = 1,
	COPPER = 2,
	GRASS = 3,
	CHARRED = 4
}

const TILESET: TileSet = preload("res://tileset.tres") # por si necesitas el recurso tileset para algo
