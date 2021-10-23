extends Node2D

enum {KNIGHT, MONSTER, EMPTY = -1}
const PLAYER_1_PIECES_INIT_POS: Vector2 = Vector2(32, 32)
const PLAYER_2_PIECES_INIT_POS: Vector2 = Vector2(32, 416)
const CELL_DIMENSIONS: Vector2 = Vector2(64, 64)
const BOARD_DIMENSIONS: Vector2 = Vector2(8, 8)
var piece_id: int
var pieces_node: Node
var game_board: Array
var game_board_states: Array

func _ready():
	self.pieces_node = $Pieces
	self.piece_id = 0
	self.init_game_board()
	self.place_piece(3, 0, 1, self.PLAYER_1_PIECES_INIT_POS)
	self.place_piece(3, 5, 0, self.PLAYER_2_PIECES_INIT_POS)

func init_game_board() -> void:
	var row: Array
	for _i in range(int(self.BOARD_DIMENSIONS.y)):
		row = []
		for _j in range(int(self.BOARD_DIMENSIONS.x)):
			row.append(null)
		self.game_board.append(row)

func place_piece(n_rows: int, row_offset: int, init_col_pos: int, init_pos: Vector2) -> void:
	var piece: Piece
	var pos: Vector2 = Vector2()
	var col_pos: int = init_col_pos
	for i in range(n_rows):
		for j in range(col_pos, int(self.BOARD_DIMENSIONS.x), 2):
			piece = Piece.new()
			self.pieces_node.add_child(piece)
			pos.x = self.CELL_DIMENSIONS.x*j + init_pos.x
			pos.y = self.CELL_DIMENSIONS.y*(i+row_offset) + init_pos.y
			piece.init(self.piece_id, pos)
			self.game_board[i+row_offset][j] = piece
			self.piece_id+=1
		col_pos = (col_pos+1)%2
