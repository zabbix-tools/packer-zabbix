all:
	for i in centos-*; do echo ... $${i}; (cd $${i} && make); done

install:
	for i in centos-*; do echo ... $${i}; (cd $${i} && make install); done
