#
# Install common Python libraries
#
RUN echo "" && \
    echo "======================" && \
    echo "INSTALLING PYTHON LIBS" && \
    echo "======================" && \
    echo ""
RUN pip install --no-cache-dir -U pip && \
    pip install --no-cache-dir -U setuptools && \
    pip install --no-cache-dir -U wheel && \
    pip install --no-cache-dir \
      sphinx \
      sphinx_rtd_theme \
      virtualenv \
      cffi \
      numpy \
      mpi4py \
      cryptography \
      sympy \
      networkx \
      dill
# These may fail on PyPy / Python 3.7
RUN pip install --no-cache-dir PyYAML || \
    pip install https://github.com/yaml/pyyaml/archive/4.1.zip || \
    echo failed to install PyYAML
RUN pip install --no-cache-dir scipy || echo failed to install scipy
RUN pip install --no-cache-dir matplotlib || echo failed to install matplotlib
RUN pip install --no-cache-dir numba || echo failed to install numba
RUN pip install --no-cache-dir pandas || echo failed to install pandas
