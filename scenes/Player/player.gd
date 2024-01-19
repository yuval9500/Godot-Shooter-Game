extends CharacterBody2D

signal laser_fired(pos, direction)
signal grenade_fired(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int
var speed: int

func _ready():
	speed = max_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	#rotate
	look_at(get_global_mouse_position())
	
	#shooting
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		can_laser = false
		Globals.laser_amount -= 1
		$LaserReloadTimer.start()
		
		var laser_markers = $PlayerImage/LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		laser_fired.emit(selected_laser.global_position, player_direction)
		
		$LaserParticles.restart()
		
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		can_grenade = false
		Globals.grenade_amount -= 1
		$GrenadeReloadTimer.start()
		var grenade_pos = $PlayerImage/LaserStartPositions.get_child(0).global_position
		grenade_fired.emit(grenade_pos, player_direction)

func _on_laser_reload_timer_timeout():
	can_laser = true

func _on_grenade_reload_timer_timeout():
	can_grenade = true
