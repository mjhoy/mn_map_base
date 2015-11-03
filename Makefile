# -------------
# Relief raster
# -------------
#
# Download LiDAR data tiles for Hennepin County -- specifically the
# tiles that cover downtown/southern Minneapolis.
#
# More information here: http://www.mngeo.state.mn.us/chouse/elevation/lidar.html
#
# The map of what each tile covers is available here [PDF]:
# ftp://ftp.lmic.state.mn.us/pub/data/elevation/lidar/county/hennepin/hennepin_tile_index_map.pdf
HENNEPIN_BASE_URL=ftp://ftp.lmic.state.mn.us/pub/data/elevation/lidar/county/hennepin/geodatabase/

# This 4x4 set covers the area I want.
MN_TILES=3542-32-23 3542-32-24 3542-32-25 3542-32-26 \
         4342-01-23 4342-01-24 4342-01-25 4342-01-26 \
         4342-02-23 4342-02-24 4342-02-25 4342-02-26 \
         4342-03-23 4342-03-24 4342-03-25 4342-03-26
MN_TILES_S=$(addsuffix .gdb.zip,$(MN_TILES))

all: $(MN_TILES_S)

$(MN_TILES_S):
	curl $(HENNEPIN_BASE_URL)$@ -o $@

.PHONY: clean gitignore

# don't delete downloaded tiles since they are huge!
clean:

# List the generated files that we don't want to track in Git. To use
# like so: `make gitignore > .gitignore`
gitignore:
	@for i in $(MN_TILES_S) ; do \
		echo $$i ; \
	done
