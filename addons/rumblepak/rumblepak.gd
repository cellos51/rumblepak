@tool
extends Node

var bus_strength: Dictionary[StringName, float] = {}
var rumble_buses: Dictionary[int, Array] = {}

func _ready() -> void:
	bus_strength.clear()
	bus_strength[&"master"] = 1.0

	rumble_buses.clear()


func _physics_process(delta: float) -> void:
	if bus_strength[&"master"] == 0.0:
		Input.start_joy_vibration(0, 0.0, 0.0)
		rumble_buses.clear()

	for device in rumble_buses:
		var rumble_bus := rumble_buses[device]
		var total_rumble := Vector2.ZERO

		for i in range(rumble_bus.size() - 1, -1, -1):
			var rumble_data := rumble_bus[i] as RumbleData
			var preset := rumble_data.preset
			var time_elapsed := rumble_data.time_elapsed

			# Remove bus if not valid or finished.
			if not is_instance_valid(rumble_data.preset) or time_elapsed > preset.duration:
				rumble_bus.remove_at(i)
				continue

			var curve_offset := Vector2()
			curve_offset.x = preset.weak_curve.max_domain * (time_elapsed / preset.duration)
			curve_offset.y = preset.strong_curve.max_domain * (time_elapsed / preset.duration)

			var rumble := Vector2()
			rumble.x = preset.weak_curve.sample_baked(curve_offset.x)
			rumble.y = preset.strong_curve.sample_baked(curve_offset.y)

			# Apply bus strength.
			rumble *= preset.intensity
			rumble *= bus_strength.get(preset.bus, 1.0)
			rumble *= bus_strength[&"master"]

			total_rumble = (total_rumble + rumble).clamp(Vector2.ZERO, Vector2.ONE)

			rumble_data.time_elapsed += delta

		# Apply rumble to controller.
		Input.start_joy_vibration(device, total_rumble.x, total_rumble.y)


## Adds rumble to the [param controller_index] based on the parameters described by [param rumble_preset].
func add_rumble(rumble_preset: RumblePreset, controller_index: int = 0) -> void:
	var rumble_data := RumbleData.new()
	rumble_data.preset = rumble_preset

	if not rumble_buses.has(controller_index):
		rumble_buses[controller_index] = []

	rumble_buses[controller_index].append(rumble_data)


## Sets the maximum output of a specific rumble bus.
## [br][br]
## [b]Note:[/b] setting the strength of the [code]"master"[/code] bus will affect all other buses.
func set_bus_strength(strength: float, bus: StringName = &"master") -> void:
	bus_strength[bus] = clamp(strength, 0.0, 1.0)


## Stops all rumble events on a specific rumble bus of the [param controller_index].
func stop_rumble_bus(bus: StringName, controller_index: int = 0) -> void:
	var rumble_bus := rumble_buses[controller_index]

	for i in range(rumble_bus.size() - 1, -1, -1):
		if rumble_bus[i].preset.bus == bus:
			rumble_bus.remove_at(i)


## Stops all rumble events across all rumble buses and controllers.
func stop_all_rumble() -> void:
	rumble_buses.clear()


class RumbleData:
	var preset: RumblePreset = null
	var time_elapsed: float = 0.0
