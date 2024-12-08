extends RigidBody2D

@onready var fish: RigidBody2D = $"."
@onready var sprite: AnimatedSprite2D = $Sprite2D
@export var difficulty: int
@onready var minigame_input: Label = $minigameInput

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fish_types = sprite.sprite_frames.get_animation_names()
	var type = randi() % fish_types.size()
	sprite.play(fish_types[type])
	difficulty = type
	add_to_group("fish")
	minigame_setup()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var coll_info = move_and_collide(fish.linear_velocity * delta)
	if coll_info:
		fish.linear_velocity = fish.linear_velocity.bounce(coll_info.get_normal())


func minigame_setup():
	#Based on the difficulty of the fish, we create an
	# appropriately difficult catch.
	var num_inputs = difficulty*1.5 + 3
	var input_array: Array[int]
	#Set input needs for winning
	for i in num_inputs:
		input_array.append(randi() % 4)
	#Display necessary inputs
	var display_string = ""
	for i in num_inputs:
		match input_array[i]:
			0:
				display_string += "⇦"
			1:
				display_string += "⇨"
			2:
				display_string += "⇧"
			3:
				display_string += "⇩"
	minigame_input.text = display_string
	
func get_difficulty():
	return difficulty
