#
# Install common Python libraries
#
RUN echo "" && \
    echo "======================" && \
    echo "INSTALLING PYTHON LIBS" && \
    echo "======================" && \
    echo ""
RUN pip install --no-cache-dir -U \
      pip \
      setuptools && \
    pip install --no-cache-dir \
      sphinx \
      sphinx_rtd_theme \
      wheel \
      virtualenv \
      cffi \
      numpy \
      scipy \
      matplotlib \
      mpi4py \
      cryptography \
      sympy \
      networkx \
      dill \
      vmprof
# These may fail on PyPy / Python 3.7-rc
RUN pip install --no-cache-dir PyYAML || echo failed to install PyYAML
RUN pip install --no-cache-dir numba || echo failed to install numba
RUN pip install --no-cache-dir pandas || echo failed to install pandas
