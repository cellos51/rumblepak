@tool
extends EditorInspectorPlugin

enum CurveType {
	WEAK_CURVE,
	STRONG_CURVE,
}

const RumbleGraph = preload("res://addons/rumblepak/rumble_graph.gd")


func _can_handle(object: Object) -> bool:
	return object is RumblePreset


func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	if object is RumblePreset:
		if name == "weak_curve":
			add_graph(object, CurveType.WEAK_CURVE)
			return true
		elif name == "strong_curve":
			add_graph(object, CurveType.STRONG_CURVE)
			return true

	return false


func add_graph(preset: RumblePreset, curve_type: CurveType) -> void:
	var graph := RumbleGraph.new()

	if curve_type == CurveType.WEAK_CURVE:
		graph.set_curve(preset.weak_curve)
		graph.line_color = Color("3d64dd")
	else:
		graph.set_curve(preset.strong_curve)
		graph.line_color = Color("cd3838")

	add_custom_control(graph)
