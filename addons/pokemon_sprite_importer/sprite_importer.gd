tool
extends EditorPlugin

const ImportDialog = preload("res://addons/pokemon_sprite_importer/ImportDlg.tscn")

var import_dialog_instance

func _enter_tree():
	import_dialog_instance = ImportDialog.instance()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR, import_dialog_instance)

func _exit_tree():
	if import_dialog_instance:
		remove_control_from_docks(import_dialog_instance)
		import_dialog_instance.queue_free()
