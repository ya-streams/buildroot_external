#!/usr/bin/python3

import time
from apa102 import APA102

leds_count = 12

pattern = []
for i in range(20):
    pattern.append(i)
for i in range(20, 0, -1):
    pattern.append(i)
pattern = pattern + [0,] * 20

colors = []
for r in pattern:
    colors.append((r, 0, 0))
for g in pattern:
    colors.append((0, g, 0))
for b in pattern:
    colors.append((0, 0, b))
for w in pattern:
    colors.append((w, w, w))

lights = APA102(12, force_gpio=False, spi_max_speed_hz=1000000)


try:
    print("Press Ctrl-C to terminate while statement")
    while True:
        for i in range(leds_count):
            lights.set_pixel(i, *colors[i])
        lights.show()
        colors.append(colors.pop(0))
        time.sleep(0.02)
except KeyboardInterrupt:
    pass

for i in range(leds_count):
    lights.set_pixel(i, 0, 0, 0)
lights.show()
