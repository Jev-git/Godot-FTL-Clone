extends Node2D

onready var m_anNeighborBeacons = []
onready var m_bIsDrawingNeighbors = false
var m_vPosition: Vector2

func _ready():
	$TextureRect.connect("mouse_entered", self, "on_mouse_entered")
	$TextureRect.connect("mouse_exited", self, "on_mouse_exited")

func on_mouse_entered():
	m_bIsDrawingNeighbors = true
	update()

func on_mouse_exited():
	m_bIsDrawingNeighbors = false
	update()

func _draw():
	if m_bIsDrawingNeighbors:
		for nNeighbor in m_anNeighborBeacons:
			draw_line(m_vPosition, nNeighbor.m_vPosition, Color.red, 2)

func set_position(vPos: Vector2):
	m_vPosition = vPos

func debug_set_beacon_name(sName: String):
	$RichTextLabel.text = sName

func add_neighbor_beacon(nNeighbor: Node2D):
	m_anNeighborBeacons.append(nNeighbor)

func get_neighbor_count() -> int:
	return m_anNeighborBeacons.size();
