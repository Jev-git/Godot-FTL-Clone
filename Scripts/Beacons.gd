extends Node2D

export var m_psBeacon: PackedScene
export var m_iMinBeaconCount: int = 12
export var m_iMaxBeaconCount: int = 20
export var m_iMaxConnectionFromEachBeacon: int = 2

# For randomize beacon position
export var m_fPadding: float = 20
export var m_iMinDistanceBetweenBeacon: int = 50 # Increase this too much and the while loop may never end
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
		nBeacon.set_index(i)
		add_child(nBeacon)
		m_anBeacons.append(nBeacon)
	randomize_beacons_position()
	create_connections_between_beacons()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			get_tree().reload_current_scene()

func randomize_beacons_position():
	for i in range(m_anBeacons.size()):
		if i == 0:
			var vPos: Vector2 = get_random_beacon_position()
			m_anBeacons[i].position = vPos
			m_aiDistances.append([])
		else:
			while true:
				var vPos: Vector2 = get_random_beacon_position()
				var aiDistances = get_distance_to_all_prev_beacons(vPos, i)
				if aiDistances.min() < m_iMinDistanceBetweenBeacon:
					continue
				else:
					m_anBeacons[i].position = vPos
					m_aiDistances.append(aiDistances)
					break

func get_random_beacon_position() -> Vector2:
	var fX = m_fPadding + randf() * ((m_iMarginRight - m_fPadding) - (m_iMargin_left + m_fPadding))
	var fY = m_fPadding + randf() * ((m_iMargin_bottom - m_fPadding) - (m_iMargin_top + m_fPadding))
	return Vector2(fX, fY)

func get_distance_to_all_prev_beacons(vPos: Vector2, iIndex: int):
	var aiDistances = []
	for i in range(iIndex):
		aiDistances.append(int(vPos.distance_to(m_anBeacons[i].position)))
	return aiDistances

func create_connections_between_beacons():
	for i in range(m_aiDistances.size()):
		var aiConnections = []
		var iConnectionCount = min(m_aiDistances[i].size(), m_nRNG.randi_range(1, m_iMaxConnectionFromEachBeacon))
		for j in range(iConnectionCount):
			var iIndex = m_aiDistances[i].find(m_aiDistances[i].min())
			m_aiDistances[i][iIndex] = 1000
			aiConnections.append(iIndex)
			m_anBeacons[i].add_neighbor_beacon(m_anBeacons[iIndex])
			m_anBeacons[iIndex].add_neighbor_beacon(m_anBeacons[i])
		m_aiConnections.append(aiConnections)
