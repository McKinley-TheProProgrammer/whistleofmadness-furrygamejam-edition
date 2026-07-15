shader_type canvas_item;

uniform vec4 blink_color : source_color = vec4(1.0); 

uniform float saturation_amount : hint_range(0.0, 5.0, 0.01) = 2.0;
// A intensidade máxima do piscar (quão forte a cor de piscar cobrirá a imagem).
// 0.0 = sem piscar, 1.0 = cobre totalmente a imagem com a blink_color.
uniform float blink_max_intensity : hint_range(0.0, 1.0, 0.01) = 0.5;
// Quão rápido a imagem pisca. Valores maiores piscam mais rápido.
uniform float blink_frequency : hint_range(0.0, 20.0, 0.1) = 5.0;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	
	// 2. LÓGICA DE SATURAÇÃO
    // Calcular a luminância (brilho perceptivo) da cor original.
    // Usamos pesos padrão para o olho humano (R: 30%, G: 59%, B: 11%).
    float luminance = dot(tex.rgb, vec3(0.299, 0.587, 0.114));
    vec3 grayscale_color = vec3(luminance);
	
	vec3 saturated_rgb = mix(grayscale_color, tex.rgb, saturation_amount);
	
	// 3. LÓGICA DE PISCAR
    // Criar uma onda senoidal rítmica baseada no tempo global (TIME).
    // sin(TIME * blink_frequency) oscila suavemente entre -1 e 1.
    // Nós ajustamos para oscilar suavemente entre 0.0 e 1.0.
    float sine_factor = (sin(TIME * blink_frequency) + 1.0) / 2.0;
    
    // Multiplicar o fator senoidal pela intensidade máxima configurada.
    // Isso define a força atual da mistura do piscar neste exato momento.
    float current_blink_intensity = sine_factor * blink_max_intensity;
    
    // Misturar a cor supersaturada com a cor de piscar, baseado na intensidade rítmica.
    vec3 final_rgb = mix(saturated_rgb, blink_color.rgb, current_blink_intensity);
    
    // 4. SAÍDA FINAL
    // Aplicar a cor final calculada, mantendo o canal Alpha (transparência) original.
    COLOR = vec4(final_rgb, tex.a);
	
}
