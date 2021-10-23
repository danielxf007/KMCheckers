extends Node2D
signal timers_were_set(clk_time)
enum {KNIGHT, MONSTER, KING_KNIGHT, KING_MONSTER, EMPTY=-1}
const PLAYER_1_PIECES_INIT_POS: Vector2 = Vector2(32, 32)
const PLAYER_2_PIECES_INIT_POS: Vector2 = Vector2(32, 352)
const CELL_DIMENSIONS: Vector2 = Vector2(64, 64)
const BOARD_DIMENSIONS: Vector2 = Vector2(8, 8)
var timers: Dictionary
var piece_id: int
var pieces_node: Node
var game_board: Array
var game_board_states: Array

func _ready():
	self.timers = {"p_1": $Player1Timer, "p_2": $Player2Timer}
	self.pieces_node = $Pieces
	self.piece_id = 0
	self.init_game_board()
	self.place_piece(3, 0, 1, self.PLAYER_1_PIECES_INIT_POS)
	self.place_piece(3, 5, 0, self.PLAYER_2_PIECES_INIT_POS)
	randomize()

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
			pos.y = self.CELL_DIMENSIONS.y*i + init_pos.y
			piece.init(self.piece_id, pos)
			self.game_board[i+row_offset][j] = piece
			self.piece_id+=1
		col_pos = (col_pos+1)%2

func set_game_pices(type: int, n_rows: int, row_offset: int, init_col_pos: int) -> void:
	var col_pos: int = init_col_pos
	for i in range(n_rows):
		for j in range(col_pos, int(self.BOARD_DIMENSIONS.x), 2):
			self.game_board[i+row_offset][j].set_type(type)
			self.game_board[i+row_offset][j].activate()
		col_pos = (col_pos+1)%2

func _on_GameSetUpUI_game_started(game_setup_data: Dictionary) -> void:
	var player_1_piece_type: int = randi()%2
	self.set_game_pices(player_1_piece_type, 3, 0, 1)
	var player_2_piece_type: int = (player_1_piece_type+1)%2
	self.set_game_pices(player_2_piece_type, 3, 5, 0)
	if game_setup_data["use_clk"]:
		self.timers["p_1"].wait_time = game_setup_data["clk_time"]
		self.timers["p_2"].wait_time = game_setup_data["clk_time"]
		self.emit_signal("timers_were_set", game_setup_data["clk_time"])
	self.show()
