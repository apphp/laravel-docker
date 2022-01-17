FROM node:14.18-alpine

# FIX for FATAL ERROR: MarkCompactCollector: young object promotion failed Allocation failed - JavaScript heap out of memory
RUN node --max-old-space-size=2048

WORKDIR /cywapp
