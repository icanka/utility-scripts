#!/bin/bash
#echo "${ids[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '
#sorted_unique_ids=($(echo "${ids[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

total_progress="$(jobs -r | wc -l)"
ids=('192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2' '192.168.1.90' 'jenkins' 'test' 'test3' 'test56' '1' '2')
#echo "${ids[@]}"
#echo "${ids[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '
#sorted_unique_ids=($(echo "${ids[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
#echo "${sorted_unique_ids[@]}"

function progressbar() {
  # Process data
  let _progress=(${1} * 100 / ${2} * 100)/100
  let _done=(${_progress} * 4)/10
  let _left=40-$_done
  # Build progressbar string lengths
  _fill=$(printf "%${_done}s")
  _empty=$(printf "%${_left}s")

  # 1.2 Build progressbar strings and print the ProgressBar line
  # 1.2.1 Output example:
  # 1.2.1.1 Progress : [########################################] 100%
  printf "\rProgress : [${_fill// /▇}${_empty// / }] ${_progress}%%"

}

calculate_progress() {
  running=$(jobs -r | wc -l)
  let current_progress=$total_progress-$running
}

# Example ping function
ping_v2() {
  sleep $((1 + $RANDOM % 60))
  if [[ -f $1.txt ]]; then
    rm $1.txt;
  fi
  echo "$RANDOM" >>$1.txt
  ping -c 1 -W 1 $1 >>/dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    (
      nohup ssh -o LOGLEVEL=ERROR -o BATCHMODE=yes raflman@$1 <<EOF
sleep 6
pkill -9 aide
echo aide --check
EOF
    ) >>"${1}.txt" 2>&1 </dev/null
  fi
}

# Start background jobs.
for ip in "${ids[@]}"; do
  ping_v2 "${ip}" &
done
# Get the total numer of running background jobs.
total_progress="$(jobs -r | wc -l)"


# Start showing progress bar
until [ "$(jobs -r | wc -l)" -le 0 ]; do
  calculate_progress
  progressbar $current_progress $total_progress
  sleep 0.1
done

# for the last time for showing %100 progress
calculate_progress
progressbar $current_progress $total_progress

# Kind of sanity check
if [[ $current_progress -eq total_progress && "$(jobs -r | wc -l)" -eq 0 ]]; then
  printf '\nFinished!\n'
  exit 0
fi
