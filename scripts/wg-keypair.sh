#!/usr/bin/env bash

filename=$1
[[ -z "$filename" ]] && echo "Required filename" && exit 1

wg genkey | tee ${filename}.private | wg pubkey > ${filename}.public
