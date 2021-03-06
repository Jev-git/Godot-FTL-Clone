extends Node2D

export var m_fRechargeTime: float = 4
export var m_bIsEnemyShield: bool
onready var m_bIsActive: bool = true
onready var m_nSprite: Sprite = $Sprite
onready var m_nProgressBar: ProgressBar

func _ready():
	if m_bIsEnemyShield:
		m_nProgressBar = get_tree().get_nodes_in_group("UI")[0].get_node("EnemyShip/Shield/ProgressBar")
	else:
		m_nProgressBar = get_tree().get_nodes_in_group("UI")[0].get_node("MyShip/Shield/ProgressBar")

func _process(delta):
	m_nProgressBar.value += delta * 100 / m_fRechargeTime
	if m_nProgressBar.value == 100 and !m_bIsActive:
		m_bIsActive = true
		m_nSprite.visible = true

func on_hit(_nBulletType: Node2D):
	m_bIsActive = false
	m_nSprite.visible = false
	m_nProgressBar.value = 0

func is_active():
	return m_bIsActive
