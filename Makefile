# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

build-love :;  zip -9 -r $(GAMENAME).love .
dev :; lovelier dev .
install-submodule :; git submodule update --init