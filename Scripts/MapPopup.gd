extends Popup

export var m_psBeacon: PackedScene
onready var m_anBeacons = $Beacons.get_children()
onready var m_aiConnections = $Beacons.m_aiConnections
onready var m_iHighlightBeaconIndex: int
onready var m_bIsHighlightingNeighbors: bool = false

func _ready():
	popup_centered()
	
	for i in range(m_anBeacons.size()):
		var nTexture = m_anBeacons[i].get_node("TextureRect")
		nTexture.connect("mouse_entered", self, "highlight_beacon", [i, true])
		nTexture.connect("mouse_exited", self, "highlight_beacon", [i, false])

func _draw():
	for i in range(m_aiConnections.size()):
		var vStartPos: Vector2 = m_anBeacons[i].position
		for j in range(m_aiConnections[i].size()):
			var vEndPos: Vector2 = m_anBeacons[m_aiConnections[i][j]].position
			draw_line(vStartPos, vEndPos, Color.blue)
			
	if m_bIsHighlightingNeighbors:
		for nNeighbor in m_anBeacons[m_iHighlightBeaconIndex].m_anNeighborBeacons:
			draw_line(m_anBeacons[m_iHighlightBeaconIndex].position, nNeighbor.position, Color.red, 2)

func highlight_beacon(_iIndex: int, _bIsHighlighting: bool):
	m_iHighlightBeaconIndex = _iIndex
	m_bIsHighlightingNeighbors = _bIsHighlighting
	update()
