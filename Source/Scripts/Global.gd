class_name Global

enum MOVEMENT_TYPE {FREE = 0, TILE = 1}

const MOVEMENT = MOVEMENT_TYPE.TILE
const TILE_SIZE = 16

const MESSAGEBOX_SCENE = "res://Scenes/Textboxes/MessageBox.tscn"

static func create_message_box():
	return load(MESSAGEBOX_SCENE).instance()
