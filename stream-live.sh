#!/bin/bash

#set -e  # Uncomment this to exit on any error (optional)

# Trap to handle keyboard interruption and ensure clean exit
trap 'echo "Keyboard interrupt detected. Exiting..."; clean_up; exit' INT

# Function to clean up any leftover processes
clean_up() {
    echo "Cleaning up..."
    # Kill any remaining instances of video-viewer if still running
    pkill -f video-viewer
}

# Monitor memory usage
log_memory_usage() {
    echo "Memory usage before restart:" >> memory_log.txt
    free -h >> memory_log.txt
    echo "-----------------------------------" >> memory_log.txt
}

# Main loop to continuously restart video-viewer
while true; do
    # Clean up any previous processes
    clean_up

    # Log memory usage before starting
    log_memory_usage

    # Navigate to the directory where the video-viewer is located
    cd ~/vtt/jetson-inference/build/aarch64/bin

    # Run the video-viewer with no display, forward the stream, and handle errors
    ./video-viewer rtsp://192.168.144.108:554/live rtsp://192.168.192.100:8554/live || 
    #video-viewer --ssl-key=key.pem --ssl-cert=cert.pem rtsp://192.168.144.108:554/live webrtc://192.168.192.100:8554/live ||
    {
        echo "Error occurred in video-viewer. Restarting..."
    }

    # Wait for a short period before restarting to prevent rapid restarts in case of persistent errors
    echo "Streaming stopped. Restarting in 5 seconds..."
    sleep 5
done


## --no-display

    #video-viewer --ssl-key=key.pem --ssl-cert=cert.pem rtsp://192.168.144.108:554/live webrtc://192.168.192.100:8554/live || true
    #video-viewer rtsp://192.168.0.100:8554/uavcast || true
    #./video-viewer  rtsp://192.168.144.108:554/live --ssl-key=key.pem --ssl-cert=cert.pem webrtc://@:8555/live || true
    
    #./video-viewer --no-display rtsp://192.168.144.108:554/live rtsp://@:8554/live || true
    
    
    #video-viewer --headless rtsp://192.168.192.101:8554/uavcast --ssl-key=key.pem --ssl-cert=cert.pem webrtc://@:8555/output || true
