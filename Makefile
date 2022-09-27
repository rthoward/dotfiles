.PHONY: install
install:
	stow -n --verbose --target=$(HOME) */

.PHONY: uninstall
uninstall:
	stow -n --verbose --target=$(HOME) --delete */
