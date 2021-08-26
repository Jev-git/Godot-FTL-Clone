extends Node2D

export var m_iHP: int = 3
onready var m_nUI = get_tree().get_nodes_in_group("UI")[0]
onready var m_nHPBar: HPBar = m_nUI.get_node("EnemyShip/HP/HPBar")
onready var m_nMap: Popup = m_nUI.get_node("Map")

func _ready():
	restore()
	m_nMap.connect("jump_to_beacon", self, "restore")

func restore():
	m_nHPBar.set_initial_hp(m_iHP)
