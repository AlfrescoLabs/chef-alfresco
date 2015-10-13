#!/bin/bash
# Script for releasing a tar.gz berkshelf artifact into Alfresco Nexus Internal

function buildArtifact () {
  /opt/chefdk/embedded/bin/rake
}

function getCurrentVersion () {
  version=`cat metadata.rb| grep version|awk '{print $2}' | tr -d \"`
  echo $version
}

function getIncrementedVersion () {
  version=$(getCurrentVersion)
  echo $version | awk -F'[.]' '{print $1 "." $2 "." $3+1}'
}

function incrementVersion () {
  export currentVersion=$(getCurrentVersion)
  export nextVersion=$(getIncrementedVersion)

  sed "s/$currentVersion/$nextVersion/" metadata.rb > metadata.rb.tmp
  rm -f metadata.rb
  mv metadata.rb.tmp metadata.rb
}

function deploy () {
  repo_name="releases"
  if [[ $1 == *SNAPSHOT ]]; then
    repo_name="snapshots"
  fi

  mvn deploy:deploy-file -Dfile=$(echo *.tar.gz) -DrepositoryId=alfresco-internal -Durl=https://artifacts.alfresco.com/nexus/content/repositories/$repo_name -DgroupId=org.alfresco.devops -DartifactId=chef-alfresco -Dversion=$1 -Dpackaging=tar.gz
}

function deploySnapshot () {
  buildArtifact
  current_version=$(getCurrentVersion)
  deploy "$current_version-SNAPSHOT"
}

function release () {
  buildArtifact
  deploy $(getCurrentVersion)
  incrementVersion
}

# Done by Bamboo
# export HOME=/tmp
export PATH=/opt/chefdk/embedded/bin/:$PATH
export PATH=/opt/apache-maven/bin:$PATH

MODE=$1

if [ "$MODE" == "snapshot" ]; then
  deploySnapshot
elif [ "$MODE" == "nextversion" ]; then
  getIncrementedVersion
elif [ "$MODE" == "thisversion" ]; then
  getCurrentVersion
else
  release
fi
