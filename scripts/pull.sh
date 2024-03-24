#!/usr/bin/env bash
#
# Created on Wed Oct 25 2023 11:04:19
# Author: Mukai (Tom Notch) Yu
# Email: yumukai@huawei.com, topnotchymk@gmail.com
# Affiliation: HUAWEI Technologies Co. Ltd., Hong Kong Research Center, Design Automation Lab
#
# Copyright Ⓒ 2023 Mukai (Tom Notch) Yu
#

. "$(dirname "$0")"/variables.sh

docker pull "$DOCKER_USER"/"$IMAGE_NAME":"$IMAGE_TAG"
