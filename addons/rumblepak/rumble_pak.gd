extends Node


var bus_strength: Dictionary[StringName, float] = {&"master": 1.0}
var rumble_buses: Array[RumbleData] = []


func _physics_process(delta: float) -> void:
	var total_rumble := Vector2.ZERO
	
	for i in range(rumble_buses.size() - 1, -1, -1):
		var rumble_bus := rumble_buses[i]
		var preset := rumble_bus.preset
		var time_elapsed := rumble_bus.time_elapsed

		# Remove bus if not valid or finished.
		if not is_instance_valid(rumble_bus.preset) or time_elapsed > preset.duration:
			rumble_buses.remove_at(i)
			continue

		var curve_offset := Vector2()
		curve_offset.x = preset.weak_curve.max_domain * (time_elapsed / preset.duration)
		curve_offset.y = preset.strong_curve.max_domain * (time_elapsed / preset.duration)

		var rumble := Vector2()
		rumble.x = preset.weak_curve.sample_baked(curve_offset.x)
		rumble.y = preset.strong_curve.sample_baked(curve_offset.y)

		# Apply bus strength.
		var strength := bus_strength[preset.bus]
		
		if is_instance_valid(strength):
			rumble *= strength

		rumble *= bus_strength[&"master"]
		total_rumble = (total_rumble + rumble).clamp(Vector2.ZERO, Vector2.ONE)
		rumble_bus.time_elapsed += delta

	# Apply rumble to controller.
	Input.start_joy_vibration(0, total_rumble.x, total_rumble.y)


## Adds controller rumble based on the parameters described by [param rumble_preset].
func add_rumble(rumble_preset: RumblePreset) -> void:
	var rumble_data := RumbleData.new()
	rumble_data.preset = rumble_preset

	rumble_buses.append(rumble_data)


## Sets the maximum output of a specific rumble bus.
## [br][br]
## [b]Note:[/b] setting the strength of the [code]"master"[/code] bus will affect all other buses.
func set_bus_strength(strength: float, bus: StringName = &"master") -> void:
	bus_strength[bus] = clamp(strength, 0.0, 1.0)


class RumbleData:
	var preset: RumblePreset = null
	var time_elapsed: float = 0.0