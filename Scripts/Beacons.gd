extends Node2D

export var m_psBeacon: PackedScene
export var m_iMinBeaconCount: int = 12
export var m_iMaxBeaconCount: int = 20
export var m_iMaxConnectionFromEachBeacon: int = 2

# For randomize beacon position
export var m_fPadding: float = 20
onready var m_iMarginRight: int = get_parent().margin_right
onready var m_iMargin_left: int = get_parent().margin_left
onready var m_iMargin_bottom: int = get_parent().margin_bottom
onready var m_iMargin_top: int = get_parent().margin_top

onready var m_anBeacons = []
onready var m_aiDistances = []
onready var m_aiConnections = []

onready var m_nRNG: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	m_nRNG.randomize()
	for i in range(m_nRNG.randi_range(m_iMinBeaconCount, m_iMaxBeaconCount)):
		var nBeacon = m_psBeacon.instance()
		nBeacon.debug_set_beacon_name(String(i))
		add_child(nBeacon)
		m_anBeacons.append(nBeacon)
	randomize_beacons_position()
	calculate_distance_between_beacons()
	create_connections_between_beacons()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			get_tree().reload_current_scene()

func randomize_beacons_position():
	for nBeacon in m_anBeacons:
		var vPos = get_random_beacon_position()
		nBeacon.position = vPos
		nBeacon.set_position(vPos)

func get_random_beacon_position() -> Vector2:
	var fX = m_fPadding + randf() * ((m_iMarginRight - m_fPadding) - (m_iMargin_left + m_fPadding))
	var fY = m_fPadding + randf() * ((m_iMargin_bottom - m_fPadding) - (m_iMargin_top + m_fPadding))
	return Vector2(fX, fY)

func calculate_distance_between_beacons():
	for i in range(m_anBeacons.size() - 1):
		var aiDistances = []
		for j in range(i + 1, m_anBeacons.size()):
			aiDistances.append(int(m_anBeacons[i].position.distance_to(m_anBeacons[j].position)))
		m_aiDistances.append(aiDistances)

func create_connections_between_beacons():
	for i in range(m_aiDistances.size()):
		var aiConnections = []
		var iConnectionCount = min(m_aiDistances.size() - i, m_nRNG.randi_range(1, m_iMaxConnectionFromEachBeacon))
		for j in range(iConnectionCount):
			var iIndex = m_aiDistances[i].find(m_aiDistances[i].min())
			m_aiDistances[i][iIndex] = 1000
			aiConnections.append(i + iIndex + 1)
			
			m_anBeacons[i].add_neighbor_beacon(m_anBeacons[i + iIndex + 1])
			m_anBeacons[i + iIndex + 1].add_neighbor_beacon(m_anBeacons[i])
		m_aiConnections.append(aiConnections)
