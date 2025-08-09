#!/usr/bin/env zsh

# Define paths to power settings files (adjust as needed)
CHARGE_STOP_FILE="/sys/class/power_supply/BAT0/charge_stop_threshold"
CHARGE_START_FILE="/sys/class/power_supply/BAT0/charge_start_threshold"

# Values for enabling charge limit
STOP_CHARGE_AT=80
START_CHARGE_BELOW=40

# Function to check current state
check_status() {
    if [[ -f $CHARGE_STOP_FILE && -f $CHARGE_START_FILE ]]; then
        stop_limit=$(cat $CHARGE_STOP_FILE)
        start_limit=$(cat $CHARGE_START_FILE)
        if [[ $stop_limit -eq $STOP_CHARGE_AT && $start_limit -eq $START_CHARGE_BELOW ]]; then
            echo "Charge limit is currently ON."
        else
            echo "Charge limit is currently OFF."
        fi
    else
        echo "Charge limit files not found or unsupported hardware."
        exit 1
    fi
}

# Function to enable charge limit
enable_charge_limit() {
    echo "Enabling charge limit..."
    echo $STOP_CHARGE_AT | sudo tee $CHARGE_STOP_FILE
    echo $START_CHARGE_BELOW | sudo tee $CHARGE_START_FILE
    echo "Charge limit enabled: Stop at $STOP_CHARGE_AT%, Start below $START_CHARGE_BELOW%."
}

# Function to disable charge limit
disable_charge_limit() {
    echo "Disabling charge limit..."
    echo 100 | sudo tee $CHARGE_STOP_FILE
    echo 0 | sudo tee $CHARGE_START_FILE
    echo "Charge limit disabled: Battery will charge fully."
}

# Main toggle logic
if [[ $1 == "on" ]]; then
    enable_charge_limit
elif [[ $1 == "off" ]]; then
    disable_charge_limit
else
    check_status
    echo "Usage: $0 [on|off]"
fi
