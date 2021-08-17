extends Popup

export var m_psBeacon: PackedScene
onready var m_anBeacons = $Beacons.get_children()
onready var m_aiConnections = $Beacons.m_aiConnections

func _ready():
	popup_centered()

func _draw():
	for i in range(m_aiConnections.size()):
		var vStartPos: Vector2 = m_anBeacons[i].position
		for j in range(m_aiConnections[i].size()):
			var vEndPos: Vector2 = m_anBeacons[m_aiConnections[i][j]].position
			draw_line(vStartPos, vEndPos, Color.blue)
