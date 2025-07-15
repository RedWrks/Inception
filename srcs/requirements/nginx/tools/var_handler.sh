#!/bin/sh

# Start Nginx in the foreground so container does not stop (containers need foreground activity to stay active)
nginx -g "daemon off;"
