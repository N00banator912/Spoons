# Player
# Main Player Script
# K. E. Brown
# 12/01/2024
# 12/01/2024

extends Node

var MaxSpoons = 3;			# The Maximum number of spoons the player will wake up with on a new day
var Spoons = 1;				# The Player's current number of spoons
var isMedicated = false;	# Has the player taken medicine since the previous day?
var House; 					# The Player's house, will affect how well they sleep and other effects on max spoons

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if (Input.get_axis("")):
	#	pass
	
	pass
	
func Sleep():
	Spoons = MaxSpoons;
	if (!isMedicated):
		MaxSpoons -= 1;
	pass
