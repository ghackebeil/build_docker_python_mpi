#
# Install Glpk
#
RUN echo "" && \
    echo "===============" && \
    echo "INSTALLING GLPK" && \
    echo "===============" && \
    echo ""
ENV GLPK_VERSION="4.65"
ARG TARGET="glpk-${GLPK_VERSION}"
RUN cd /root && \
    rm -rf ${TARGET}.tar.gz && \
    wget -q "https://ftp.gnu.org/gnu/glpk/${TARGET}.tar.gz" && \
    tar xf ${TARGET}.tar.gz && \
    rm -rf ${TARGET}.tar.gz && \
    mkdir ${TARGET}/build && \
    cd ${TARGET}/build && \
    ../configure CXX=g++ CC=gcc F77=gfortran --prefix=/usr/local > /dev/null && \
    make -j$(nproc) > /dev/null && \
    make install > /dev/null && \
    cd ../../ && \
    rm -r ${TARGET}
ARG TARGET
