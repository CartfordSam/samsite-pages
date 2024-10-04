#!/bin/bash
OUTPUT_DIR=$1
INPUT_FILE=$2
TEMPLATE_DIR=$3

# Resolve paths
ENTRYPOINT_PATH=$(cd "$(dirname "$0")"; pwd)/$(basename "$0")
PROJECT_DIR=$(dirname "$ENTRYPOINT_PATH")

# Find the abs path of the 'public' directory
PUBLIC_DIR=$(cd "$PROJECT_DIR/public"; pwd)
IMAGES_DIR=$(cd "$PUBLIC_DIR/images"; pwd)

# Generate output file name
OUTPUT_FILE="${OUTPUT_DIR}/index.html"

echo "PROJECT_DIR:   $PROJECT_DIR"
echo "PUBLIC_DIR:    $PUBLIC_DIR"
echo "IMAGES_DIR:    $IMAGES_DIR"

# Call Pandoc with resolved paths
pandoc --toc -s --css $PUBLIC_DIR/reset.css \
       --css $PUBLIC_DIR/index.css \
       -i "landing.md" \
       -o "landing.html" \
       -V PUBLIC_DIR=$PUBLIC_DIR \
       --template="template.html" \
       -s --verbose

# For each .md file in the md_blogs/ directory, generate a .html file and place it in the blogs/ directory
for file in $PROJECT_DIR/md_blogs/*.md; do
    filename=$(basename -- "$file")
    filename="${filename%.*}"
    echo "Processing $filename"
    pandoc --toc -s --css $PUBLIC_DIR/reset.css \
           --css $PUBLIC_DIR/index.css \
           -i "md_blogs/$filename.md" \
           -o "blogs/$filename.html" \
           -V PUBLIC_DIR=$PUBLIC_DIR \
           --template="template.html" \
           -s --verbose
done

mv landing.html static/index.html
mv blogs/*.html static/blogs/