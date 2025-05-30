.PHONY: build css publish

dev:
	./build.sh

css:
	./mvAssets.sh

publish:
	./build.sh && ./clean.sh && ./git.sh
