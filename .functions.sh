function whatsmyip { ifconfig $1 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'; }
function psgrep { ps aux | grep -v grep | grep $1; }
function psgrepkill { kill $(ps aux | grep $1 | grep -v grep | awk '{print $2};') || echo 'No results found'; }



