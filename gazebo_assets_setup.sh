#!/bin/sh

# Source Gazebo model path to include this package models
export GAZEBO_MODEL_PATH=$(pwd)/models:$GAZEBO_MODEL_PATH
# export GAZEBO_RESOURCE_PATH=GAZEBO_RESOURCE_PATH:$(pwd)/worlds
