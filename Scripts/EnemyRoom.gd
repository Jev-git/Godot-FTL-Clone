extends Node2D
class_name EnemyRoom

var m_nWeaponButton: Node2D

onready var m_bIsMouseOver: bool = false
onready var m_bIsSelected: bool = false
onready var m_anEnemyRooms = get_tree().get_nodes_in_group("EnemyRoom")
onready var m_nHP = get_tree().get_nodes_in_group("UI")[0].get_node("EnemyShip/HP/HPBar")
signal mouse_click

func _ready():
	m_nWeaponButton = get_tree().get_nodes_in_group("UI")[0].find_node("MyShip").find_node("WeaponButton")
	
	$TextureRect.connect("mouse_entered", self, "on_mouse_entered")
	$TextureRect.connect("mouse_exited", self, "on_mouse_exited")

func on_mouse_entered():
	m_bIsMouseOver = true
	if !m_nWeaponButton.is_selecting_target():
		return
	if m_bIsSelected:
		return
	set_scale(Vector2(1.2, 1.2))

func on_mouse_exited():
	m_bIsMouseOver = false
	if m_bIsSelected:
		return
	if !m_nWeaponButton.is_selecting_target():
		return
	set_scale(Vector2(1, 1))

func _input(event):
	if m_bIsSelected:
		return
	if event is InputEventMouseButton:
		if event.is_pressed() and m_bIsMouseOver:
			for nRoom in m_anEnemyRooms:
				nRoom.toggle_room_select(nRoom.name == name)

func toggle_room_select(_bIsSelected: bool):
	if _bIsSelected:
		m_bIsSelected = true
		set_scale(Vector2(1.2, 1.2))
		emit_signal("mouse_click", self)
	else:
		set_scale(Vector2(1, 1))
		m_bIsSelected = false

func on_hit(_nBulletType: Node2D):
	m_nHP.take_damage(_nBulletType.m_iDamage)
