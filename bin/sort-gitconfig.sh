# 1. check if indentation is 1 tab only
cat ~/.gitconfig \
    | sed 's/   +/\t/g' \
    | awk -F '\t' '$1 { current = $1; print current } $2 { print current "\t" $2}' \
    | sort \
    | awk -F '\t' '!$2 {print $1} $1 && $2 { print "\t" $2 }'