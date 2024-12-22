#!/bin/sh

# Originally from lukesmith with some changes
# Gives a dmenu prompt to search DuckDuckGo.
# Without input, will open DuckDuckGo.com.
# Anything else, it search it.

BROWSER="firefox" #Your favorite browser
linkding_rss="YOUR LINKDING RSS URL HERE"
prefix="ld: "
[ -z "${DISPLAY}" ] && LAUNCER="fzf --prompt "

localBROWSER="$BROWSER "
[ -n "$*" ] && localBROWSER="$*"
[ -z "${DISPLAY}" ] && localBROWSER="w3m "

if [ -z "$linkding_rss" ]; then
    linkding_bookmarks="$(curl -s $linkding_rss | xmlstarlet sel -t -m "//item" -v "concat('$prefix', title, ' | ', link, ' | ')" -m "category" -v "." -o ', ' -b -n | sed 's/, $//')"
fi
#qutebrowser_bookmarks=$( sed "s/^/bookmark: /" $HOME/.config/qutebrowser/bookmarks/urls)
#printf "%s" "$linkding_bookmarks"
if [ -n "$linkding_bookmarks" ]; then
    choice=$((echo "🦆" && echo "$linkding_bookmarks") | rofi -show ld -dmenu -i -theme-str ' window { width: 100%;} ' -p "Search:") || exit 1
else
    choice=$(echo "🦆" | rofi -show ld -dmenu -i -theme-str ' window { width: 100%;} ' -p "Search DuckDuckGo:" -mesg "Your feed is empty") || exit 1
fi
case "$choice" in
*🦆*)
	exec $localBROWSER
	exit
	;;
$prefix*)
    exec $localBROWSER"$(echo $choice | awk '{print $NF}')"
    exit
    ;;
*) exec $localBROWSER"https://duckduckgo.com/?q=$choice"
	exit
	;;
esac
#vim:ft=sh

