extends Node2D

func on_hit(_nBulletType: Node2D):
	print("%s is hit by %s" % [name, _nBulletType.name])
