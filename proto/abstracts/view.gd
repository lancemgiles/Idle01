class_name View extends Control
## Abstract class defining a view.

@export var view : UI.Views
@export var ui : UI

func _ready() -> void:
	ui.navigation_requested.connect(_on_navigation_request)
	

func _on_navigation_request(requested_view: UI.Views) -> void:
	if requested_view == view:
		visible = true
	else:
		visible = false
