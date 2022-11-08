class_name Consts

enum MOVEMENT_TYPE {FREE = 0, TILE = 1}
enum TERRAIN_TAGS {GRASS = 1, WATER = 2}

enum Gender {Male, Female, Genderless}

const MOVEMENT = MOVEMENT_TYPE.TILE
const TILE_SIZE = 32

const PLAYER_SCENE = "res://Scenes/Player.tscn"
const MESSAGEBOX_SCENE = "res://Scenes/Textboxes/MessageBox.tscn"
const SPRITE_COLLECTION_PATH = "res://Scenes/Sprite_Collections/"

const DATA_PATH = "res://Source/Data/"
const POKEMON_PATH = DATA_PATH + "Pokemon/"
const TYPE_PATH = DATA_PATH + "Type/"
const MOVE_PATH = DATA_PATH + "Move/"

const MAP_OBJECT_SPAWN_RADIUS = TILE_SIZE * 15
const CHARACTER_WALK_SPEED = 128
const CHARACTER_RUN_SPEED = CHARACTER_WALK_SPEED * 2
const TRAINER_VISION_RANGE = TILE_SIZE * 6

const ALLY_POKEMON_SCALE = 0.5
const OPPONENT_POKEMON_SCALE = 0.4

const SHINY_CHANCE = 1.0 / 4096.0

const NATURE_STAT_BOOST = {
	"adamant": [1.1, 1.0, 0.9, 1.0, 1.0],
	"bashful": [1.0, 1.0, 1.0, 1.0, 1.0],
	"bold": [0.9, 1.1, 1.0, 1.0, 1.0],
	"brave": [1.1, 1.0, 1.0, 1.0, 0.9],
	"calm": [0.9, 1.0, 1.0, 1.1, 1.0],
	"careful": [1.0, 1.0, 0.9, 1.1, 1.0],
	"docile": [1.0, 1.0, 1.0, 1.0, 1.0],
	"gentle": [1.0, 0.9, 1.0, 1.1, 1.0],
	"hardy": [1.0, 1.0, 1.0, 1.0, 1.0],
	"hasty": [1.0, 0.9, 1.0, 1.0, 1.1],
	"impish": [1.0, 1.1, 0.9, 1.0, 1.0],
	"jolly": [1.0, 1.0, 0.9, 1.0, 1.1],
	"lax": [1.0, 1.1, 1.0, 0.9, 1.0],
	"lonely": [1.1, 0.9, 1.0, 1.0, 1.0],
	"mild": [1.0, 0.9, 1.1, 1.0, 1.0],
	"modest": [0.9, 1.0, 1.1, 1.0, 1.0],
	"naive": [1.0, 1.0, 1.0, 0.9, 1.1],
	"naughty": [1.1, 1.0, 1.0, 0.9, 1.0],
	"quiet": [1.0, 1.0, 1.1, 1.0, 0.9],
	"quirky": [1.0, 1.0, 1.0, 1.0, 1.0],
	"rash": [1.0, 1.0, 1.1, 0.9, 1.0],
	"relaxed": [1.0, 1.1, 1.0, 1.0, 0.9],
	"sassy": [1.0, 1.0, 1.0, 1.1, 0.9],
	"serious": [1.0, 1.0, 1.0, 1.0, 1.0],
	"timid": [0.9, 1.0, 1.0, 1.0, 1.1],
}
