extends Node2D

# Referenz zur Plattform-Szene
var platforms = [
	preload("res://scenes/platforms/p3_stone.tscn"),
	preload("res://scenes/platforms/p3_grass.tscn"),
	preload("res://scenes/platforms/p3_dirt.tscn"),
	preload("res://scenes/platforms/p3_castle.tscn")
]

# Minimaler und maximaler y-Abstand zur nächsten Plattform
var MIN_Y = -15.0
var MAX_Y = -30.0
# X-Bereich für zufällige Platzierung
var MIN_X = -150
var MAX_X = 150

var p_location = Vector2()
var platform

func _spawn_platform():
	
	p_location.x = randf_range(MIN_X,MAX_X)
	p_location.y = randf_range(MIN_Y,MAX_Y)

	if p_location.y < 0 and p_location.y > -1300:
		platform = platforms[2].instantiate()
	elif p_location.y < -1300 and p_location.y > -2600:
		platform = platforms[1].instantiate()
	elif p_location.y < -2600 and p_location.y > -3900:
		platform = platforms[0].instantiate()
	elif p_location.y < -3900:
		platform = platforms[3].instantiate()

	platform.position = p_location
	add_child.call_deferred(platform)
	MIN_Y -= 24.9
	MAX_Y -= 25.1

func _ready() -> void:
	for start in platforms:
		_spawn_platform()
		_spawn_platform()
		_spawn_platform()

func _process(_delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		for start in platforms:
			_spawn_platform()
		
