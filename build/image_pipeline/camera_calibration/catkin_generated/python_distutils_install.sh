#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ajackow/catkin_ws/src/image_pipeline/camera_calibration"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ajackow/catkin_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ajackow/catkin_ws/install/lib/python3/dist-packages:/home/ajackow/catkin_ws/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ajackow/catkin_ws/build" \
    "/home/ajackow/anaconda3/bin/python" \
    "/home/ajackow/catkin_ws/src/image_pipeline/camera_calibration/setup.py" \
    build --build-base "/home/ajackow/catkin_ws/build/image_pipeline/camera_calibration" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/ajackow/catkin_ws/install" --install-scripts="/home/ajackow/catkin_ws/install/bin"
