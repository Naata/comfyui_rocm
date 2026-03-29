Contenerized ComfyUI ready to use with AMD cards that are ROCM-compatible.

Sample `docker-compose.yaml` to run it:

```yaml
services:
  comfyui-rocm:
    image: naata/comfyui-rocm:rocm7.2.1_ubuntu24.04_py3.12_pytorch_release_2.9.1_comfyui_v0.18.3
    deploy:
      resources:
        limits:
          memory: 57G
    devices:
      - /dev/kfd:/dev/kfd
      - /dev/dri:/dev/dri
    environment: 
    # ComfyUI cli args
        COMFYUI_ARGS: --cache-none --disable-smart-memory --enable-manager 

        # expose AMD card
        HIP_PLATFORM: amd
        HIP_VISIBLE_DEVICES: 0
        ROCR_VISIBLE_DEVICES: 0
        CUDA_VISIBLE_DEVICES: ""

        # HSA
        ROCM_GPU: gfx1200
        HSA_OVERRIDE_GFX_VERSION: 12.0.0
        HSA_ENABLE_ASYNC_COPY: 1
        HSA_ENABLE_SDMA: 1
        HSA_ENABLE_PEER_SDMA: 1
        HSA_ENABLE_SDMA_COPY: 1
        HSA_ENABLE_SDMA_KERNEL_COPY: 1

        # misc ??
        MIOPEN_FIND_MODE: 2
        FLASH_ATTENTION_TRITON_AMD_ENABLE: "TRUE"
        FLASH_ATTENTION_TRITON_AMD_AUTOTUNE: "TRUE"
        FLASH_ATTENTION_BACKEND: "flash_attn_triton_amd"
        TRITON_USE_ROCM: ON
    group_add:
      - video
    ports:
      - '8188:8188'
    restart: unless-stopped
    volumes:
      - /local/path/to/models:/workspace/models
      - /local/path/to/output:/workspace/output
      - /local/path/to/input:/workspace/input
      - /local/path/to/custom_nodes:/workspace/custom_nodes
      - /local/path/to/user:/workspace/user

# True?NAS specific - can be skipped 
x-portals:
  - host: 0.0.0.0
    name: Web UI
    path: /
    port: 8188
    scheme: http
```