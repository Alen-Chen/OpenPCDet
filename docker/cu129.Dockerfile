
FROM nvidia/cuda:12.9.1-devel-ubuntu24.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TORCH_CUDA_ARCH_LIST="8.9"

# Install essentials
RUN apt update
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y \
    git wget curl vim build-essential cmake \
    python3.10 python3.10-venv python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

# Install PyTorch (CUDA 12.1 build)
RUN pip install --upgrade pip && \
    pip install torch==2.1.0+cu121 torchvision==0.16.0+cu121 --extra-index-url https://download.pytorch.org/whl/cu121

# Install spconv for CUDA 12.1
RUN pip install spconv-cu121

# Clone OpenPCDet
WORKDIR /workspace
RUN git clone https://github.com/open-mmlab/OpenPCDet.git

WORKDIR /workspace/OpenPCDet

