#!/usr/bin/python3

import spidev
import time

spi = spidev.SpiDev(0, 1)
spi.mode = 0x00
spi.no_cs = True
spi.max_speed_hz = 1000000

buf = [0x00] * 4 # SOF
for i in range(3):
    buf = buf + [
        0xff, 0x08, 0x08, 0x08, # white
        0xff, 0x00, 0x00, 0x08, # red
        0xff, 0x00, 0x08, 0x00, # green
        0xff, 0x08, 0x00, 0x00] # blue
buf = buf + [0xff] * 4 #EOF
spi.writebytes(buf)

time.sleep(2.0)

buf = [0x00] * 4 # SOF
for i in range(12):
    buf = buf + [0xE0, 0x00, 0x00, 0x00] # off
buf = buf + [0xff] * 4 #EOF
spi.writebytes(buf)

spi.close()
