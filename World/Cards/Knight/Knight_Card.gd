extends Node2D


var hp_point = 5

func get_hp_point():
	return hp_point

func remove_hp(var x:int):
	hp_point-x

func _ready():
	pass
