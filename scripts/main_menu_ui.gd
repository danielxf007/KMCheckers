extends Control
signal play_was_pressed()

func _on_PlayButtonMainMenu_button_down() -> void:
	self.emit_signal("play_was_pressed")
