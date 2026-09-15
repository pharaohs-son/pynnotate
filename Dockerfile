FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Argument to build with released versions
# ARG VERSION=v.1.0
ARG BRANCH=main
# Install curl and basic build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates build-essential python3-tk tk && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download source code
RUN curl -sSLf https://github.com/fernandacaron/pynnotate/archive/refs/heads/${BRANCH}.tar.gz \
    | tar -xz --strip-components=1
# Download and extract the repository code for the specific tag 
# RUN curl -sSLf https://github.com/fernandacaron/pynnotate/archive/refs/tags/${VERSION}.tar.gz \
#    | tar -xz --strip-components=1
# Download the missing requirements.txt directly from the latest main branch - missing requirement file in v.1.0
# RUN curl -sSLfO https://raw.githubusercontent.com/fernandacaron/pynnotate/main/requirements.txt

# Upgrade pip and install the newly downloaded requirements file
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Setup data directory for output mapping
RUN mkdir -p /data
WORKDIR /app

