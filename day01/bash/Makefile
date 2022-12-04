# vim: shiftwidth=2 tabstop=2 noexpandtab :
.PHONY: test

test:
	bats test/*bats

dependencies:
	sudo apt install $$(cat .dependencies) >/dev/null 2>&1

