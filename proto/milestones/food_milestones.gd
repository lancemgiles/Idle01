class_name MilestonesFood extends Node
## Generates growth given some amount X food gathered.

## amount of food required to create growth.
var food_goal := -1
## amount of food gathered in the previous milestone.
var food_progress := -1

var universe : DataUniverse

signal progressed

signal new_milestone_created


func _init() -> void:
	universe = Main.ref.data.universe
	HandlerFood.ref.food_gathered.connect(_on_food_created)
	initialize_new_milestone(universe.food_milestone_progress)

## Change the growth formula to something more interesting and less predictable
func initialize_new_milestone(transferred_progress : int = 0) -> void:
	if universe.growth == 0:
		food_goal = 4
	else:
		food_goal = universe.growth * 8
	food_progress = transferred_progress
	universe.food_milestone_progress = food_progress
	new_milestone_created.emit()
	
func check_for_completion() -> void:
	if food_progress < food_goal:
		return
	else:
		var food_excess = food_progress - food_goal
		HandlerGrowth.ref.create_growth(1)
		initialize_new_milestone(food_excess)
		
		if food_excess > 0:
			check_for_completion()
	

func _on_food_created(quantity: int) -> void:
	food_progress += quantity
	universe.food_milestone_progress = food_progress
	progressed.emit()
	
	check_for_completion()
	

	
