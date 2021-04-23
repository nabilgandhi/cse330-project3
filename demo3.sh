test_sizes=( 400 600 10000 90000 900000 9000000 235929600)
make
gcc -o wss_test wss_test.c
clear;
for i in "${test_sizes[@]}"
do
        echo "-------------- $i --------------"
        killall wss_test
        sudo dmesg -c > /dev/null
        ./wss_test $i  &
        sleep 10
        pid=( $(pgrep -f wss_test) )
        wss=( $(sudo cat /proc/$pid/smaps | grep Referenced: | awk '{print $2}' | awk '{ SUM += $1} END { print SUM }') )

        sudo rmmod module_wss
        sudo insmod module_wss.ko pid=$pid

        sleep 10

        wss_module=( $(dmesg | grep kB) )
        echo "PID: $pid   WSS smaps: $wss"
        sudo dmesg | grep kB
        echo ""
done
