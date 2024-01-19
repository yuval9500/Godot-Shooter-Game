extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

var default_zoom = Vector2(0.4, 0.4)
var house_zoom = Vector2(0.6, 0.6)

func _ready():
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("open", _on_conainer_opened)

func _on_conainer_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)
	

func _on_player_laser_fired(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle())
	laser.direction = direction
	$Projectiles.add_child(laser)


func _on_player_grenade_fired(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
