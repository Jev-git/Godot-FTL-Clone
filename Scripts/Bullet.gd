extends Node2D

export var m_fSpeed: float = 10.0
export var m_fMinDistance: float = 1.0
var m_vTargetPos: Vector2
var m_nTargetRoom: Node2D

func _process(delta):
	if !m_nTargetRoom:
		return
	if global_position.distance_to(m_vTargetPos) <= m_fMinDistance:
		m_nTargetRoom.on_hit(self)
		queue_free()
	else:
		global_position += delta * (m_vTargetPos - global_position) * m_fSpeed

func set_target_room(_nTargetRoom: Node2D):
	m_nTargetRoom = _nTargetRoom
	m_vTargetPos = m_nTargetRoom.global_position
	rotate(global_position.angle_to_point(m_vTargetPos))
