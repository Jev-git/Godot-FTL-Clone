extends Popup

export var m_psBeacon: PackedScene
# Beacons informations
onready var m_anBeacons = $Beacons.get_children()
onready var m_aiConnections = $Beacons.m_aiConnections
# Highlight neighbors
onready var m_iHighlightBeaconIndex: int
onready var m_bIsHighlightingNeighbors: bool = false

onready var m_nMyShip: Node2D = $MyShip
# Important beacons
onready var m_iMyShipCurrentBeaconIndex: int
onready var m_iExitBeaconIndex: int

signal jump_to_beacon

func _ready():
	set_exclusive(true)
	connect("about_to_show", self, "about_to_show")
	connect("popup_hide", self, "popup_hide")
	$CloseButton.connect("pressed", self, "close_popup")
	for i in range(m_anBeacons.size()):
		var nTexture = m_anBeacons[i].get_node("TextureRect")
		nTexture.connect("mouse_entered", self, "highlight_beacon", [i, true])
		nTexture.connect("mouse_exited", self, "highlight_beacon", [i, false])
		m_anBeacons[i].connect("pressed", self, "jump_to_beacon", [i])
		
		# Important beacons
		if m_anBeacons[i].position.x < m_anBeacons[m_iMyShipCurrentBeaconIndex].position.x:
			m_iMyShipCurrentBeaconIndex = i
		if m_anBeacons[i].position.x > m_anBeacons[m_iExitBeaconIndex].position.x:
			m_iExitBeaconIndex = i
	
	m_nMyShip.position = m_anBeacons[m_iMyShipCurrentBeaconIndex].position
	m_anBeacons[m_iExitBeaconIndex].set_text("EXIT")

func _process(delta):
	m_nMyShip.rotate(0.5 * delta)

func _draw():
	for i in range(m_aiConnections.size()):
		var vStartPos: Vector2 = m_anBeacons[i].position
		for j in range(m_aiConnections[i].size()):
			var vEndPos: Vector2 = m_anBeacons[m_aiConnections[i][j]].position
			draw_line(vStartPos, vEndPos, Color.blue)
			
	if m_bIsHighlightingNeighbors:
		for nNeighbor in m_anBeacons[m_iHighlightBeaconIndex].m_anNeighborBeacons:
			if nNeighbor.m_iIndex == m_iMyShipCurrentBeaconIndex:
				draw_line(m_anBeacons[m_iHighlightBeaconIndex].position, nNeighbor.position, Color.purple, 2)
			else:
				draw_line(m_anBeacons[m_iHighlightBeaconIndex].position, nNeighbor.position, Color.red, 2)

func highlight_beacon(_iIndex: int, _bIsHighlighting: bool):
	m_iHighlightBeaconIndex = _iIndex
	m_bIsHighlightingNeighbors = _bIsHighlighting
	update()

func jump_to_beacon(_iIndex: int):
	if !m_anBeacons[_iIndex].is_neighbor_of_beacon(m_iMyShipCurrentBeaconIndex):
		return
	m_iMyShipCurrentBeaconIndex = _iIndex
	m_nMyShip.position = m_anBeacons[_iIndex].position
	emit_signal("jump_to_beacon")
	hide()

func about_to_show():
	get_tree().paused = true

func popup_hide():
	get_tree().paused = false
	update()
