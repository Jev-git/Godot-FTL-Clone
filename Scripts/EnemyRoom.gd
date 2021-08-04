extends Node2D

var m_nWeaponButton

onready var m_bIsMouseOver: bool = false
onready var m_bIsSelected: bool = false
signal mouse_click

func _ready():
	m_nWeaponButton = $"../../UI/WeaponButton"
	
	$TextureRect.connect("mouse_entered", self, "on_mouse_entered")
	$TextureRect.connect("mouse_exited", self, "on_mouse_exited")

func on_mouse_entered():
	m_bIsMouseOver = true
	if !m_nWeaponButton.is_selecting_target():
		return
	if m_bIsSelected:
		return
	self.set_scale(Vector2(1.2, 1.2))

func on_mouse_exited():
	m_bIsMouseOver = false
	if m_bIsSelected:
		return
	if !m_nWeaponButton.is_selecting_target():
		return
	self.set_scale(Vector2(1, 1))

func _input(event):
	if self.m_bIsSelected:
		return
	if event is InputEventMouseButton:
		if event.is_pressed() and m_bIsMouseOver:
			for nRoom in get_parent().get_children():
				nRoom.toggle_room_select(nRoom.name == self.name)

func toggle_room_select(_bIsSelected: bool):
	if _bIsSelected:
		self.m_bIsSelected = true
		self.set_scale(Vector2(1.2, 1.2))
		self.rotate(deg2rad(45))
		self.emit_signal("mouse_click", self)
	else:
		if self.m_bIsSelected:
			self.rotate(deg2rad(-45))
		self.set_scale(Vector2(1, 1))
		self.m_bIsSelected = false
