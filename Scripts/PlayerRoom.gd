extends Node2D

onready var m_nHP: Node2D = get_tree().get_nodes_in_group("UI")[0].get_node("MyShip/HP/HPBar")

func on_hit(_nBulletType: Node2D):
	m_nHP.take_damage(_nBulletType.m_iDamage)
