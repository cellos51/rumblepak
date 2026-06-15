@tool
extends EditorPlugin


const RumbleInspector := preload("res://addons/rumblepak/rumble_inspector.gd")
var rumble_inspector := RumbleInspector.new()

func _enter_tree() -> void:
	add_inspector_plugin(rumble_inspector)
	add_autoload_singleton("RumblePak", "res://addons/rumblepak/rumblepak.gd")


func _exit_tree() -> void:
	remove_inspector_plugin(rumble_inspector)
	remove_autoload_singleton("RumblePak")
