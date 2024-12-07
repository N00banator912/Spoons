

shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float windspeed = 1.0f;
	float windDirection = 32.0f; // Angle in Degrees
	
	vec2 pos = UV;
	
	float xComp = 0.5f;
	float yComp = 0.5f;
	pos.x = pos.x + (TIME * xComp * windspeed);
	pos.y = pos.y + (TIME * yComp * windspeed);
	COLOR = texture(TEXTURE, pos);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}