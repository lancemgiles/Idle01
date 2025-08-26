class_name SaveSystem
## Save manager

const PATH := "user://save.tres"
## Set this to false to disable saving.
const SHOULD_LOAD := false

## Save Main.ref.data object to a file
static func save_data() -> void:
	ResourceSaver.save(Main.ref.data, PATH)

## Loads data and overwrites Main.ref.data object
static func load_data() -> void:
	if not SHOULD_LOAD: return
	
	if ResourceLoader.exists(PATH):
		Main.ref.data = load(PATH)
