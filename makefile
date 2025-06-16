.PHONY: build css publish

dev:
	./build.sh

css:
	./mvAssets.sh

clean:
	./clean.sh

publish:
	./build.sh && ./clean.sh && ./git.sh
