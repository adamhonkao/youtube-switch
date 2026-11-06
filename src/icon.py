from PIL import Image, ImageDraw
S = 4096  # draw big, downsample for smooth edges
k = S / 1024
img = Image.new("RGBA", (S, S), (0, 0, 0, 0))
d = ImageDraw.Draw(img)
def r(*v): return [int(x * k) for x in v]
# drop shadow + body (Apple icon grid: 824px body, 100px margin)
d.rounded_rectangle(r(100, 112, 924, 936), radius=int(185*k), fill=(0, 0, 0, 60))
d.rounded_rectangle(r(100, 100, 924, 924), radius=int(185*k), fill=(222, 38, 38, 255))
# play triangle
d.polygon([tuple(r(420, 230)), tuple(r(420, 530)), tuple(r(670, 380))], fill="white")
# toggle switch: white track, red knob on the right
d.rounded_rectangle(r(250, 640, 774, 800), radius=int(80*k), fill="white")
d.ellipse(r(626, 652, 762, 788), fill=(222, 38, 38, 255))
img = img.resize((1024, 1024), Image.LANCZOS)
import os
os.makedirs("icon.iconset", exist_ok=True)
for n in (16, 32, 128, 256, 512):
    img.resize((n, n), Image.LANCZOS).save(f"icon.iconset/icon_{n}x{n}.png")
    img.resize((n*2, n*2), Image.LANCZOS).save(f"icon.iconset/icon_{n}x{n}@2x.png")
img.save("icon-preview.png")
