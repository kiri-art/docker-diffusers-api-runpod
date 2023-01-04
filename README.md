# docker-diffusers-api-runpod

Copyright (c) 2022 by Gadi Cohen <dragon@wastelands.net>  MIT Licensed.

## Quick Start

1. Clone the repo

2. Set any necessary environment variables and then build with e.g.

```bash
./build.sh -t user/runpod:sd-v2-1-512 \
  --build-arg MODEL_ID="stabilityai/stable-diffusion-2-1-base"
```

(or just use `docker build` as you see fit).

3. Upload to your repository of choice, e.g.

```bash
$ docker push user/runpod:sd-v2-1-512
```

See https://forums.kiri.art/t/running-on-runpod-io/102?u=gadicc
for deployment instructions.

# More full examples

Download AnimeAnything v3, from `diffusers` branch / revision on HuggingFace,
which is an `fp16` model, and is already prebuilt on our own S3-storage
in the default location.

```bash
$ ./build.sh -t user/runpod:sd-v2-1-512 \
  --build-arg MODEL_ID="Linaqruf/anything-v3.0" \
  --build-arg MODEL_PRECISION="fp16" \
  --build-arg MODEL_REVISION="diffusers" \
  --build-arg MODEL_URL="s3://"
```