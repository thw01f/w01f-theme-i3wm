#!/bin/bash
read -r _ total _ < <(grep MemTotal /proc/meminfo)
read -r _ available _ < <(grep MemAvailable /proc/meminfo)
used=$((total - available))
percent=$((used * 100 / total))
echo "$percent%"
