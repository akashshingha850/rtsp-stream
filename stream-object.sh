#!/bin/bash

#set -e # Exit on error

trap 'echo "Keyboard interrupt detected. Exiting..."; exit' INT

while true; do
    #cd ~/vtt/rtsp-stream/jetson-inference/build/aarch64/bin
    #./detectnet --ssl-key=key.pem --ssl-cert=cert.pem rtsp://192.168.144.108:554/live webrtc://@:8555/object || true
    #video-viewer rtsp://192.168.0.100:8554/uavcast || true
    
	detectnet \
	--output-save=/home/jetson/vtt/media/object_$(date +"%Y%m%d_%H%M%S").mp4 \
	--ssl-key=key.pem --ssl-cert=cert.pem \
	rtsp://192.168.144.108:554/live webrtc://192.168.192.100:8556/output || true
    #./detectnet --ssl-key=key.pem --ssl-cert=cert.pem rtsp://192.168.144.108:554/live webrtc://192.168.192.100:8556/output || true
    
    #detectnet.py rtsp://192.168.192.101:8554/uavcast  --output-save=~/vtt/media/Video_$(date +"%Y%m%d_%H%M%S").mp4
    
    #--input-save=/media/camera_dump.mp4 --output-save=/media/post_dump.mp4 
    echo "Streaming  stopped. Restarting..."
    #exit
done
