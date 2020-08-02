bindir = /usr/local/bin
binary_name = album-picker
binary_path = $(bindir)/$(binary_name)

install:
	cp driver.perl $(binary_path)
	chmod 0755 $(binary_path)
