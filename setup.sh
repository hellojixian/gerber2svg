#!/bin/bash
sudo unlink /usr/local/bin/gerber2svg
sudo ln -s "$(realpath ./gerber2svg.sh)" /usr/local/bin/gerber2svg
