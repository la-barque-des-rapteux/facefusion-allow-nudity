FROM nvidia/cuda:12.6.3-cudnn-runtime-ubuntu24.04

ARG FACEFUSION_VERSION=3.1.1
ENV GRADIO_SERVER_NAME=0.0.0.0
ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/python3.12/dist-packages/tensorrt_libs

WORKDIR /facefusion

RUN apt-get update
RUN apt-get install python3.12 -y
RUN apt-get install python-is-python3 -y
RUN apt-get install pip -y
RUN apt-get install git -y
RUN apt-get install curl -y
RUN apt-get install ffmpeg -y
RUN pip install tensorrt==10.6.0 --extra-index-url https://pypi.nvidia.com

# Copiez les fichiers nécessaires du dossier local au dossier de travail du conteneur
COPY facefusion/ /facefusion/facefusion/
COPY install.py facefusion.py requirements.txt /facefusion/

RUN python install.py --onnxruntime cuda --skip-conda
