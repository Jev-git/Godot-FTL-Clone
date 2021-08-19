extends Node2D

onready var m_anNeighborBeacons = []

func set_index(iIndex: int):
	$RichTextLabel.text = String(iIndex)

func add_neighbor_beacon(nNeighbor: Node2D):
	m_anNeighborBeacons.append(nNeighbor)

func get_neighbor_count() -> int:
	return m_anNeighborBeacons.size();
