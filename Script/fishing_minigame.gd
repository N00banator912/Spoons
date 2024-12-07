extends Node2D

@export var fish_scene: PackedScene
var score
const MAXFISH = 5 

signal miniGame

@onready var catch_timer: Timer = $Timers/CatchTimer
@onready var fish_timer: Timer = $Timers/FishTimer
@onready var fish_spawn_loc: PathFollow2D = $FishPath/FishSpawnLoc
@onready var start_pos: Marker2D = $StartPos
@onready var player: CharacterBody2D = $"Player - Fish"
@onready var start_timer: Timer = $Timers/StartTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	player.start(start_pos.position)
	start_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player__fish_hit() -> void:
	#wvar diff = fish_scene.get_difficulty()
	catch_timer.start()
	#get_tree().paused = true
	

func _on_catch_timer_timeout() -> void:
	pass

func _on_fish_timer_timeout() -> void:
	#Every time the fish timer times out, we spawn a fish.
	if get_tree().get_nodes_in_group("fish").size() < MAXFISH:
		var fish = fish_scene.instantiate()
	
		#Choose the location on the Path
		fish_spawn_loc.progress_ratio = randf()
	
		#Make it face toward the center
		var direction = fish_spawn_loc.rotation + PI / 2
		direction += randf_range(-PI / 4, PI / 4)
		fish.rotation = direction
		fish.position = fish_spawn_loc.position
		
		var velocity = Vector2(randf_range(20, 50), 0)
		fish.linear_velocity = velocity.rotated(direction)
		
		add_child(fish)
	else:
		return



func _on_start_timer_timeout() -> void:
	fish_timer.start()
