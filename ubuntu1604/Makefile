
help:
	@echo "make what? Available targets are:"
	@echo "  cuda(80|90|91|92)"
	@echo "    cuda v8.0/9.[012] runtimes. These, in addition, come"
	@echo "    with 'runas' ability."
	@echo "  cuda(80|90|91|92)-dev"
	@echo "    cuda v8.0/9.[012] devels. These, in addition, come with"
	@echo "    'runas' ability."
	@echo "  cudnn(51|60|80_70|90_70|90_71|91_71|92_71)"
	@echo "    cudnn runtimes."
	@echo "  cudnn(51|60|80_70|90_70|90_71|91_71|92_71)-dev"
	@echo "    cudnn dev images."
	@echo
	@echo "  py-h2o4gpu-dev(80|90|91|92)"
	@echo "    python wrapper around h2o4gpu dev environment."
	@echo
	@echo "  pytorch(60|80_70|90_70|90_71|91_71|92_71)"
	@echo "    gpu enabled pytorch (with pyml-env). Some flags to customize"
	@echo "    behavior:"
	@echo "    . PT_PORT - Jupyter port to be exposed [$(PT_PORT)]"
	@echo
	@echo "  cupy-dev(60|80_70|90_70|90_71|91_71|92_71)"
	@echo "    cupy on python3 (with pyml-env)."
	@echo
	@echo "  xgboost(80|90|91|92)"
	@echo "    install latest version of xgboost. Some flags to customize"
	@echo "    behavior:"
	@echo "    . XG_ARCH   - cuda arch(s) to build. [$(XG_ARCH)]"
	@echo "    . XG_COMMIT - commit ID to sync. [$(XG_COMMIT)]"
	@echo "    . XG_REPO   - repo to sync. [$(XG_REPO)]"
	@echo "  xgb-dev(80|90|91|92)"
	@echo "    install development env for xgboost. Assumes that user will"
	@echo "    mount xgboost repo while launching container on this image."
	@echo "  dask-xgboost(80|90|91|92)"
	@echo "    install latest version of dask over xgboost."
	@echo
	@echo "  gbm-bench(80|90|91|92)"
	@echo "    gbm benchmarking images. Some flags to customize behavior:"
	@echo "    . XG_ARCH        - cuda arch(s) to build. [$(XG_ARCH)]"
	@echo "    . GBM_XG_COMMIT  - xgboost commit ID. [$(GBM_XG_COMMIT)]"
	@echo "    . GBM_LG_COMMIT  - lightgbm commit ID. [$(GBM_LG_COMMIT)]"
	@echo "    . GBM_CAT_COMMIT - catboost commit ID. [$(GBM_CAT_COMMIT)]"
	@echo
	@echo "  faiss-dev(90|91|92)"
	@echo "    FAISS development environment. Assumes that user will mount"
	@echo "    faiss repo while launching container on this image."
	@echo
	@echo "  ml-dev"
	@echo "    ML development environment (over above cuda v9.2)"
	@echo
	@echo "  dsb-2018"
	@echo "    Working environment for Data Science Bowl - 2018. Some flags"
	@echo "    to customize behavior:"
	@echo "    . VIS_PORT       - visdom server port. [$(VIS_PORT)]"
	@echo
	@echo "  . gunrock      latest version of gunrock from github"
	@echo "  . postgres     install latest version of postgres"
	@echo "  . tensorflow10 install tensorflow 1.0"
	@echo "  . kaldi        install kaldi framework (shared lib version)"
	@echo "  . nvcaffe      install nv-caffe and its dependencies"
	@echo "  . pix2pix      pytorch implementation of pix2pix and cycle-gan works"
	@echo "  . mxnet        gpu enabled mxnet + keras (on top of pyml-env libs)"
	@echo "                 Some flags to customize behavior:"
	@echo "                   MX_PORT - Jupyter port to be exposed [$(MX_PORT)]"
	@echo "  . tf-keras     tensorflow + keras (on top of pyml-env libs)"
	@echo "                 Some flags to customize behavior:"
	@echo "                   TF_PORT - Jupyter port to be exposed [$(TF_PORT)]"
	@echo "  . pybind11     install pybind11 env"
	@echo "  . fairseq-py   intall pytorch version of conv NMT from faceboook."
	@echo "                 Some flags to customize behavior:"
	@echo "                   FS_PORT - Jupyter port to be exposed [$(FS_PORT)]"
	@echo "  . fairseq-py-dev intall dev env for pytorch version of conv NMT from faceboook."
	@echo "                   Some flags to customize behavior:"
	@echo "                   FS_PORT - Jupyter port to be exposed [$(FS_PORT)]"


## helper targets begin ##
# for the below targets, the pwd has to be inside the directory containing Dockerfile.cpp!
.PHONY: genContext
genContext:
	cpp -o Dockerfile Dockerfile.cpp && \
	make -f ../Makefile genContextOnly

.PHONY: genContextOnly
genContextOnly:
	grep -v -e '^#' -e '^# ' -e '^$$' Dockerfile > tmp && \
	mv tmp Dockerfile && \
	rm -rf contexts && \
	cp -r ../../shared-contexts contexts

.PHONY: delContext
delContext:
	rm -rf contexts Dockerfile
## help targets end ##


## cuda env related targets begin ##
.PHONY: cuda
cuda:
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDA_VERSION_FULL="$(__FULL)" \
	    -D__CUDA_VERSION_PKG="$(__PKG)" \
	    -D__CUDA_VERSION_SHORT="$(__SHORT)" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t cuda:$(__SHORT) . && \
	make -f ../Makefile delContext

.PHONY: cuda-dev
cuda-dev:
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDA_VERSION_FULL="$(__FULL)" \
	    -D__CUDA_VERSION_PKG="$(__PKG)" \
	    -D__CUDA_VERSION_SHORT="$(__SHORT)" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t cuda:$(__SHORT)-dev . && \
	make -f ../Makefile delContext

.PHONY: cuda80
cuda80:
	$(MAKE) __FULL="8.0.61" __PKG="8-0=8.0.61-1" __SHORT="8.0" cuda

.PHONY: cuda80-dev
cuda80-dev:
	$(MAKE) __FULL="8.0.61" __PKG="8-0=8.0.61-1" __SHORT="8.0" cuda-dev

.PHONY: cuda90
cuda90:
	$(MAKE) __FULL="9.0.176" __PKG="9-0=9.0.176-1" __SHORT="9.0" cuda

.PHONY: cuda90-dev
cuda90-dev:
	$(MAKE) __FULL="9.0.176" __PKG="9-0=9.0.176-1" __SHORT="9.0" cuda-dev

.PHONY: cuda91
cuda91:
	$(MAKE) __FULL="9.1.85" __PKG="9-1=9.1.85-1" __SHORT="9.1" cuda

.PHONY: cuda91-dev
cuda91-dev:
	$(MAKE) __FULL="9.1.85" __PKG="9-1=9.1.85-1" __SHORT="9.1" cuda-dev

.PHONY: cuda92
cuda92:
	$(MAKE) __FULL="9.2.88" __PKG="9-2=9.2.88-1" __SHORT="9.2" cuda

.PHONY: cuda92-dev
cuda92-dev:
	$(MAKE) __FULL="9.2.88" __PKG="9-2=9.2.88-1" __SHORT="9.2" cuda-dev
## cuda env related targets end ##


## cudnn env related core targets begin ##
.PHONY: cudnn
cudnn: cuda$(__CUDA_MINIFIED)
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDA_VERSION_SHORT="$(__SHORT)" \
	    -D__CUDNN_VERSION="$(__CUDNN)" \
	    -D__CUDNN_VERSION_SHORT="$(__CUDNN_SHORT)" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t cudnn:$(__SHORT)-$(__CUDNN) . && \
	make -f ../Makefile delContext

.PHONY: cudnn-dev
cudnn-dev: cuda$(__CUDA_MINIFIED)-dev
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDA_VERSION_SHORT="$(__SHORT)-dev" \
	    -D__CUDNN_VERSION="$(__CUDNN)" \
	    -D__CUDNN_VERSION_SHORT="$(__CUDNN_SHORT)" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t cudnn:$(__SHORT)-$(__CUDNN)-dev . && \
	make -f ../Makefile delContext
## cudnn env related core targets end ##


## cudnn with v8.0 env related targets end ##
.PHONY: cudnn51
cudnn51:
	$(MAKE) __CUDNN="5.1.10" __CUDNN_SHORT="5" __SHORT="8.0" __CUDA_MINIFIED="80" cudnn

.PHONY: cudnn60
cudnn60:
	$(MAKE) __CUDNN="6.0.21" __CUDNN_SHORT="6" __SHORT="8.0" __CUDA_MINIFIED="80" cudnn

.PHONY: cudnn80_70
cudnn80_70:
	$(MAKE) __CUDNN="7.0.5.15" __CUDNN_SHORT="7" __SHORT="8.0" __CUDA_MINIFIED="80" cudnn

.PHONY: cudnn51-dev
cudnn51-dev:
	$(MAKE) __CUDNN="5.1.10" __CUDNN_SHORT="5" __SHORT="8.0" __CUDA_MINIFIED="80" cudnn-dev

.PHONY: cudnn60-dev
cudnn60-dev:
	$(MAKE) __CUDNN="6.0.21" __CUDNN_SHORT="6" __SHORT="8.0" __CUDA_MINIFIED="80" cudnn-dev

.PHONY: cudnn80_70-dev
cudnn80_70-dev:
	$(MAKE) __CUDNN="7.0.5.15" __CUDNN_SHORT="7" __SHORT="8.0" __CUDA_MINIFIED="80" cudnn-dev
## cudnn with v8.0 env related targets end ##


## cudnn with v9.0 env related targets begin ##
.PHONY: cudnn90_70
cudnn90_70:
	$(MAKE) __CUDNN="7.0.5.15" __CUDNN_SHORT="7" __SHORT="9.0" __CUDA_MINIFIED="90" cudnn

.PHONY: cudnn90_70-dev
cudnn90_70-dev:
	$(MAKE) __CUDNN="7.0.5.15" __CUDNN_SHORT="7" __SHORT="9.0" __CUDA_MINIFIED="90" cudnn-dev

.PHONY: cudnn90_71
cudnn90_71:
	$(MAKE) __CUDNN="7.1.3.16" __CUDNN_SHORT="7" __SHORT="9.0" __CUDA_MINIFIED="90" cudnn

.PHONY: cudnn90_71-dev
cudnn90_71-dev:
	$(MAKE) __CUDNN="7.1.3.16" __CUDNN_SHORT="7" __SHORT="9.0" __CUDA_MINIFIED="90" cudnn-dev
## cudnn with v9.0 env related targets end ##


## cudnn with v9.1 env related targets begin ##
.PHONY: cudnn91_71
cudnn91_71:
	$(MAKE) __CUDNN="7.1.3.16" __CUDNN_SHORT="7" __SHORT="9.1" __CUDA_MINIFIED="91" cudnn

.PHONY: cudnn91_71-dev
cudnn91_71-dev:
	$(MAKE) __CUDNN="7.1.3.16" __CUDNN_SHORT="7" __SHORT="9.1" __CUDA_MINIFIED="91" cudnn-dev
## cudnn with v9.1 env related targets end ##


## cudnn with v9.2 env related targets begin ##
.PHONY: cudnn92_71
cudnn92_71:
	$(MAKE) __CUDNN="7.1.4.18" __CUDNN_SHORT="7" __SHORT="9.2" __CUDA_MINIFIED="92" cudnn

.PHONY: cudnn92_71-dev
cudnn92_71-dev:
	$(MAKE) __CUDNN="7.1.4.18" __CUDNN_SHORT="7" __SHORT="9.2" __CUDA_MINIFIED="92" cudnn-dev
## cudnn with v9.2 env related targets end ##


## py-h2o4gpu-dev env's start ##
.PHONY: py-h2o4gpu-dev
py-h2o4gpu-dev: cuda$(__CUDA_MINIFIED)-dev
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDA_VERSION_SHORT="$(__SHORT)-dev" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t py-h2o4gpu-dev:latest-$(__CUDA_MINIFIED) . && \
	make -f ../Makefile delContext

.PHONY: py-h2o4gpu-dev80
py-h2o4gpu-dev80:
	$(MAKE) __CUDA_MINIFIED="80" __SHORT="8.0" py-h2o4gpu-dev

.PHONY: py-h2o4gpu-dev90
py-h2o4gpu-dev90:
	$(MAKE) __CUDA_MINIFIED="90" __SHORT="9.0" py-h2o4gpu-dev

.PHONY: py-h2o4gpu-dev91
py-h2o4gpu-dev91:
	$(MAKE) __CUDA_MINIFIED="91" __SHORT="9.1" py-h2o4gpu-dev

.PHONY: py-h2o4gpu-dev92
py-h2o4gpu-dev92:
	$(MAKE) __CUDA_MINIFIED="92" __SHORT="9.2" py-h2o4gpu-dev
## py-h2o4gpu-dev env's end ##


## pytorch env's start ##
PT_PORT ?= 8888
.PHONY: pytorch
pytorch: cudnn$(__CUDNN_MINIFIED)-dev
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDNN_VERSION_TAG="$(__CUDNN_TAG)-dev" \
	    -D__NCCL_VERSION_TAG=$(__NCCL_TAG) \
	    -DPT_ARCH="$(PT_ARCH)" \
	    -D__MAGMA="$(__MAGMA)" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t pytorch:latest-$(__CUDNN_MINIFIED) \
	    --build-arg port=$(PT_PORT) . && \
	make -f ../Makefile delContext

.PHONY: pytorch60
pytorch60:
	$(MAKE) \
	    __MAGMA="magma-cuda80" \
	    __CUDNN_MINIFIED="60" \
	    __CUDNN_TAG="8.0-6.0.21" \
	    PT_ARCH="3.5 5.2 6.0 6.1+PTX" \
	    __NCCL_TAG="2.1.15" \
	    pytorch

.PHONY: pytorch80_70
pytorch80_70:
	$(MAKE) \
	    __MAGMA="magma-cuda80" \
	    __CUDNN_MINIFIED="80_70" \
	    __CUDNN_TAG="8.0-7.0.5.15" \
	    PT_ARCH="3.5 5.2 6.0 6.1+PTX" \
	    __NCCL_TAG="2.1.15" \
	    pytorch

.PHONY: pytorch90_70
pytorch90_70:
	$(MAKE) \
	    __MAGMA="magma-cuda90" \
	    __CUDNN_MINIFIED="90_70" \
	    __CUDNN_TAG="9.0-7.0.5.15" \
	    PT_ARCH="3.5 5.2 6.0 6.1 7.0+PTX" \
	    __NCCL_TAG="2.1.15" \
	    pytorch

.PHONY: pytorch90_71
pytorch90_71:
	$(MAKE) \
	    __MAGMA="magma-cuda90" \
	    __CUDNN_MINIFIED="90_71" \
	    __CUDNN_TAG="9.0-7.1.3.16" \
	    PT_ARCH="3.5 5.2 6.0 6.1 7.0+PTX" \
	    __NCCL_TAG="2.1.15" \
	    pytorch

.PHONY: pytorch91_71
pytorch91_71:
	$(MAKE) \
	    __MAGMA="magma-cuda90" \
	    __CUDNN_MINIFIED="91_71" \
	    __CUDNN_TAG="9.1-7.1.3.16" \
	    PT_ARCH="3.5 5.2 6.0 6.1 7.0+PTX" \
	    __NCCL_TAG="2.1.15" \
	    pytorch

.PHONY: pytorch92_71
pytorch92_71:
	$(MAKE) \
	    __MAGMA="magma-cuda90" \
	    __CUDNN_MINIFIED="92_71" \
	    __CUDNN_TAG="9.2-7.1.4.18" \
	    PT_ARCH="3.5 5.2 6.0 6.1 7.0+PTX" \
	    __NCCL_TAG="2.2.12" \
	    pytorch
## pytorch env's end ##


## cupy-dev env's start ##
.PHONY: cupy-dev
cupy-dev: cudnn$(__CUDNN_MINIFIED)-dev
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDNN_VERSION_TAG="$(__CUDNN_TAG)-dev" \
	    -D__NCCL_VERSION_TAG=$(__NCCL_TAG) \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t cupy-dev:latest-$(__CUDNN_MINIFIED) \
	    --build-arg port=$(PT_PORT) . && \
	make -f ../Makefile delContext

.PHONY: cupy-dev60
cupy-dev60:
	$(MAKE) __CUDNN_MINIFIED="60" \
	        __CUDNN_TAG="8.0-6.0.21" \
	        __NCCL_TAG="2.1.15" \
	    cupy-dev

.PHONY: cupy-dev80_70
cupy-dev80_70:
	$(MAKE) __CUDNN_MINIFIED="80_70" \
	        __CUDNN_TAG="8.0-7.0.5.15" \
	        __NCCL_TAG="2.1.15" \
	    cupy-dev

.PHONY: cupy-dev90_70
cupy-dev90_70:
	$(MAKE) __CUDNN_MINIFIED="90_70" \
	        __CUDNN_TAG="9.0-7.0.5.15" \
	        __NCCL_TAG="2.1.15" \
	    cupy-dev

.PHONY: cupy-dev90_71
cupy-dev90_71:
	$(MAKE) __CUDNN_MINIFIED="90_71" \
	        __CUDNN_TAG="9.0-7.1.3.16" \
	        __NCCL_TAG="2.1.15" \
	    cupy-dev

.PHONY: cupy-dev91_71
cupy-dev91_71:
	$(MAKE) __CUDNN_MINIFIED="91_71" \
	        __CUDNN_TAG="9.1-7.1.3.16" \
	        __NCCL_TAG="2.1.15" \
	    cupy-dev

.PHONY: cupy-dev92_71
cupy-dev92_71:
	$(MAKE) __CUDNN_MINIFIED="92_71" \
	        __CUDNN_TAG="9.2-7.1.4.18" \
	        __NCCL_TAG="2.2.12" \
	    cupy-dev
## cupy-dev env's end ##


## xgboost env's start ##
__XG_ARCH ?= 35;50;52;60;61;70
XG_COMMIT ?= c004cea788748c293e2f9e5c9bd7469ff7e2c613
XG_REPO   ?= "dmlc/xgboost"
.PHONY: xgboost
xgboost: cuda$(__CUDA_MINIFIED)-dev
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDA_VERSION_SHORT="$(__SHORT)" \
	    -D__NCCL_VERSION_TAG="$(__NCCL_TAG)" \
	    -DXGB_REPO="$(XG_REPO)" \
	    -DXGB_ARCH="$(__XG_ARCH)" \
	    -DXGB_COMMIT="$(XG_COMMIT)" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t xgboost:latest-$(__SHORT) . && \
	make -f ../Makefile delContext

.PHONY: xgboost80
xgboost80:
	$(MAKE) __CUDA_MINIFIED="80" __SHORT="8.0" __NCCL_TAG="2.2.13" __XG_ARCH="35;50;52;60;61" xgboost

.PHONY: xgboost90
xgboost90:
	$(MAKE) __CUDA_MINIFIED="90" __SHORT="9.0" __NCCL_TAG="2.2.13" xgboost

.PHONY: xgboost91
xgboost91:
	$(MAKE) __CUDA_MINIFIED="91" __SHORT="9.1" __NCCL_TAG="2.2.12" xgboost

.PHONY: xgboost92
xgboost92:
	$(MAKE) __CUDA_MINIFIED="92" __SHORT="9.2" __NCCL_TAG="2.2.13" xgboost

.PHONY: xgb-dev
xgb-dev: cuda$(__CUDA_MINIFIED)-dev
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDA_VERSION_SHORT="$(__SHORT)-dev" \
	    -D__NCCL_VERSION_TAG="$(__NCCL_TAG)" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t xgb:dev-$(__SHORT) . && \
	make -f ../Makefile delContext

.PHONY: xgb-dev80
xgb-dev80:
	$(MAKE) __CUDA_MINIFIED="80" __SHORT="8.0" __NCCL_TAG="2.2.13" __XG_ARCH="35;50;52;60;61" xgb-dev

.PHONY: xgb-dev90
xgb-dev90:
	$(MAKE) __CUDA_MINIFIED="90" __SHORT="9.0" __NCCL_TAG="2.2.13" xgb-dev

.PHONY: xgb-dev91
xgb-dev91:
	$(MAKE) __CUDA_MINIFIED="91" __SHORT="9.1" __NCCL_TAG="2.2.12" xgb-dev

.PHONY: xgb-dev92
xgb-dev92:
	$(MAKE) __CUDA_MINIFIED="92" __SHORT="9.2" __NCCL_TAG="2.2.13" xgb-dev
## xgboost env's end ##


## dask-xgboost env's start ##
.PHONY: dask-xgb-dev
dask-xgb-dev: xgb-dev$(__CUDA_MINIFIED)
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDA_VERSION_SHORT="dev-$(__SHORT)" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t dask-xgb:dev-$(__SHORT) . && \
	make -f ../Makefile delContext

.PHONY: dask-xgb-dev80
dask-xgb-dev80:
	$(MAKE) __CUDA_MINIFIED="80" __SHORT="8.0" dask-xgb-dev

.PHONY: dask-xgb-dev90
dask-xgb-dev90:
	$(MAKE) __CUDA_MINIFIED="90" __SHORT="9.0" dask-xgb-dev

.PHONY: dask-xgb-dev91
dask-xgb-dev91:
	$(MAKE) __CUDA_MINIFIED="91" __SHORT="9.1" dask-xgb-dev

.PHONY: dask-xgb-dev92
dask-xgb-dev92:
	$(MAKE) __CUDA_MINIFIED="92" __SHORT="9.2" dask-xgb-dev

.PHONY: dask-xgboost
dask-xgboost: xgboost$(__CUDA_MINIFIED)
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDA_VERSION_SHORT="latest-$(__SHORT)" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t dask-xgboost:$(__SHORT) . && \
	make -f ../Makefile delContext

.PHONY: dask-xgboost80
dask-xgboost80:
	$(MAKE) __CUDA_MINIFIED="80" __SHORT="8.0" dask-xgboost

.PHONY: dask-xgboost90
dask-xgboost90:
	$(MAKE) __CUDA_MINIFIED="90" __SHORT="9.0" dask-xgboost

.PHONY: dask-xgboost91
dask-xgboost91:
	$(MAKE) __CUDA_MINIFIED="91" __SHORT="9.1" dask-xgboost

.PHONY: dask-xgboost92
dask-xgboost92:
	$(MAKE) __CUDA_MINIFIED="92" __SHORT="9.2" dask-xgboost
## dask-xgboost env's end ##


## gbm-bench env's start ##
GBM_XG_COMMIT  ?= c004cea788748c293e2f9e5c9bd7469ff7e2c613
GBM_LG_COMMIT  ?= c6cdea75a3f7732a13c21c760c1bf221441a5c79
GBM_CAT_COMMIT ?= 37936c513c63e3bf0227b5cd828cee9341f0a365
__XG_ARCH=35;50;52;60;61;70
.PHONY: gbm-bench
gbm-bench: cuda$(__CUDA_MINIFIED)-dev
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDA_VERSION_SHORT="$(__SHORT)" \
	    -D__NCCL_VERSION_TAG="$(__NCCL_TAG)" \
	    -DXGB_ARCH="$(__XG_ARCH)" \
	    -DXGB_COMMIT="$(GBM_XG_COMMIT)" \
	    -DLG_COMMIT="$(GBM_LG_COMMIT)" \
	    -DCAT_COMMIT="$(GBM_CAT_COMMIT)" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t gbm-bench:latest-$(__SHORT) . && \
	make -f ../Makefile delContext

.PHONY: gbm-bench80
gbm-bench80:
	$(MAKE) __CUDA_MINIFIED="80" __SHORT="8.0" __XG_ARCH="35;50;52;60;61" __NCCL_TAG="2.2.13" gbm-bench

.PHONY: gbm-bench90
gbm-bench90:
	$(MAKE) __CUDA_MINIFIED="90" __SHORT="9.0" __NCCL_TAG="2.2.13" gbm-bench

.PHONY: gbm-bench91
gbm-bench91:
	$(MAKE) __CUDA_MINIFIED="91" __SHORT="9.1" __NCCL_TAG="2.2.12" gbm-bench

.PHONY: gbm-bench92
gbm-bench92:
	$(MAKE) __CUDA_MINIFIED="92" __SHORT="9.2" __NCCL_TAG="2.2.13" gbm-bench
## gbm-bench env's end ##


## faiss env's start ##
.PHONY: faiss-dev
faiss-dev: cuda$(__CUDA_MINIFIED)-dev
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDA_VERSION_SHORT="$(__SHORT)-dev" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t faiss:dev-$(__SHORT) . && \
	make -f ../Makefile delContext

.PHONY: faiss-dev90
faiss-dev90:
	$(MAKE) __CUDA_MINIFIED="90" __SHORT="9.0" faiss-dev

.PHONY: faiss-dev91
faiss-dev91:
	$(MAKE) __CUDA_MINIFIED="91" __SHORT="9.1" faiss-dev

.PHONY: faiss-dev92
faiss-dev92:
	$(MAKE) __CUDA_MINIFIED="92" __SHORT="9.2" faiss-dev
## faiss env's start ##


.PHONY: postgres
postgres:
	cd postgres && docker build -t postgres:latest .


## what targets follow hereafterwards are the ones which are built
## using a specific version of the above base images!
## (hence the parent image tags are being hard-coded!)

.PHONY: ml-dev
ml-dev: cuda92-dev
	cd $@ && \
	cpp -o Dockerfile \
	    -D__CUDA_VERSION_SHORT="9.2" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t ml:dev . && \
	make -f ../Makefile delContext

VIS_PORT ?= 8097
.PHONY: dsb-2018
dsb-2018: pytorch90_70
	cd $@ && \
	cpp -o Dockerfile \
	    -D__PYTORCH_VERSION_TAG="latest-90_70" \
	    Dockerfile.cpp && \
	make -f ../Makefile genContextOnly && \
	docker build -t dsb:2018 \
	    --build-arg visport=$(VIS_PORT) . && \
	make -f ../Makefile delContext

.PHONY: pix2pix
pix2pix: pytorch90_70
	cd pix2pix && \
	    cpp -o Dockerfile \
	        -D__PYTORCH_VERSION_TAG="latest-90_70" \
	        Dockerfile.cpp && \
	    docker build -t pix2pix:latest . && \
	    rm -f Dockerfile


.PHONY: gunrock
gunrock: cuda80
	cd gunrock && docker build -t gunrock:latest .

.PHONY: kaldi
kaldi: cudnn60
	cd kaldi && docker build -t kaldi:latest .

.PHONY: tensorflow10
tensorflow10: cudnn51
	cd tensorflow10 && \
	    cpp -o Dockerfile Dockerfile.cpp && \
	    docker build -t tensorflow:1.0 . && \
	    rm -f Dockerfile

.PHONY: nvcaffe
nvcaffe: cudnn60
	cd nvcaffe && docker build -t nvcaffe:latest .

MX_PORT ?= 8888
.PHONY: mxnet
mxnet: cudnn60
	cd mxnet && \
	    cpp -o Dockerfile Dockerfile.cpp && \
	    cp -r ../../shared-contexts contexts && \
	    docker build -t mxnet:keras \
	        --build-arg port=$(MX_PORT) . && \
	    rm -rf contexts Dockerfile

TF_PORT ?= 8888
.PHONY: tf-keras
tf-keras: cudnn60
	cd tf-keras && \
	    cpp -o Dockerfile Dockerfile.cpp && \
	    cp -r ../../shared-contexts contexts && \
	    docker build -t tensorflow:keras \
	        --build-arg port=$(TF_PORT) . && \
	    rm -rf contexts Dockerfile

.PHONY: pybind11
pybind11: cudnn60
	cd pybind11 && \
	    cpp -o Dockerfile Dockerfile.cpp && \
	    docker build -t pybind11:dev . && \
	    rm -f Dockerfile

FS_PORT ?= 8888
.PHONY: fairseq-py
fairseq-py: cudnn60
	cd $@ && \
	make -f ../Makefile genContext && \
	docker build -t fairseq-py:latest \
	    --build-arg port=$(FS_PORT) . && \
	make -f ../Makefile delContext

.PHONY: fairseq-py-dev
fairseq-py-dev: cudnn60
	cd $@ && \
	make -f ../Makefile genContext && \
	docker build -t fairseq-py-dev:latest \
	    --build-arg port=$(FS_PORT) . && \
	make -f ../Makefile delContext
