extends ProgressBar

@onready var milestone : MilestonesFood = HandlerGrowth.ref.food_milestone
@export var label : Label

func _ready() -> void:
	connect_signals()

func connect_signals() -> void:
	milestone.progressed.connect(_on_milestone_change)
	milestone.new_milestone_created.connect(_on_milestone_change)

func _update_progress() -> void:
	max_value = milestone.food_goal
	value = milestone.food_progress
	
	label.text = "%s / %s" %[milestone.food_progress, milestone.food_goal]
	
func  _on_milestone_change() -> void:
	_update_progress()
