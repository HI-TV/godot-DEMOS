extends Node2D

export(Script) var Game_saver

var save_vars = ["playerpos"]

func _ready():
	var dir = Directory.new()
	if dir.dir_exists("res://saves/"):
		load_world()

func _on_save_pressed():
	save_world()


func save_world():
	var save = Game_saver.new()
	save.playerpos = $player.position
	
	var dir = Directory.new()
	if not dir.dir_exists("res://saves/"):
		dir.make_dir_recursive("res://saves/")
	
	ResourceSaver.save("res://saves/save_01.res", save)

func _on_load_pressed():
	load_world()

func load_world():
	var dir = Directory.new()
	if not dir.file_exists("res://saves/save_01.res"):
		return false
	
	var world_save = load("res://saves/save_01.res")
	if not verify_save(world_save):
		return false
	
	$player.position = world_save.playerpos
	
	return true

func verify_save(world_save):
	for v in save_vars:
		if world_save.get(v) == null:
			return false
	
	return true
