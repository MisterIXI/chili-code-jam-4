shader_type canvas_item;

uniform vec4 color_a : source_color = vec4(0.05, 0.25, 0.35, 1.0);
uniform vec4 color_b : source_color = vec4(0.1, 0.45, 0.55, 1.0);

uniform float speed = 0.25;
uniform float distortion_strength = 0.08;
uniform float wave_scale = 3.0;

void fragment() {
    vec2 uv = UV;

    float t = TIME * speed;

    // Mehrere Wellen für organisches Fließen
    float wave1 = sin((uv.y + t) * 6.0);
    float wave2 = sin((uv.y * 1.5 + t * 1.3) * 10.0);
    float wave3 = sin((uv.y * 3.0 - t * 0.7) * 14.0);

    float distortion = (wave1 + wave2 * 0.5 + wave3 * 0.25);
    uv.x += distortion * distortion_strength;

    // Langsame Farbverläufe wie Strömungen
    float flow = sin((uv.y * wave_scale) + t) * 0.5 + 0.5;

    vec4 color = mix(color_a, color_b, flow);

    COLOR = color;
}
