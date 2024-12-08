extends CharacterBody2D

@onready var hitbox: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var yourself: CollisionShape2D = $CollisionShape2D

const SPEED = 200.0

var screen_size

signal hit

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left","right","up","down")

	velocity = direction * SPEED


	move_and_slide()

func _ready():
	screen_size = get_viewport_rect().size
	#hide()

func _on_hitbox_body_entered(body: Node2D) -> void:
	print(str(body))
	if body != yourself || body != hitbox:
		hit.emit()
		#hitbox.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	hitbox.disabled = false
