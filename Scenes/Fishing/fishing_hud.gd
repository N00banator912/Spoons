extends CanvasLayer
@onready var score_label: Label = $ScoreLabel
@onready var message: Label = $Message

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_score(score):
	score_label.text = str(score)

func _on_message_timer_timeout() -> void:
	message.hide()
