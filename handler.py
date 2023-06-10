#!/usr/bin/env python

import runpod
import app as user_src
import traceback
import json
import asyncio
import nest_asyncio

nest_asyncio.apply()

## Load models into VRAM here so they can be warm between requests
user_src.init()


def handler(job):
    """
    This is the handler function that will be called by the serverless.
    """
    print(type(job))
    print(job)

    # do the things
    inputs = job["input"]
    print(type(inputs))
    print(inputs)
    input = json.loads(json.dumps(inputs))
    print(type(inputs))
    print(inputs)

    loop = asyncio.get_event_loop()

    try:
        output = loop.run_until_complete(user_src.inference(input, None))
    except Exception as err:
        output = {
            "$error": {
                "code": "APP_HANDLER_ERROR",
                "name": type(err).__name__,
                "message": str(err),
                "stack": traceback.format_exc(),
            }
        }

    return output

    # return the output that you want to be returned like pre-signed URLs to output artifacts
    # return "Hello World"


runpod.serverless.start({"handler": handler})
