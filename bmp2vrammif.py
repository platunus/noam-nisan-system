#!/usr/bin/python
import sys
import struct

infile = open('logo.bmp', mode='rb')
outfile = open('VRAM8K.mif', mode='w')

outfile.write('WIDTH=16;\n')
outfile.write('DEPTH=8192;\n\n')
outfile.write('ADDRESS_RADIX=HEX;\n')
outfile.write('DATA_RADIX=HEX;\n\n')
outfile.write('CONTENT BEGIN\n')

infile.read(10)
skip = struct.unpack('<I', infile.read(4))
infile.read(skip[0] - 14)

pos = 8160
for i in range(256):
	for j in range(32):
		word = 0
		for k in range(16):
			b = struct.unpack('B', infile.read(1))
			word = word + b[0] * (2 ** k)
		outfile.write('    {:04X}  :  {:04X};\n'.format(pos, word))
		pos = pos + 1
	pos = pos - 64

outfile.write('END;\n')
outfile.close()
infile.close()

