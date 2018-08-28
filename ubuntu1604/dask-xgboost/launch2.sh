#!/bin/bash
port=${1:-8787}
ip=${2:-localhost}
nworkers=${3:-8}
script=${4:-./airline.py}


dask-scheduler --port $port --bokeh --bokeh-port 8888 &
SKED=$!
sleep 2
declare -a WIDS
for id in `seq 1 $nworkers`; do
    CUDA_VISIBLE_DEVICES=`expr $id - 1` dask-worker $ip:$port --memory-limit=auto --nprocs=1 --nthreads=1 --name "worker_$id" &
    WIDS[$id]=$!
done
sleep 2

echo ${WIDS}
