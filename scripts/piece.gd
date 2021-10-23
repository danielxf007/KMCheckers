extends AnimatedSprite

class_name Piece
const FRAMES_PATH: String = "res://animations/piece_anim.tres"
const NORMAL: String = "normal"
const KING: String = "king"
const SELECTED: String = "selected"
const COLORS: Dictionary = {"normal": "ffffff", "king": "dfc0ff00",
"selected": "3dffffff"}
const ANIMATIONS: Dictionary = {"knight": "KnightAnim", "monster": "MonsterAnim"}

var type: String
var lvl: String
var selected: bool

func init(_type: String, pos: Vector2) -> void:
	self.frames = load(self.FRAMES_PATH)
	self.type = _type
	self.lvl = self.NORMAL
	self.selected = false
	self.animation = self.ANIMATIONS[_type]
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
	self.lvl = self.NORMAL
	self.selected = false
	self.modulate = self.COLORS[self.NORMAL]

func move(pos: Vector2) -> void:
	self.global_position = pos

func is_king() -> bool:
	return self.type == self.KING

func promote() -> void:
	self.lvl = self.KING
	self.modulate = self.COLORS[self.KING]

func is_selected() -> bool:
	return self.selected

func select() -> void:
	self.selected = !self.selected
	if self.selected:
		self.modulate = self.COLORS[self.SELECTED]
	else:
		self.modulate = self.COLORS[self.lvl]
