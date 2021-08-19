extends Node2D

onready var m_anNeighborBeacons = []
onready var m_bIsDrawingNeighbors = false

func on_mouse_entered():
	print("mouse in")
	m_bIsDrawingNeighbors = true
	update()

func on_mouse_exited():
	print("mouse out")
	m_bIsDrawingNeighbors = false
	update()

func _draw():
	if m_bIsDrawingNeighbors:
		for nNeighbor in m_anNeighborBeacons:
			draw_line(position, nNeighbor.position, Color.red, 2)

func set_index(iIndex: int):
	$RichTextLabel.text = String(iIndex)

func add_neighbor_beacon(nNeighbor: Node2D):
	m_anNeighborBeacons.append(nNeighbor)

func get_neighbor_count() -> int:
	return m_anNeighborBeacons.size();
