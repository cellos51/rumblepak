@tool
@icon("res://addons/rumblepak/icons/controller.svg")
class_name RumblePreset
extends Resource

@export_group("Testing")
@export_tool_button("Test Rumble", "Noise") var test_action := _test
## The contoller index to use when testing rumble in the editor.
@export var controller_index: int = 0
@export_group("Properties")
## The rumble bus to use when applying controller rumble.
@export var bus: StringName = &"master"
## The intensity of rumble for the preset to be limited to.
@export_range(0.0, 1.0) var intensity: float = 1.0
## The amount of time in seconds for the preset to last.
@export var duration: float = 1.0
## The curve to be used for the weak motor of the controller.

## The curve to be used for the strong motor of the controller.

@export_group("Weak Rumble Graph")
@export var weak_curve: Curve
@export_group("Strong Rumble Graph")
@export var strong_curve: Curve


func _test() -> void:
	RumblePak.add_rumble(self, controller_index)