class_name UI extends Control
## Main class controlling user interface

enum Views {
	PROTO_CLICKER,
	PROTO_GENERATOR,
	PROTO_UPGRADES,
	UNIVERSE,
	PROTO_GROW
}

signal navigation_requested(view: Views)

func _ready() -> void:
	navigation_requested.emit(Views.UNIVERSE)


func _on_proto_gen_link_pressed() -> void:
	navigation_requested.emit(Views.PROTO_GENERATOR)

func _on_proto_click_link_pressed() -> void:
	navigation_requested.emit(Views.PROTO_CLICKER)

func _on_proto_upgrades_pressed() -> void:
	navigation_requested.emit(Views.PROTO_UPGRADES)

func _on_proto_grow_pressed() -> void:
	navigation_requested.emit(Views.PROTO_GROW)

func _on_universe_link_pressed() -> void:
	navigation_requested.emit(Views.UNIVERSE)
