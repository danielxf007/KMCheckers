extends Control
const TIME_L_TEXT_FORMAT: String = "Time:  %.00f min"
export(Dictionary) var PLAYER_TIME_L_PATHS: Dictionary

var time_labels: Dictionary

func _ready():
	 self.time_labels = {"p_1": self.get_node(self.PLAYER_TIME_L_PATHS["p_1"]),
	"p_2": self.get_node(self.PLAYER_TIME_L_PATHS["p_2"])}

func _on_Game_timers_were_set(clk_time: float) -> void:
	self.time_labels["p_1"].text = self.TIME_L_TEXT_FORMAT%[clk_time]
	self.time_labels["p_2"].text = self.TIME_L_TEXT_FORMAT%[clk_time]
