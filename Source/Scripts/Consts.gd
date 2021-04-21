class_name Consts

enum MOVEMENT_TYPE {FREE = 0, TILE = 1}
enum TERRAIN_TAGS {GRASS = 1, WATER = 2}

const MOVEMENT = MOVEMENT_TYPE.TILE
const TILE_SIZE = 32

const PLAYER_SCENE = "res://Scenes/Player.tscn"
const MESSAGEBOX_SCENE = "res://Scenes/Textboxes/MessageBox.tscn"
const SPRITE_COLLECTION_PATH = "res://Scenes/Sprite_Collections/new/"

const DATA_PATH = "res://Source/Data/"
const POKEMON_PATH = DATA_PATH + "Pokemon/"
const TYPE_PATH = DATA_PATH + "Type/"
const MOVE_PATH = DATA_PATH + "Move/"

const CHARACTER_WALK_SPEED = 128
const CHARACTER_RUN_SPEED = CHARACTER_WALK_SPEED * 2

const SHINY_CHANCE = 1.0 / 4096.0
