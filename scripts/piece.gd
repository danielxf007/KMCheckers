extends AnimatedSprite

class_name Piece
enum {KNIGHT, MONSTER, KING_KNIGHT, KING_MONSTER} #Piece types
enum {NORMAL_COLOR, KING_COLOR, SELECTED_COLOR}  #Color states
const ID_BITS: int = 5
const ID_MASK: int = 0x1F
const KING_MASK: int = 0x40
const FRAMES_PATH: String = "res://animations/piece_anim.tres"
const COLORS: Array = ["ffffff", "dfc0ff00", "3dffffff"]
const ANIMATIONS: Array = ["KnightAnim", "MonsterAnim"]

var piece_state: int #piece state [pt1, pt0, id4, id3, id2, id1, id0]
var selected: bool

func init(id: int, pos: Vector2) -> void:
	self.frames = load(self.FRAMES_PATH)
	self.piece_state = id
	self.selected = false
	self.global_position = pos

func activate() -> void:
	self.playing = true
	self.show()

func desactivate() -> void:
	self.playing = false
	self.selected = false
	self.hide()

func set_type(type: int) -> void:
	self.piece_state &= self.ID_MASK
	self.piece_state |= (type<<self.ID_BITS)

func reset() -> void:
	self.modulate = self.COLORS[NORMAL_COLOR]
	self.selected = false

func move(pos: Vector2) -> void:
	self.global_position = pos

func is_king() -> bool:
	return bool(self.piece_state & self.KING_MASK)

func promote() -> void:
	self.curr_piece_state |= self.KING_MASK
	self.modulate = self.COLORS[KING_COLOR]

func is_selected() -> bool:
	return self.selected

func select() -> void:
	self.selected = !self.selected
	self.modulate = self.COLORS[SELECTED_COLOR if self.selected else NORMAL_COLOR]
