.PHONY: install
install:
	stow --verbose --target=$(HOME) */

.PHONY: uninstall
uninstall:
	stow --verbose --target=$(HOME) --delete */
