ARG BASE_IMAGE="rocm7.2_ubuntu24.04_py3.12_pytorch_release_2.9.1"
FROM $BASE_IMAGE

ENV COMFYUI_PATH="/workspace"
ENV PORT=8188
WORKDIR /workspace

RUN apt-get update && apt-get install -y \
  git \
  wget \
  curl

ARG COMFYUI_VERSION="master"
RUN git clone https://github.com/comfyanonymous/ComfyUI.git ./ --branch $COMFYUI_VERSION

RUN pip install -r requirements.txt
RUN pip install -r manager_requirements.txt
RUN cm-cli restore-dependencies

EXPOSE $PORT

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:$PORT/ || exit 1

COPY ./start_comfyui.sh /workspace/start_comfyui.sh

RUN chmod +x /workspace/start_comfyui.sh

CMD ["/workspace/start_comfyui.sh"]
