# This is an awful idea
extends Node

var frames = 4 # number of frames in anim
var frame = 0 # current frame in anim
var tick = 1.0 # in Seconds
var since_last_tick = 0.0

var frame_0: Image = Image.load_from_file("res://Textures/UI/Coin_0")
var frame_1: Image = Image.load_from_file("res://Textures/UI/Coin_1")
var frame_2: Image = Image.load_from_file("res://Textures/UI/Coin_2")

@onready var texture: TextureRect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	since_last_tick += delta
	if (since_last_tick >= tick):
		frame += 1
		if (frame >= frames):
			frame = 0
			texture.texture.set("texture", frame_0)
		else:
			if (frame == 1 || frame == 3):
				texture.texture.set("texture", frame_1)
			else:
				texture.texture.set("texture", frame_2)
