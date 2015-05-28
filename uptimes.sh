#!/bin/bash
# uptimes - prints uptime history
# 
# bash + awk based script to show `last` output as `uptime`
# 

# Variables
mode=0
# `which` program path, please change if necessary (`locate which`)
which=/bin/which

force_exit=0

# AWK script
awk_script=$(cat <<AWK_SCRIPT
{
    core = \$4;
    date_start = (\$5" "\$6" "\$7" "\$9);
    date_stop = (\$11 " " \$12 " " \$13 " " \$15);
    time_start = (\$8); 
    time_stop = \$14; 
    raw_uptime = \$16; 

    gsub(/[\(\)]/, "", raw_uptime); 

    count = split(raw_uptime, uptime, "+");

    if(mode > 0)
        output = ("Started at " date_start " " time_start " ");
    
    if (mode > 1)
        output = output "To " date_stop " " time_stop " ";
    
    if(count > 1)
        print output "up " uptime[1] " day, " uptime[2];
    else
        print output "up " uptime[1];
}
AWK_SCRIPT
)

# Functions
usage()
{
    cat <<SHORT_HELP
Usage: $0 [OPTION]
Try $0 --help for more information.
SHORT_HELP
}
usage_full()
{
    cat <<FULL_HELP
Usage: $0 [OPTION]
Show uptime history, provided by \`last\` program

Options:
    -h                  Show usage help
    --help              Show this help
    -s  --short         Short uptime info
    -f  --full          Full uptime info

Report bugs to: ikenfin@gmail.com
FULL_HELP
}

# Options handler
while [ "$1" != "" ]; do
    case $1 in
        -s | --short )  mode=1
                        ;;
        -f | --full )   mode=2
                        ;;
        -h )            usage
                        exit 0
                        ;;
        --help )        usage_full
                        exit 0
                        ;;
        * )             usage
                        exit 1
    esac
    shift
done 

# Run!
$($which last) -F reboot | $($which grep) "^reboot" | $($which awk) -vmode=$mode "$awk_script"
