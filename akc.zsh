#!/bin/zsh -e

# =============================== Config Begin =============================== #

NET_TIMEOUT=5   # in seconds
CACHE_TTL=3600  # in seconds
CACHE_DIR=/tmp/zshakc

declare -A USER_MAP=(
    [qc]='QuarticCat'
    [jumpuser]='QuarticCat Enter-tainer'  # space-separated
)

# ================================ Config End ================================ #

mkdir -p $CACHE_DIR
cd $CACHE_DIR

for id in $=USER_MAP[$1]; {
    cache=($id(Nms-$CACHE_TTL))
    if [[ -z $cache ]] {
        curl "https://github.com/$id.keys" -sm $NET_TIMEOUT | tee $id
    } else {
        cat $id && touch $id
    }
}
