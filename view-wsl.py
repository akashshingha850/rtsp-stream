import cv2
import time
import subprocess
# run sudo zerotier-cli join ebe7fbd445e16e8b
#subprocess.run(['sudo', 'zerotier-cli', 'leave', 'ebe7fbd445e16e8b'])
#subprocess.run(['sudo', 'zerotier-cli', 'join', 'ebe7fbd445e16e8b'])

#add some ping to check if the connection is established to 192.168.192.100
subprocess.run(['ping', '-c', '2', '192.168.192.100'])

#run the ssh tunnel to the jetson nano
#subprocess.run(['ssh', '-fN', '-L', '8558:192.168.144.108:554', 'jetson@192.168.192.100'])

# RTSP URL
rtsp_url = 'rtsp://192.168.192.100:8559/live'
retry_delay = 3  # seconds

while True:
    cap = cv2.VideoCapture(rtsp_url)
    if not cap.isOpened():
        print(f"Could not open RTSP stream. Retrying in {retry_delay} seconds...")
        cap.release()
        cv2.destroyAllWindows()
        time.sleep(retry_delay)
        continue

    print("Successfully connected to RTSP stream.")
    
    while True:
        ret, frame = cap.read()
        if not ret:
            print("Error: Failed to read frame from RTSP stream. Retrying...")
            cap.release()
            cv2.destroyAllWindows()
            time.sleep(retry_delay)
            break

        cv2.imshow("RTSP Stream", frame)

        # Press 'q' to exit
        if cv2.waitKey(1) & 0xFF == ord('q'):
            cap.release()
            cv2.destroyAllWindows()
            exit(0)
