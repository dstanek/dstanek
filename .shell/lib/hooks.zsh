# keep all of the history in ~/.all_history
function preexec {
    # original idea from:
    # http://eli.thegreenplace.net/2013/06/11/keeping-persistent-history-in-bash
    echo "`date '+%Y-%m-%d %H:%M:%S %Z'` | $1" >> ~/.all_history;
}
