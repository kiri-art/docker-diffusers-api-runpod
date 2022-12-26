ARG FROM_IMAGE="gadicc/diffusers-api"
FROM ${FROM_IMAGE} as base
ENV FROM_IMAGE=${FROM_IMAGE}

ARG MODEL_ID="stabilityai/stable-diffusion-2-1-base"
ENV MODEL_ID=${MODEL_ID}
ARG PRECISION="fp16"
ENV PRECISION=${PRECISION}
ARG PIPELINE="ALL"
ENV PIPELINE=${PIPELINE}

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION
ARG AWS_S3_ENDPOINT_URL
ARG AWS_S3_DEFAULT_BUCKET

ARG MODEL_URL="s3://"
ENV MODEL_URL=${MODEL_URL}
ARG CHECKPOINT_URL=""
ENV CHECKPOINT_URL=${CHECKPOINT_URL}
ARG CHECKPOINT_CONFIG_URL=""
ENV CHECKPOINT_CONFIG_URL=${CHECKPOINT_CONFIG_URL}
#ARG RUNTIME_DOWNLOADS=1
#ENV RUNTIME_DOWNLOADS=${RUNTIME_DOWNLOADS}
ENV RUNTIME_DOWNLOADS=0

ARG http_proxy
ARG https_proxy
ARG REQUESTS_CA_BUNDLE=${http_proxy:+/usr/local/share/ca-certificates/squid-self-signed.crt}

RUN pip install runpod
RUN python3 download.py

ARG SAFETENSORS_FAST_GPU=1
ENV SAFETENSORS_FAST_GPU=${SAFETENSORS_FAST_GPU}

ADD handler.py .
# CMD [ "python", "-u", "handler.py" ] # <-- doesn't honor SHELL
CMD python -u handler.py               # <--    does honor SHELL

