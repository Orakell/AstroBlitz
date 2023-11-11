class_name Utils

static func random_unit_vector2() -> Vector2:
	var vector = Vector2()
	vector.x = randf_range(-1.0, 1.0)
	vector.y = randf_range(-1.0, 1.0)
	return vector.normalized()
