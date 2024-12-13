shader_type canvas_item;

uniform sampler2D scree_texture: hint_screen_texture;

uniform sampler2D noise_texture: filter_nearest, repeat_enable;

uniform float distortion = 0.01;

uniform vec2 speed = vec2(0.5, 0.2);
// Called for every vertex the material is visible on.
void vertex() {
}

// Called for every pixel the material is visible on.
void fragment() {
	vec2 uv = UV + speed * TIME;
	
	vec2 noise = 2.0 * texture(noise_texture, uv).rg - vec2(1.0);
	
	COLOR = texture(TEXTURE, UV);
	COLOR *= texture(scree_texture, SCREEN_UV + noise * distortion);
}
