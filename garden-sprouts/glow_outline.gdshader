shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(1.0, 0.85, 0.3, 1.0);
uniform float glow_size : hint_range(0.0, 20.0) = 6.0;      // how far the glow reaches, in pixels
uniform float glow_strength : hint_range(0.0, 4.0) = 1.5;   // how bright/solid it gets near the edge
uniform int samples : hint_range(4, 32) = 16;               // directions checked; more = smoother

void fragment() {
	vec4 base = texture(TEXTURE, UV);

	// Look outward in a circle of directions, at 3 distances each.
	// Closer samples count more, which gives the soft falloff.
	float glow = 0.0;
	for (int i = 0; i < samples; i++) {
		float angle = TAU * float(i) / float(samples);
		vec2 dir = vec2(cos(angle), sin(angle));
		for (float r = 1.0; r <= 3.0; r += 1.0) {
			vec2 offset = dir * TEXTURE_PIXEL_SIZE * glow_size * (r / 3.0);
			float weight = (4.0 - r) / 3.0;
			glow += texture(TEXTURE, UV + offset).a * weight;
		}
	}
	glow = clamp(glow / (float(samples) * 2.0) * glow_strength, 0.0, 1.0);

	// Glow underneath, original sprite drawn on top
	vec4 outline = vec4(glow_color.rgb, glow_color.a * glow);
	COLOR = mix(outline, base, base.a);
}
