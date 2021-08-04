extends Node2D

enum STATE {DEFAULT, SELECTING_TARGET, TARGET_SELECTED}

var m_nWeaponRoom
var m_nTargetRoom

export var m_psBullet: PackedScene
export var m_fShootTimeMax: float
onready var m_iState: int = STATE.DEFAULT
onready var m_nProgressBar: ProgressBar = $ProgressBar

func _ready():
	$Button.connect("pressed", self, "on_button_pressed")
	for nEnemyRoom in $"../../EnemyShip".get_children():
		nEnemyRoom.connect("mouse_click", self, "mouse_click_on_enemy_room")

func _process(delta):
	m_nProgressBar.value += delta * 100 / m_fShootTimeMax
	if m_nProgressBar.value == 100:
		# shoot bullet here
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
