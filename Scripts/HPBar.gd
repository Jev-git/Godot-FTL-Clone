extends Node2D
class_name HPBar

export var m_psHPBar: PackedScene

var m_iCurrentHP: int
var m_fHPBarWidth: float = 0
var m_aHPSprites

signal ship_exploded

func set_initial_hp(_iHP: int):
	m_iCurrentHP = _iHP
	
	for i in range(m_iCurrentHP):
		var nHPBar: Sprite = m_psHPBar.instance()
		add_child(nHPBar)
		if m_fHPBarWidth == 0:
			m_fHPBarWidth = nHPBar.get_texture().get_width() * nHPBar.scale.x
		nHPBar.position.x = m_fHPBarWidth * i
	m_aHPSprites = get_children()

func take_damage(_iAmount: int):
	if m_iCurrentHP <= _iAmount:
		emit_signal("ship_exploded")
		for sprite in get_children():
			sprite.queue_free()
	else:
		for i in range(_iAmount):
			m_aHPSprites[m_iCurrentHP - 1 - i].set_modulate(Color(1, 0, 0, 1))
		m_iCurrentHP -= _iAmount
