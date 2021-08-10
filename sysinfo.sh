clear
sudo apt install linuxlogo
echo ""
linuxlogo
lsb_release -irdc
printf "Kernel Version: ";uname -r
printf "Processor Type: ";uname -m
printf "\n"
printf "RAM Stats: "
printf "\n"
free -h
printf "\n"
printf "RAM Stats (rounded off):"
printf "\n"
free -h --si
