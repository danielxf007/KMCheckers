extends Control
signal game_started(game_setup_data)

const TIME_L_TEXT_FORMAT: String = "Time:  %.0f min"
export(NodePath) var PLAYER_1_ITEM_LIST_PATH: NodePath
export(NodePath) var PLAYER_2_ITEM_LIST_PATH: NodePath
export(NodePath) var TIME_L_PATH: NodePath
var player_1_item_list: ItemList
var player_2_item_list: ItemList
var time_l: Label
var game_setup_data: Dictionary

func _ready():
	self.player_1_item_list = self.get_node(self.PLAYER_1_ITEM_LIST_PATH)
	self.player_2_item_list = self.get_node(self.PLAYER_2_ITEM_LIST_PATH)
	self.time_l = self.get_node(self.TIME_L_PATH)
	self.game_setup_data = {"p_1": "", "p_2": "", "use_clk": false,
	"clk_time": 1.0}

func _on_Player1List_item_selected(index: int) -> void:
	self.game_setup_data["p_1"] = self.player_1_item_list.get_item_text(index)

func _on_Player2List_item_selected(index: int) -> void:
	self.game_setup_data["p_2"] = self.player_2_item_list.get_item_text(index)

func _on_UseClockCheckBox_button_down() -> void:
	if self.game_setup_data["use_clk"]:
		self.game_setup_data["use_clk"] = false
	else:
		self.game_setup_data["use_clk"] = true

func _on_TimeSlider_value_changed(value: float) -> void:
	self.time_l.text = self.TIME_L_TEXT_FORMAT%[value]
	self.game_setup_data["clk_time"] = value

func _on_StartGame_button_down() -> void:
	self.emit_signal("game_started", self.game_setup_data)






