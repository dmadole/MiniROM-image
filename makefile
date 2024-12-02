
none:
	@echo Specify target as one of mini, superelf, rc1802

mini superelf rc1802: mbios/mbios.asm utility/utility.asm romdisk/files
	$(MAKE) -C mbios $@
	$(MAKE) -C utility $@
	$(MAKE) -C romdisk
	printf '\xc0\xeb\x00' > rom-$@.img
	cat romdisk/romdisk.img >> rom-$@.img
	truncate -s 27392 rom-$@.img
	cat utility/utility.bin >> rom-$@.img
	truncate -s 28672 rom-$@.img
	head -c -4 mbios/mbios.bin >> rom-$@.img
	bash tools/checksum.sh rom-$@.img >> rom-$@.img

clean:
	$(MAKE) -C mbios clean
	$(MAKE) -C utility clean
	$(MAKE) -C romdisk clean
	@rm -f rom-*.img

