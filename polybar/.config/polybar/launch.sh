#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes has been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Launch our bars...
# old way: polybar bottom &
# to launch the same bar to each monitor
# "bottom is the name of the bar in the config
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload bottom &
done
