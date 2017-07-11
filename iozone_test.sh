wget -c http://www.iozone.org/src/current/iozone3_465.tar
tar -xf iozone3_465.tar
cd iozone3_465/src/current/
make linux-arm
iozone -a
