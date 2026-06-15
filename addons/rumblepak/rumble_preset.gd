@icon("res://addons/rumblepak/icons/controller.svg")
class_name RumblePreset
extends Resource

## The rumble bus to use when applying controller rumble.
@export var bus: StringName = &"master"
## The intensity of rumble for the preset to be limited to.
@export_range(0.0, 1.0) var intensity: float = 1.0
## The amount of time in seconds for the preset to last.
@export var duration: float = 1.0
## The curve to be used for the weak motor of the controller.
@export var weak_curve: Curve
## The curve to be used for the strong motor of the controller.
@export var strong_curve: Curve
