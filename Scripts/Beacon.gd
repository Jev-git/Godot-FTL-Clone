extends Node2D

onready var m_anNeighborBeacons = []
onready var m_bIsMouseOver: bool = false
onready var m_iIndex: int

signal pressed

func _ready():
	$TextureRect.connect("mouse_entered", self, "on_mouse_entered")
	$TextureRect.connect("mouse_exited", self, "on_mouse_exited")

func _input(event):
	if event is InputEventMouse:
		if event.is_pressed() and m_bIsMouseOver:
			emit_signal("pressed")

func on_mouse_entered():
	m_bIsMouseOver = true

func on_mouse_exited():
	m_bIsMouseOver = false

func set_index(_iIndex: int):
	m_iIndex = _iIndex
	$RichTextLabel.text = String(_iIndex)

func add_neighbor_beacon(_nNeighbor: Node2D):
	m_anNeighborBeacons.append(_nNeighbor)

func get_neighbor_count() -> int:
	return m_anNeighborBeacons.size();

func is_neighbor_of_beacon(_iIndex: int) -> bool:
	for nNeighbor in m_anNeighborBeacons:
		if nNeighbor.m_iIndex == _iIndex:
			return true
	return false
