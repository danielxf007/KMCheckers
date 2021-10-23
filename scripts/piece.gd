extends AnimatedSprite

class_name Piece
enum {KNIGHT, MONSTER, KING_KNIGHT, KING_MONSTER} #Piece states
enum {NORMAL_COLOR, KING_COLOR, SELECTED_COLOR}  #Color states
const KING_MASK: int = 0x10
const FRAMES_PATH: String = "res://animations/piece_anim.tres"
const COLORS: Array = ["ffffff", "dfc0ff00", "3dffffff"]
const ANIMATIONS: Array = ["KnightAnim", "MonsterAnim"]

var init_piece_state: int
var curr_piece_state: int
var curr_color_state: int
var selected: bool

func init(_init_piece_state: int, pos: Vector2) -> void:
	self.frames = load(self.FRAMES_PATH)
	self.init_piece_state = _init_piece_state
	self.curr_piece_state = _init_piece_state
	self.selected = false
	self.animation = self.ANIMATIONS[_init_piece_state]
	self.curr_color_state = NORMAL_COLOR
	self.global_position = pos
	self.hide()

func activate() -> void:
	self.playing = true
	self.show()

func desactivate() -> void:
	self.playing = false
	self.selected = false
	self.hide()

func reset() -> void:
	self.curr_piece_state = self.init_piece_state
	self.curr_color_state = NORMAL_COLOR
	self.modulate = self.COLORS[NORMAL_COLOR]
	self.selected = false

func move(pos: Vector2) -> void:
	self.global_position = pos

func is_king() -> bool:
	return bool(self.curr_piece_state & self.KING_MASK)

func promote() -> void:
	self.curr_piece_state |= self.KING_MASK
	self.modulate = self.COLORS[self.KING]

func is_selected() -> bool:
	return self.selected

func select() -> void:
	self.selected = !self.selected
	self.modulate = self.COLORS[SELECTED_COLOR if self.selected else NORMAL_COLOR]
