extends Node2D

export var m_iHP: int = 5
onready var m_nHPBar: HPBar = get_tree().get_nodes_in_group("UI")[0].get_node("MyShip/HP/HPBar")

func _ready():
	m_nHPBar.set_initial_hp(m_iHP)
