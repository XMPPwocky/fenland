APPNAME = "Fenland"
VERSION = "0.01"

top = "."
out = "build"

def configure(ctx):
	ctx.load("gas")
	ctx.find_program("ld", var="ASLINK")

def build(ctx):
	ctx.recurse("kernel")
