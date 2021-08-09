extends EnemyRoom

export var m_psBullet: PackedScene
export var m_fShootTimeMax: float = 5
onready var m_nProgressBar: ProgressBar = get_tree().get_nodes_in_group("UI")[0].get_node("EnemyShip/Weapon/ProgressBar")
onready var m_anPlayerRooms = get_tree().get_nodes_in_group("MyShip")[0].get_children()

func _process(delta):
	m_nProgressBar.value += delta * 100 / m_fShootTimeMax
	if m_nProgressBar.value == 100:
		# Instancing Bullet
		var nBullet: Bullet = m_psBullet.instance()
		get_tree().root.add_child(nBullet)
		var nTargetRoom: Node2D = m_anPlayerRooms[randi() % m_anPlayerRooms.size()]
		nBullet.global_position = global_position
		nBullet.set_target_room(nTargetRoom)

		m_nProgressBar.value = 0
