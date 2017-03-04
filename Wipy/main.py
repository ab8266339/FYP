import pycom
import time
import math
import machine
import micropython
pycom.heartbeat(True)
#
#
dac =machine.DAC(1)

buf= array(10000000)
for i in range(len(buf)):
    buf[i] = 128 + int(127*math.sin(2*math.pi*i/len(len(buf)))
 dac.write_timed(buf, 400*len(buf), mode=DAC.CIRCULAR)
