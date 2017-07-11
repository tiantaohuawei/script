PARTITION="/dev/sda1"
IOENGINE="sync"
BLOCK_SIZE="4k"
fio_test() {
    # shellcheck disable=SC2039
    local rw="$1"

    # Run fio test.
    echo
    info_msg "Running fio ${BLOCK_SIZE} ${rw} test ..."
    fio -name="${rw}" -rw="${rw}" -bs="${BLOCK_SIZE}" -size=1G -runtime=300 \
        -numjobs=1 -ioengine="${IOENGINE}" -direct=1 -group_reporting 
        echo
}
fio_build_install() {
    wget http://brick.kernel.dk/snaps/fio-2.1.10.tar.gz
    tar -xvf fio-2.1.10.tar.gz
    cd fio-2.1.10
    ./configure
    make all
    make install
}
fio_build_install
for rw in "read" randread write randwrite rw randrw; do
    fio_test "${rw}"
done
