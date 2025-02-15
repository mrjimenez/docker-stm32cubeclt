FROM ubuntu:24.04

ENV CLT_SCRIPT_NAME=en.st-stm32cubeclt_1.17.0_23554_20241124_1810_amd64.sh
ENV CLT_INSTALL_PATH=/opt/st/stm32cubeclt_1.17.0

ENV SRC_DIR=/tmp/src
ENV SRC_FILE=${SRC_DIR}/${CLT_SCRIPT_NAME}
ENV DST_DIR=/tmp/dst
ENV DST_FILE=${DST_DIR}/${CLT_SCRIPT_NAME}

ENV LICENSE_ALREADY_ACCEPTED=1
ENV DEBIAN_FRONTEND=noninteractive

ENV PATH=${CLT_INSTALL_PATH}/GNU-tools-for-STM32/bin:$PATH
ENV PATH=${CLT_INSTALL_PATH}/Ninja/bin:$PATH
ENV PATH=${CLT_INSTALL_PATH}/CMake/bin:$PATH
ENV PATH=${CLT_INSTALL_PATH}/STLink-gdb-server/bin:$PATH
ENV PATH=${CLT_INSTALL_PATH}/STM32CubeProgrammer/bin:$PATH
ENV PATH=${CLT_INSTALL_PATH}:$PATH

RUN apt-get -y update && apt-get -y install zip gcc g++ make
RUN mkdir ${SRC_DIR} && mkdir ${DST_DIR}
# The file inside the folder must not be a symbolic link, but it can be a hard link.
RUN --mount=type=bind,dst=${SRC_DIR} <<EOF
	unzip -p ${SRC_FILE}.zip > ${DST_FILE}
	chmod +x ${DST_FILE}
	echo | ${DST_FILE} --nox11
	rm -rf ${DST_DIR}
EOF
