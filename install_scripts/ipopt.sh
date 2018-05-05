#
# Install Ipopt
#
RUN echo "" && \
    echo "================" && \
    echo "INSTALLING IPOPT" && \
    echo "================" && \
    echo ""
ENV IPOPT_VERSION="3.12.9"
ARG TARGET="Ipopt-${IPOPT_VERSION}"
RUN cd ${PREFIX} && \
    rm -rf ${TARGET}.tgz && \
    wget -q "https://www.coin-or.org/download/source/Ipopt/${TARGET}.tgz" && \
    tar xf ${TARGET}.tgz && \
    rm -rf ${TARGET}.tgz && \
    cd ${PREFIX}/${TARGET}/ThirdParty && \
    cd ASL && ./get.ASL 2> /dev/null && cd .. && \
    cd Blas && ./get.Blas 2> /dev/null && cd .. && \
    cd Lapack && ./get.Lapack 2> /dev/null && cd .. && \
    cd Metis && ./get.Metis 2> /dev/null && cd .. && \
    cd Mumps && ./get.Mumps 2> /dev/null && cd .. && \
    cd .. && \
    mkdir build && \
    cd build && \
    ../configure CXX=g++ CC=gcc F77=gfortran > /dev/null && \
    make -j$(nproc) > /dev/null && \
    make install > /dev/null
ENV PATH="${PREFIX}/${TARGET}/build/bin:${PATH}"
ARG TARGET
