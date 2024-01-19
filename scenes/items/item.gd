extends Area2D

@export var rotation_speed: int = 4
var available_types = ['laser','laser','laser', 'grenade', 'health']
var type = available_types[randi()%len(available_types)]

var direction: Vector2
var distance: int = randi_range(150, 250)

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color(0.2, 0.2, 0.8)
	elif type == 'grenade':
		$Sprite2D.modulate = Color(0.8, 0.2, 0.2)
	elif type == 'health':
		$Sprite2D.modulate = Color(0.2, 0.8, 0.2)
	
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2.ZERO)

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body):
	if type == 'laser':
		Globals.laser_amount += 5
	elif type == 'grenade':
		Globals.grenade_amount += 1
	elif type == 'health':
		Globals.health += 10
	queue_free()
