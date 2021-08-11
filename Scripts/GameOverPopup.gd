extends Node2D

onready var m_nPlayerHP = get_tree().get_nodes_in_group("UI")[0].get_node("MyShip/HP/HPBar")
onready var m_nEnemyHP = get_tree().get_nodes_in_group("UI")[0].get_node("EnemyShip/HP/HPBar")
onready var m_nPopup: ConfirmationDialog = $ConfirmationDialog

func _ready():
	m_nPlayerHP.connect("ship_exploded", self, "player_lose")
	m_nEnemyHP.connect("ship_exploded", self, "player_win")
	m_nPopup.connect("confirmed", self, "reload_level")
	m_nPopup.get_cancel().connect("pressed", self, "quit")

func player_win():
	get_tree().paused = true
	m_nPopup.window_title = "You win! :D"
	m_nPopup.popup_centered()

func player_lose():
	get_tree().paused = true
	m_nPopup.window_title = "You lose ;;"
	m_nPopup.popup_centered()

func reload_level():
	get_tree().paused = false
	get_tree().reload_current_scene()

func quit():
	get_tree().quit()
