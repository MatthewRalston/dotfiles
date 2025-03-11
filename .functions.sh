function whatsmyip { ifconfig $1 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'; }
function psgrep { ps aux | grep -v grep | grep $1; }
function psgrepkill { kill $(ps aux | grep $1 | grep -v grep | awk '{print $2};') || echo 'No results found'; }

function mostusedcommands { history | awk '{print $2}' | sort | uniq -c | sort -nr | head -10; }
function reset_path { PATH=/usr/local/bin:/usr/sbin:/usr/bin:/bin:$HOME/bin:$HOME/.local/bin:$HOME/home/bin:$PYENV_ROOT/bin:$PYENV_ROOT/shims:$HOME/.cargo/bin; }


#alias random_rune_sound="find /storage/misc/Dota_rune_mp3s/ -type f -name '*.mp3.mpga' | xargs shuf -n1 -e"
# function random_rune_sound {
#     find /storage/misc/Dota_rune_mp3s/ -type f -name '*.mp3.mpga' | xargs shuf -n1 -e
# }


#export BELL=1


echo -e "\n\n.functions.sh loaded...\n\n"
#echo "Bell was: $BELL"


function play_random_rune_sound {
    #BELL=$1
    echo "playing rune sound..." >&2
    echo "BELL value is $BELL..." >&2

    if [[ $BELL == 1 ]]; then
	# Silent
	find /storage/misc/Dota_rune_mp3s/ -type f -name '*.mp3.mpga' | xargs shuf -n1 -e | xargs ffplay -nodisp -autoexit -t 1.5 -volume 30 -loglevel quiet -i
	# Debug
	#find /storage/misc/Dota_rune_mp3s/ -type f -name '*.mp3.mpga' | xargs shuf -n1 -e | xargs ffplay -nodisp -autoexit -t 1.5 -volume 30 -i
    else
	echo "Refusing to play rune sounds..." >&2
    fi
    echo "Done" >&2
}
export -f play_random_rune_sound
