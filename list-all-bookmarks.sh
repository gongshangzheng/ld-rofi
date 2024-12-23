#!/bin/sh

# Originally from lukesmith with some changes
# Gives a dmenu prompt to search DuckDuckGo.
# Without input, will open DuckDuckGo.com.
# Anything else, it search it.

LAUNCER="dmenu -l 20 -i -p "
#LAUNCER="rofi -dmenu -i -p "
BROWSER="qutebrowser"
linkding_rss="YOUR LINKDING FEED URL HERE"
[ -z "${DISPLAY}" ] && LAUNCER="fzf --prompt "

localBROWSER="$BROWSER "
[ -n "$*" ] && localBROWSER="$*"
[ -z "${DISPLAY}" ] && localBROWSER="w3m "

linkding_bookmarks="$(curl -s $linkding_rss | xmlstarlet sel -t -m "//item" -v "concat('linkding: ', title, ' | ', link, ' | ')" -m "category" -v "." -o ', ' -b -n | sed 's/, $//')"
#qutebrowser_bookmarks=$( sed "s/^/bookmark: /" $HOME/.config/qutebrowser/bookmarks/urls)
qutebrowser_bookmarks=$(awk '{first=$1; $1=""; print "bookmark:", $0, first}' $HOME/.config/qutebrowser/bookmarks/urls)
qutebrowser_quickmarks=$( sed "s/^/quickmark: /" $HOME/.config/qutebrowser/quickmarks)
#printf "%s" "$linkding_bookmarks"
if [ -f $HOME/.config/qutebrowser/bookmarks/urls ]; then
	choice=$((echo "🦆"  && echo "$qutebrowser_quickmarks" && echo "$qutebrowser_bookmarks" &&  echo "$linkding_bookmarks") | $LAUNCER"Search:") || exit 1
else
	choice=$(echo "🦆" | $LAUNCER -i -p "Search DuckDuckGo:") || exit 1
fi
case "$choice" in
*🦆*)
	$localBROWSER
	exit
	;;
bookmark:*|quickmark:*|linkding:*)
    $localBROWSER"$(echo $choice | awk '{print $NF}')"
    exit
    ;;
*) $localBROWSER"https://duckduckgo.com/?q=$choice"
	exit
	;;
esac
#vim:ft=sh

