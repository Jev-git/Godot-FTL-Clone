extends Node2D

enum STATE {DEFAULT, SELECTING_TARGET, TARGET_SELECTED}

export var m_psBullet: PackedScene
export var m_fShootTimeMax: float
onready var m_iState: int = STATE.DEFAULT
onready var m_nProgressBar: ProgressBar = $ProgressBar
onready var m_nWeaponRoom = (get_tree().get_nodes_in_group("MyShip")[0]).find_node("WeaponRoom")
var m_nTargetRoom

func _ready():
	$Button.connect("pressed", self, "on_button_pressed")
	for nEnemyRoom in (get_tree().get_nodes_in_group("EnemyShip")[0]).get_children():
		nEnemyRoom.connect("mouse_click", self, "mouse_click_on_enemy_room")

func _process(delta):
	m_nProgressBar.value += delta * 100 / m_fShootTimeMax
	if m_nProgressBar.value == 100 and m_iState == STATE.TARGET_SELECTED:
		# Instancing Bullet
		var nBullet = m_psBullet.instance()
		get_tree().root.add_child(nBullet)
		nBullet.global_position = m_nWeaponRoom.global_position
		nBullet.set_target_room(m_nTargetRoom)
		
		m_nProgressBar.value = 0

func on_button_pressed():
	if m_iState != STATE.SELECTING_TARGET:
		print("Selecting target")
		m_iState = STATE.SELECTING_TARGET
		if m_nTargetRoom:
			m_nTargetRoom.toggle_room_select(false)
			m_nTargetRoom = null

func mouse_click_on_enemy_room(_nEnemyRoom):
	if m_iState == STATE.SELECTING_TARGET:
		m_nTargetRoom = _nEnemyRoom
		m_iState = STATE.TARGET_SELECTED
		print("Target selected: %s" % _nEnemyRoom.name)

func is_selecting_target() -> bool:
	return m_iState == STATE.SELECTING_TARGET
