@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("RumblePak", "res://addons/rumble_pak/rumble_pak.gd")


func _exit_tree() -> void:
	remove_autoload_singleton("RumblePak")
