extends Node2D
class_name Bullet

export var m_fSpeed: float = 10.0
export var m_fMinDistance: float = 1.0
onready var m_nPlayerShield: Node2D = get_tree().get_nodes_in_group("MyShip")[0].get_node("Shield")
onready var m_nEnemyShield: Node2D = get_tree().get_nodes_in_group("EnemyShip")[0].get_node("Shield")
var m_bIsEnemyBullet: bool
var m_vTargetPos: Vector2
var m_nTargetRoom: Node2D

func _process(delta):
	if !m_nTargetRoom:
		return
	if hit_shield():
		if !m_bIsEnemyBullet:
			m_nEnemyShield.on_hit(self)
		else:
			m_nPlayerShield.on_hit(self)
		queue_free()
	elif global_position.distance_to(m_vTargetPos) <= m_fMinDistance:
		m_nTargetRoom.on_hit(self)
		queue_free()
	else:
		global_position += delta * (m_vTargetPos - global_position) * m_fSpeed

func set_target_room(_nTargetRoom: Node2D, _bIsEnemyRoom: bool = true):
	m_bIsEnemyBullet = !_bIsEnemyRoom
	m_nTargetRoom = _nTargetRoom
	m_vTargetPos = m_nTargetRoom.global_position
	rotate(global_position.angle_to_point(m_vTargetPos))

func hit_shield() -> bool:
	if !m_bIsEnemyBullet:
		if (
			abs(m_nEnemyShield.global_position.x - global_position.x) <= m_fMinDistance
			and m_nEnemyShield.is_active()
		):
			return true
	else:
		if (
			abs(m_nPlayerShield.global_position.x - global_position.x) <= m_fMinDistance
			and m_nPlayerShield.is_active()
		):
			return true
	return false
