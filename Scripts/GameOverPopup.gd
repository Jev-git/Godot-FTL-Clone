extends Node2D

onready var m_nUI = get_tree().get_nodes_in_group("UI")[0]
onready var m_nPlayerHP = m_nUI.get_node("MyShip/HP/HPBar")
onready var m_nEnemyHP = m_nUI.get_node("EnemyShip/HP/HPBar")
onready var m_nMap: Popup = m_nUI.get_node("Map")
onready var m_nLosePopup: ConfirmationDialog = $LosePopup
onready var m_nWinPopup: AcceptDialog = $WinPopup

func _ready():
	m_nPlayerHP.connect("ship_exploded", self, "player_lose")
	m_nEnemyHP.connect("ship_exploded", self, "player_win")
	m_nWinPopup.connect("confirmed", self, "open_map")
	m_nLosePopup.connect("confirmed", self, "reload_level")
	m_nLosePopup.get_cancel().connect("pressed", self, "quit")

func player_win():
	get_tree().paused = true
	m_nWinPopup.window_title = ""
	m_nWinPopup.popup_centered()

func player_lose():
	get_tree().paused = true
	m_nLosePopup.window_title = "You lose ;;"
	m_nLosePopup.popup_centered()

func reload_level():
	get_tree().paused = false
	get_tree().reload_current_scene()

func quit():
	get_tree().quit()

func open_map():
	m_nMap.popup_centered()
