class_name Upgrade extends Node
## Abstract class defining upgrade.

signal leveled_up

var level := -1
var base_cost := -1
var cost := -1

func title() -> String:
	return "Title not defined."

## Virtual class, must be overwritten.
func description() -> String:
	return "Description not defined"

## Virtual class, must be overwritten.
func calculate_cost() -> void:
	printerr("Calculate_cost method not defined")

## Virtual class, must be overwritten.
func can_afford() -> bool:
	return false

## Virtual class, must be overwritten.
func level_up() -> void:
	printerr("level_up method not defined")

## Virtual class, returns whether or not upgrade has been unlocked.
func is_unlocked() -> bool:
	return false

## Returns if the upgrade has been disabled.
func disabled() -> bool:
	return false
