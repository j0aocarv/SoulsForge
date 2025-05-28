shader_type canvas_item;

uniform vec2 speed = vec2(0.05, 0.0); // velocidade do movimento (X, Y)

void fragment() {
    vec2 uv_offset = UV + TIME * speed;
    COLOR = texture(TEXTURE, fract(uv_offset));
}
