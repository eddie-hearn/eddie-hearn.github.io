from PIL import Image, ImageDraw, ImageFont

def create_image_with_text(size, text):
    img = Image.new('RGB', (600, 50), "white")
    draw = ImageDraw.Draw(img)
    draw.text((size[0], size[1]), text, font = fnt, fill="black")
    return img

frames = []

def roll(text):
    for i in range(len(text)+1):
        new_frame = create_image_with_text((0,0), text[:i])
        frames.append(new_frame)
# <<< ========== Customize font and text below ============== >>>>
fnt = ImageFont.truetype("/usr/share/fonts/truetype/liberation/LiberationSerif-Regular.ttf", 36)

text1 = """ Conflict & Security
Interstate conflict
Terrorism
Cyber crime
Resource competition
International Cooperation
Regional Integration""".splitlines()
[roll(text) for text in text1]
# <<< ======================================================== >>>
frames[0].save('banner1.gif', format='GIF',
               append_images=frames[1:], save_all=True, duration=200, loop=0)

