shader_type canvas_item;

uniform float alpha = 1.0;
uniform vec4 shader_color: source_color = vec4(1.0);

void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	input_color.rgb = mix(input_color.rgb, shader_color.rgb, alpha);
	COLOR = input_color;
}