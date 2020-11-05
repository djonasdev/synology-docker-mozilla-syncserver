#!/bin/sh -e

#Print some Debug
set -x

###################################################
# We'll need binaries from different paths,       #
#  so we should be sure, all bin dir in the PATH  #
###################################################
PATH="${PATH}:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

#######################################################
# Git commit hash / tag from                          #
# https://github.com/mozilla-services/syncserver      #
# which we want to use for our Mozilla Syncserver     #
#######################################################
GIT_COMMIT="1.9.1"

#########################
# Create data directory #
#########################
mkdir -p "/data"

#################################
# Create temp working directory #
#################################
WORK_DIR="/tmp/build"
mkdir -p $WORK_DIR
cd $WORK_DIR

################################
# Install some needed packages #
################################
apk update

###############################################
# Runtime dependencies for Mozilla Syncserver #
###############################################
apk add python py-pip libstdc++ tzdata libffi-dev openssl-dev && pip install --upgrade pip && pip install setuptools

#################################################
# Add build-deps                                #
# I'm creatind variable with them to being able #
#  to delete them back after building           #
#################################################
BUILD_DEP="python-dev make gcc g++ git"
apk add $BUILD_DEP

################################################
# Clone mozilla-syncserv and get needed commit #
################################################
git clone https://github.com/mozilla-services/syncserver.git .
git reset --hard "$GIT_COMMIT"

##############################
# Build and install syncserv #
##############################
echo '#!/bin/sh' > /usr/local/bin/virtualenv
chmod +x /usr/local/bin/virtualenv
mkdir ./local
ln -s /usr/bin ./local/
echo "start build"
make build
rm /usr/local/bin/virtualenv

# StackOverflow-driven development as it is: 
#   http://stackoverflow.com/questions/122327/how-do-i-find-the-location-of-my-python-site-packages-directory
PYTHON_PACKAGES_DIR=`python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`
cp -rf syncserver.egg-info syncserver $PYTHON_PACKAGES_DIR

#########################################
# Delete all unneded files and packages #
#########################################
cd /
apk del --purge $BUILD_DEP
rm /var/cache/apk/*
rm -rf /root/.cache
rm -rf $WORK_DIR

echo "Done!"