FROM cuda:8.0

# install essentials
RUN apt-get update && apt-get install -y --no-install-recommends \
        cmake \
        git \
        libbz2-dev \
        unzip \
        wget

# install boost
RUN wget --no-check-certificate 'https://versaweb.dl.sourceforge.net/project/boost/boost/1.58.0/boost_1_58_0.tar.gz' && \
    tar xf boost_1_58_0.tar.gz && \
    cd boost_1_58_0 && ./bootstrap.sh && ./bjam && ./bjam install && \
    cd .. && rm -rf boost_1_58_0 && rm boost_1_58_0.tar.gz

# install gunrock
RUN git config --global http.sslVerify false && \
    git clone --recursive https://github.com/gunrock/gunrock && \
    cd gunrock && mkdir build && cd build && \
    cmake .. -DGUNROCK_GENCODE_SM60=ON -DGUNROCK_GENCODE_SM61=ON && make

# download large datasets as well for benchmarking
RUN cd gunrock/dataset/large && \
    make WGET="wget --no-check-certificate" TOPC

# update the topc scripts for benchmarking
# TODO: remove this instruction once the changes in 'topc' have been
# merged into gunrock repo
COPY topc gunrock/dataset/test-scripts/topc

# command to benchmark
CMD cd gunrock/data/set/test-scripts/topc && \
    ./topc-test.sh ../../../build/bin/ ../../large/
