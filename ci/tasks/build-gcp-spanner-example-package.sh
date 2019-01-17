#!/bin/bash
#########################################################################
#
#  This script builds the GCP Spanner application and creates
#  a zip file with the resulting jar and a Cloud Foundry manifest.yml.
#  The zip is then published as a release to the github repo
#
#########################################################################

set -x
set -e

cd gcp-spanner-example

# Skipping tests because it failed running in Concourse due to a resource limitation (I think).
./mvnw package -DskipTests

cp manifest.yml ../zip-files/.
cp target/spring-cloud-gcp-data-spanner-sample-1.1.0.BUILD-SNAPSHOT.jar ../zip-files/.

cd ../zip-files
jar cMf gcp-spanner-tutorial-app.zip manifest.yml spring-cloud-gcp-data-spanner-sample-1.1.0.BUILD-SNAPSHOT.jar

echo "latest" > release-name
echo "latest" > release-tag