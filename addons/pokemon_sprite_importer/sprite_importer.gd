tool
extends EditorPlugin

const ImportDialog = preload("res://addons/pokemon_sprite_importer/ImportDlg.tscn")

var import_dialog_instance

func _enter_tree():
	import_dialog_instance = ImportDialog.instance()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR, import_dialog_instance)
	#get_editor_interface().get_editor_viewport().add_child(import_dialog_instance)
	#make_visible(false)

func _exit_tree():
	if import_dialog_instance:
		remove_control_from_docks(import_dialog_instance)
		import_dialog_instance.queue_free()

#func has_main_screen():
#	return true

#func make_visible(visible):
#	if import_dialog_instance:
#		import_dialog_instance.visible = visible

#func get_plugin_name():
#	return "Sprite Importer"

#func get_plugin_icon():
#	return get_editor_interface().get_base_control().get_icon("Node", "EditorIcons")
