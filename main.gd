class_name Main extends Node
## Main node for the game

## Singelton Reference
static var ref : Main
## Save and load data
var data : Data

## Singleton check
func _singleton_check() -> void:
	if not ref:
		ref = self
	else: queue_free()
	
@export var scene_ui : PackedScene
	
## Singleton check and data initialization.
func _enter_tree() -> void:
	_singleton_check()
	data = Data.new()
	SaveSystem.load_data()

func _ready() -> void:
	var node_ui : UI = scene_ui.instantiate() as UI
	add_child(node_ui)

func _on_save_timer_timeout() -> void:
	SaveSystem.save_data()
