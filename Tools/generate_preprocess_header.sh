#!/bin/sh

cd "$PROJECT_DIR"
COMMITS=`git rev-list HEAD --count`

echo "// Auto-generated" > "$ACK_ENV_PREPROCESS_HEADER"
echo "" >> "$ENV_PREPROCESS_HEADER"
echo "#define BUILD_NUMBER $COMMITS" >> "$ENV_PREPROCESS_HEADER"
cd -
