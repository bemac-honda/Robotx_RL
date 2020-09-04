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

echo_and_run cd "/home/tomoya/robotx_ws/src/spawn_robot_tools/spawn_robot_tools_pkg"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/tomoya/robotx_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/tomoya/robotx_ws/install/lib/python3/dist-packages:/home/tomoya/robotx_ws/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/tomoya/robotx_ws/build" \
    "/home/tomoya/python3_ws/py3venv/bin/python" \
    "/home/tomoya/robotx_ws/src/spawn_robot_tools/spawn_robot_tools_pkg/setup.py" \
    build --build-base "/home/tomoya/robotx_ws/build/spawn_robot_tools/spawn_robot_tools_pkg" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/tomoya/robotx_ws/install" --install-scripts="/home/tomoya/robotx_ws/install/bin"
