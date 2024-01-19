extends CanvasLayer

#colors
var green: Color = Color("6bbfa3")
var yellow: Color = Color(0.9, 0.9, 0, 1)
var red: Color = Color(0.9, 0, 0, 1)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect

@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect

@onready var health_bar: TextureProgressBar = $HealthBar/TextureProgressBar

func _ready():
	Globals.connect("stat_change", update_stats)
	update_stats()

func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)

func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)
	
func update_color(ammo: int, label: Label, icon: TextureRect) -> void:
	if(ammo > 1):
		label.modulate = green
		icon.modulate = green
	elif(ammo == 1):
		label.modulate = yellow
		icon.modulate = yellow
	else:
		label.modulate = red
		icon.modulate = red

func update_health_value():
	health_bar.value = Globals.health

func update_stats():
	update_laser_text()
	update_grenade_text()
	update_health_value()
