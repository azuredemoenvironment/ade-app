#!/usr/bin/env bash

# These are the image sets that will be built, they use a similar format (build-container.tt), but with
# very slight variations. This helps keep the workflows clean and consistent.
dotnetImages=(ade-apigateway ade-dataingestorservice ade-userservice ade-datareporterservice ade-eventingestorservice )
nodeImages=(ade-frontend)
testImages=(ade-loadtesting-gatling ade-loadtesting-redis ade-loadtesting-influxdb ade-loadtesting-grafana)

echo "Creating dotnet Workflows"
for i in ${dotnetImages[@]}; do
    TRIGGER_PATH="src\/ADE.Services\/**"
    sed -e 's/@@IMAGE_NAME@@/'"$i"'/g' -e 's/@@TRIGGER_PATH@@/'"$TRIGGER_PATH"'/g' "build-container.tt" > "build-$i.yml"
done

echo "Creating node Workflows"
for i in ${nodeImages[@]}; do
    TRIGGER_PATH="src\/ADE.FrontEnd\/**"
    sed -e 's/@@IMAGE_NAME@@/'"$i"'/g' -e 's/@@TRIGGER_PATH@@/'"$TRIGGER_PATH"'/g' "build-container.tt" > "build-$i.yml"
done

echo "Creating test suite Workflows"
for i in ${testImages[@]}; do
    TRIGGER_PATH="test\/**"
    sed -e 's/@@IMAGE_NAME@@/'"$i"'/g' -e 's/@@TRIGGER_PATH@@/'"$TRIGGER_PATH"'/g' "build-container.tt" > "build-$i.yml"
done
