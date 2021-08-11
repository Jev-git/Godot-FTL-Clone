extends Node2D

export var m_psHPBar: PackedScene
export var m_iMaxHP: int = 10
var m_iCurrentHP: int
var m_fHPBarWidth: float = 0
var m_aHPSprites
signal ship_exploded

func _ready():
	m_iCurrentHP = m_iMaxHP
	
	for i in range(m_iMaxHP):
		var nHPBar: Sprite = m_psHPBar.instance()
		add_child(nHPBar)
		if m_fHPBarWidth == 0:
			m_fHPBarWidth = nHPBar.get_texture().get_width() * nHPBar.scale.x
		nHPBar.position.x = m_fHPBarWidth * i
	m_aHPSprites = get_children()

func take_damage(_iAmount: int):
	if m_iCurrentHP <= _iAmount:
		print("Ship explode!!!")
		emit_signal("ship_exploded")
		get_parent().visible = false
	else:
		for i in range(_iAmount):
			m_aHPSprites[m_iCurrentHP - 1 - i].set_modulate(Color(1, 0, 0, 1))
		m_iCurrentHP -= _iAmount
