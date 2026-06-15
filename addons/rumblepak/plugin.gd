@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("RumblePak", "res://addons/rumblepak/rumble_pak.gd")


func _exit_tree() -> void:
	remove_autoload_singleton("RumblePak")
