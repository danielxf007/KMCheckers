extends AnimatedSprite

class_name Piece
enum {KNIGHT, MONSTER, KING_KNIGHT, KING_MONSTER} #Piece types
enum {NORMAL_COLOR, KING_COLOR, SELECTED_COLOR}  #Color types
enum {PLAYER_ID_MASK=0x80, KING_MASK=0x40, PIECE_TYPE_MASK=0x20, ID_MASK=0x1F} #Masks
enum {PIECE_TYPE_BIT=5, PLAYER_ID_BIT=8} #Start bit positions
const FRAMES_PATH: String = "res://animations/piece_anim.tres"
const COLORS: Array = ["ffffff", "dfc0ff00", "3dffffff"]
const ANIMATIONS: Array = ["KnightAnim", "MonsterAnim"]

var piece_state: int #piece state [pl, k, pt, id4, id3, id2, id1, id0]
var selected: bool

func init(id: int, pos: Vector2) -> void:
	self.frames = load(self.FRAMES_PATH)
	self.piece_state = id 
	self.selected = false
	self.global_position = pos
	self.hide()

func get_id() -> int:
	return self.piece_state & ID_MASK

func get_player_id() -> int:
	return self.piece_state & PLAYER_ID_MASK

func activate() -> void:
	self.playing = true
	self.show()

func desactivate() -> void:
	self.stop()
	self.selected = false
	self.hide()

func set_type(type: int) -> void:
	self.piece_state &= (ID_MASK | PLAYER_ID_MASK)
	self.piece_state |= (type<<PIECE_TYPE_BIT)
	self.play(self.ANIMATIONS[type])

func set_player_id(player_id: int) -> void:
	self.piece_state |= (player_id<<PLAYER_ID_BIT)

func reset() -> void:
	self.piece_state &= (PIECE_TYPE_MASK| PLAYER_ID_MASK | ID_MASK)
	self.modulate = self.COLORS[NORMAL_COLOR]
	self.selected = false

func move(pos: Vector2) -> void:
	self.global_position = pos

func is_king() -> bool:
	return bool(self.piece_state & KING_MASK)

func promote() -> void:
	self.curr_piece_state |= KING_MASK
	self.modulate = self.COLORS[KING_COLOR]

func is_selected() -> bool:
	return self.selected

func select() -> void:
	self.selected = !self.selected
	self.modulate = self.COLORS[SELECTED_COLOR if self.selected else NORMAL_COLOR]
