import numpy as np
from PIL import Image

WIDTH = 320
HEIGHT = 240
TOTAL_PIXELS = WIDTH * HEIGHT

def generate_mem_file(input_filename, preview_out, mem_out):
    # 1. Load and scale image to exact half-resolution
    img = Image.open(input_filename).convert('RGB')
    img = img.resize((WIDTH, HEIGHT))
    
    # 2. Strict 8-color VGA hardware palette [R, G, B]
    vga_palette = [
        0,   0,   0,     # 0: 000 Black
        0,   0,   255,   # 1: 001 Blue
        0,   255, 0,     # 2: 010 Green
        0,   255, 255,   # 3: 011 Cyan
        255, 0,   0,     # 4: 100 Red
        255, 0,   255,   # 5: 101 Magenta
        255, 255, 0,     # 6: 110 Yellow
        255, 255, 255    # 7: 111 White
    ]
    vga_palette += [0] * (768 - len(vga_palette))
    
    palette_image = Image.new('P', (1, 1))
    palette_image.putpalette(vga_palette)
    
    # 3. Quantize with Floyd-Steinberg dithering
    print(f"Applying dithering at {WIDTH}x{HEIGHT}...")
    dithered_img = img.quantize(palette=palette_image, dither=1)
    
    # Save preview scaled up by 2x (640x480) as a standard PNG image
    preview_full = dithered_img.resize((640, 480), Image.NEAREST).convert('RGB')
    preview_full.save(preview_out)
    print(f"Saved matching 640x480 preview to {preview_out}")
    
    # 4. Extract pixel data
    pixel_data = np.array(dithered_img).flatten()
    
    # 5. Write the Verilog Memory File (.mem)
    print(f"Writing {mem_out}...")
    with open(mem_out, 'w') as f:
        for color_val in pixel_data:
            # Write exactly one 3-bit binary value per line
            f.write(f"{color_val:03b}\n")

    print(f"\nSuccessfully generated {mem_out} with {TOTAL_PIXELS} words.")

if __name__ == "__main__":
    generate_mem_file(
        "input_image.jpeg", 
        "output_preview.png", 
        "bird.mem"
    )