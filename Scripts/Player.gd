# Player
# Main Player Script
# K. E. Brown
# 12/01/2024
# 12/01/2024

extends Node

var MaxSpoons = 3;			# The Maximum number of spoons the player will wake up with on a new day
var Spoons = 1;				# The Player's current number of spoons
var isMedicated = false;	# Has the player taken medicine since the previous day?
var hasEaten = false;		# Has the player eaten since the previous day?
var FoodQuality = 1.0;		# Player's average food quality
var House; 					# The Player's house, will affect how well they sleep and other effects on max spoons

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# I was starting to implement controls here
	#if (Input.get_axis("")):
	#	pass
	
	pass
	
func Sleep():	
	# Check if the player has medicated
	if (!isMedicated):
		MaxSpoons -= 1;

	# Check if the player has eaten
	if (!hasEaten):
		MaxSpoons -= 1;
	
	# Check Food Quality
	if (FoodQuality > 1.0):
		MaxSpoons += FoodQuality - 1;
		
	# Check House Quality?
	
	# Does the player have spoons to start the day?
	if (MaxSpoons <= 0):
		GameOver();
	else:	
		Spoons = MaxSpoons;
		
	pass

# The Player is out of spoons and cannae get out of bed
func GameOver():
	pass
	
