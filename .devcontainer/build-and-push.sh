cd /workspaces/opentelemetry-collector-contrib

mkdir bin/ dist/

# Install dependencies - takes a while! Run if things start to cry about Go modules
# make -j2 gomoddownload
# Install Tools
make install-tools
# https://opentelemetry.uptrace.dev/guide/collector.html#compiling-from-sources
make otelcontribcol

chmod +x bin/*
chmod -R +x ./dist

# Login to docker with access token
docker login --username=mdrrakiburrahman --password=$DOCKERHUB_TOKEN

# Build docker image
make docker-otelcontribcol

# Tag and push
docker tag otelcontribcol:latest mdrrakiburrahman/opentelemetry-collector-contrib-dev:latest
docker push mdrrakiburrahman/opentelemetry-collector-contrib-dev:latest
# https://hub.docker.com/repository/docker/mdrrakiburrahman/opentelemetry-collector-contrib-dev