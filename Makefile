
all: blogs

clean:
	rm -f index.html

posts:
	pandoc --toc -s --css src/styles/reset.css --css src/styles/index.css -i src/posts_md/index.md -o src/posts/index.html --template=src/template.html --resource-path=./src/scripts --verbose

.PHONY: all clean blogs
