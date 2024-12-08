extends CharacterBody2D

const SPEED = 200.0

var isCrouch = false

var gold = 10

var baseMaxSpoons
var maxSpoons = 6		# Spoons will be doubled to handle the partially broken state
var spoons = 1			# Player starts with 1 broken spoon

# Mood Variables
var houseKeepingBonus = 3
var houseCleaned = false

var averageFoodQuality = 1.0
var eatenToday = false

var exerciseBonus = 4
var hasExercised = false

var passoutPenalty = -2
var playerPassedOut = false

var medicationBonus = 3
var hasMedicated = false

# Components
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurt_box_coll: CollisionShape2D = $HurtBox/CollisionShape2D

# UI Elements
@onready var gold_text: Label = get_node("GUI/Background/Gold")
@onready var spoon_back: BoxContainer = get_node("GUI/Background/Spoons")
@onready var spoon_fore: BoxContainer = get_node("GUI/Background/Spoons/CurrSpoons")

# Textures
@onready var spoon_tex_empty: Image = Image.load_from_file("res://Textures/UI/Spoon_Empty.png")
@onready var spoon_tex_broken: Image = Image.load_from_file("res://Textures/UI/Spoon_Broken.png")
@onready var spoon_tex_full: Image = Image.load_from_file("res://Textures/UI/Spoon.png")


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("action"):
		if isCrouch: return
		isCrouch = true
		hurt_box_coll.disabled = false
		sprite.play("crouch")
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left","right","up","down")
	if isCrouch:
		direction = Vector2(0,0)
	velocity = direction * SPEED
	
	if direction.x > 0 && !isCrouch:
		sprite.play("sidewalk")
		sprite.flip_h = false
	elif direction.x < 0 && !isCrouch:
		sprite.play("sidewalk")
		sprite.flip_h = true
	elif direction.y < 0 && !isCrouch:
		sprite.play("upwalk")
	elif direction.y > 0 && !isCrouch:
		sprite.play("downwalk")
	elif !isCrouch:
		sprite.play("idle")
	
	if isCrouch:
		direction = Vector2(0,0)
	

	move_and_slide()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "crouch":
		isCrouch = false
		hurt_box_coll.disabled = true

#func _input(event):
#	if event.is_action_pressed("action"):
#		sprite.play("crouch")

func Sleep() -> void:
	maxSpoons = baseMaxSpoons
	if (houseCleaned):
		maxSpoons += houseKeepingBonus
	if (hasExercised):
		maxSpoons += exerciseBonus
	if (playerPassedOut):
		maxSpoons += passoutPenalty
	
		
	if (eatenToday):
		maxSpoons += floor(averageFoodQuality)
	else:
		maxSpoons = floor(maxSpoons / 2)
		
	if (maxSpoons >= 10): # Trigger End Game
		print_debug("Congrations, Ya Done It!")
		
	elif (maxSpoons <= 0): # The Player Doesn't Wake Up at All
		Die()
		
	else: 		# Start Next Day
		spoons = maxSpoons
		
func Die() -> void:
	print_debug("Oops, you died")
	
func UpdateGold(delta) -> void:
	gold += delta
	gold_text.text = str(gold)
	
func UpdateSpoons(delta) -> void:
	spoons += delta
	var visibleSpoons = ceil(maxSpoons / 2)
	var temp = CanvasTexture.new()
	
	# Add Blank Spoons for Background
	temp.texture = spoon_tex_empty
	for i in visibleSpoons:
		spoon_back.add_child(temp)
	
	# Add Guaranteed Full Spoons
	temp.texture = spoon_tex_full
	for i in (spoons / 2) - 1:
		spoon_fore.add_child(temp)
	
	# Check Final Spoon Slot
	if (!spoons % 2 == 0):
		temp.texture = spoon_tex_broken
	spoon_fore.add_child(temp)
