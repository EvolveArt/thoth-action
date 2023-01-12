#!/usr/bin/env bash
set -e

# smoelius: `get` works for non-standard variable names like `INPUT_CORPUS-DIR`.
get() {
    env | sed -n "s/^$1=\(.*\)/\1/;T;p"
}

TARGET="$1"

install_thoth()
{
    # THOTHPKG="thoth"
    # if [[ -n "$THOTHVER" ]]; then
    #     THOTHPKG="thoth==$THOTHVER"
    #     echo "[-] THOTHVER provided, installing $THOTHPKG"
    # fi
    apt-get update && apt-get install -y graphviz
    python3 -m venv /opt/thoth
    export PATH="/opt/thoth/bin:$PATH"
    # pip3 install wheel
    git clone https://github.com/FuzzingLabs/thoth && cd thoth
    pip install .
}

install_thoth

# compile all cairo files in $TARGET using starknet-compile
if [[ -d "$TARGET" ]]; then
    echo "[-] Compiling all cairo files in $TARGET"
    for file in $(find "$TARGET" -name "*.cairo"); do starknet-compile "$file" > build/"$file".json; done
fi

# run thoth on all json files in build/
for file in $(ls build | grep -v "abi"); do thoth local build/$file -call; done
rm -rf docs/callgraphs
mv output-callgraph docs/callgraphs



