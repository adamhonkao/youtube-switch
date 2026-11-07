# Draws the 1200x630 social share image (site/og.png). Run from build/ after icon.py.
from PIL import Image, ImageDraw, ImageFont
W, H = 1200, 630
img = Image.new("RGB", (W, H), (246, 246, 244))
d = ImageDraw.Draw(img)
icon = Image.open("icon-preview.png").resize((300, 300), Image.LANCZOS)
img.paste(icon, (70, (H - 300) // 2), icon)
font = "/System/Library/Fonts/HelveticaNeue.ttc"
bold = ImageFont.truetype(font, 76, index=1)
reg = ImageFont.truetype(font, 40, index=0)
x = 410
d.text((x, 175), "YouTube Switch", font=bold, fill=(29, 29, 31))
for i, line in enumerate(["Stop your kid watching YouTube", "on the Mac instead of doing", "homework. One click. Free."]):
    d.text((x, 290 + i * 54), line, font=reg, fill=(110, 110, 115))
d.rectangle([0, H - 14, W, H], fill=(222, 38, 38))
img.save("../site/og.png", optimize=True)
