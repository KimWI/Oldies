files = ['aleste2%d.dsk' % i for i in xrange(1,4)]
content = ""
for f in files:
  content += open(f).read()

rom = ""
index = []
unique = {}
current = 0
for i in xrange(len(content) / 512):
  sector = content[i * 512: i * 512 + 512]
  if sector in unique:
    index.append(unique[sector])
  else:
    unique[sector] = current
    index.append(current)
    current += 1
    rom += sector

f = open("index.inc", "wt")
f.write("\n".join("\tdw %d" % i for i in index))
f.close()

f = open("data.bin", "wb")
f.write(rom)
f.close()

f = open("boot.bin", "wb")
f.write(rom[:256])
f.close()
