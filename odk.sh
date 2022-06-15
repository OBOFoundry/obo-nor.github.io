#!/bin/sh
# Wrapper script for docker.
#
# This is used primarily for wrapping the GNU Make workflow.
# Instead of typing "make TARGET", type "./run.sh make TARGET".
# This will run the make workflow within a docker container.
#
# The assumption is that you are working in the src/ontology folder;
# we therefore map the whole repo (../..) to a docker volume.
#
# See README-editors.md for more details.
#echo "WARNING USING ODK 1.2.30!"

docker run -e ROBOT_JAVA_ARGS='-Xmx4G' -e JAVA_OPTS='-Xmx4G' \
  -v $PWD/dashboard:/tools/OBO-Dashboard/dashboard \
  -v $PWD/dashboard-config.yml:/tools/OBO-Dashboard/dashboard-config.yml \
  -v $PWD/Makefile:/work/Makefile \
  -v $PWD/ontologies:/tools/OBO-Dashboard/build/ontologies \
  -v $PWD/sparql:/tools/OBO-Dashboard/sparql \
  -w /work --rm -ti obolibrary/odkfull:v1.3.1 "$@"

#echo "WARNING USING ODK 1.2.30!"