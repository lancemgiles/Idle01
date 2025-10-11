class_name UI extends Control
## Main class controlling user interface

enum Views {
	UNIVERSE,
	GROWTH,
	DRINKS
}

signal navigation_requested(view: Views)

func _ready() -> void:
	navigation_requested.emit(Views.UNIVERSE)


func _on_proto_grow_pressed() -> void:
	navigation_requested.emit(Views.GROWTH)

func _on_universe_link_pressed() -> void:
	navigation_requested.emit(Views.UNIVERSE)


func _on_drinks_link_pressed() -> void:
	navigation_requested.emit(Views.DRINKS)
