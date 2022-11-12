#!/bin/zsh -e

# -------------------------------- Config Begin --------------------------------

NET_TIMEOUT=5  # in seconds
CACHE_TTL=3600  # in seconds
CACHE_DIR=/tmp/zshakc

declare -A USER_MAP=(
    [qc]='QuarticCat'
    [jumpuser]='QuarticCat Enter-tainer'
)

# --------------------------------- Config End ---------------------------------

mkdir -p $CACHE_DIR

for id in $=USER_MAP[$1]; {
    cache=$CACHE_DIR/$id
    if [[ -f $cache ]] && (( $(date +%s) - $(date +%s -r $cache) <= $CACHE_TTL )) {
        cat $cache && touch $cache
    } else {
        curl "https://github.com/$id.keys" --silent --max-time $NET_TIMEOUT | tee $cache
    }
}
