.DEFAULT: all
.PHONY: all
all: build

VENV = .venv

.PHONY: venv
venv: ${VENV}

${VENV}:
	@python3 -mvenv ${@}
	@${VENV}/bin/pip install --upgrade pip setuptools wheel
	@${VENV}/bin/pip install --upgrade --requirement requirements.txt

.PHONY: bootstrap
bootstrap:
	sudo apt-get install python3 python3-venv slic3r

.PHONY: clean
clean:
	@git clean -xfd

.PHONY: unbundle
unbundle: build
	@make clean unbundle


.PHONY: build
build: ${VENV}
	@rm -rf filament print printer
	@${VENV}/bin/python slic3r_unbundle.py Slic3r_config_bundle.ini
	@git add filament print printer
	@git commit -am "Build: `date`"
	@git push origin HEAD:master

