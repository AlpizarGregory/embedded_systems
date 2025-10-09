## Instructions for installing the Yocto image on the Raspberry Pi 4 

1. Inside the path "/poky-scarthgap-5.0.10/test_build/build/conf" is the "local.conf" file, which is responsible for installing any dependency that the Yocto image we will use might need. The main lines that must be added for the correct creation of the image are shown below:
```
MACHINE ?= "raspberrypi4-64" # Hardware where the image will be placed

ENABLE_UART = "1" # To enable serial communication with GPIO pins
ENABLE_DT_OVERLAYS = "1" # Enables device tree overlays
APPEND_CMDLINE = 'gpio.sysfs_enabled=1' # Allows the use of sysfs, which is obsolete in current Yocto images

CORE_IMAGE_EXTRA_INSTALL += " rpi-gpio" # Installs what is necessary for GPIO control
EXTRA_IMAGE_FEATURES += "ssh-server-openssh debug-tweaks" # Enables ssh

RPI_EXTRA_CONFIG = "\ # Enables the pwm channels of the raspberrypi
    dtoverlay=pwm \
    dtoverlay=pwm-2chan \
    dtparam=pwm=on\
"

RPI_KERNEL_DEVICETREE_OVERLAYS = "overlays/pwm.dtbo overlays/pwm-2chan.dtbo" # Adds the DTOs

MACHINE_FEATURES:append = " pwm vc4graphics" # Both lines related to the configuration and initialization of PWM channels
KERNEL_MODULE_AUTOLOAD += "pwm-bcm2835"

PREFERRED_PROVIDER_virtual/dhcp-client = "dhcpcd" # dhcpcd client necessary for WIFI connection via wpa_supplicant

IMAGE_INSTALL:append = " \ # Kernel modules needed for the image
    openssl \
    wpa-supplicant \
    openssh \
    openssh-sftp-server \
    dhcpcd \
    networkmanager \
    linux-firmware-bcm43455 \
    kernel-modules \
"

SRC_URI:append:pn-linux-raspberrypi = " file://sysfs.cfg" # Important, calls the sysfs configuration file, created manually
```
2. Now we proceed to check that the "bblayers.conf" file, located in the same directory as "local.conf", has what is necessary. A list of the required dependencies is as follows:
```
BBLAYERS ?= " \
  /home/myuser/poky-scarthgap-5.0.10/meta \
  /home/myuser/poky-scarthgap-5.0.10/meta-poky \
  /home/myuser/poky-scarthgap-5.0.10/meta-yocto-bsp \
  /home/myuser/poky-scarthgap-5.0.10/sources/meta-raspberrypi \
  /home/myuser/poky-scarthgap-5.0.10/sources/meta-openembedded/meta-oe \
  /home/myuser/poky-scarthgap-5.0.10/sources/meta-openembedded/meta-python \
  /home/myuser/poky-scarthgap-5.0.10/sources/meta-openembedded/meta-networking \
  /home/myuser/poky-scarthgap-5.0.10/sources/meta-openembedded/meta-multimedia \
  /home/myuser/poky-scarthgap-5.0.10/sources/meta-local \
  /home/myuser/poky-scarthgap-5.0.10/meta-mi-proyecto \
  "
  ```
Note: The dependencies must be cloned from GitHub, you must ensure that the paths reflected above match the location where you decide to clone the dependencies. If you wish to change the location of any dependency, you must edit the lines above so that the path matches.

3. For sysfs specifically, we must create the configuration file. To do this, in the path "/poky-scarthgap-5.0.10/test_build/build/conf" we will create the directory called "files", and inside it, the file named "sysfs.cfg" (you can create it using "nano sysfs.cfg").

4. Inside the "sysfs.cfg" file, place the line "CONFIG_GPIO_SYSFS=y" and save the file.

5. Once everything is configured, go to the path "/poky-scarthgap-5.0.10/test_build/" and execute the command "source ../oe-init-build-env", then, execute "bitbake core-image-minimal" to create the image (This process can take 1 to 4 hours and is highly computationally demanding, so it is recommended to close any running processes or programs).

6. Once the image has been created, it must be placed on the Raspberry. To do this, place the Raspberry's SD card in an adapter and connect it to your computer. Make sure beforehand that it is clean and does not have any previous image already loaded.

7. Run the command "sudo fdisk -l /dev/sde" to make sure that the "sde" disk is indeed the SD card. If it is not, find the SD card's identifier before continuing.

8. Navigate to the following path "/poky-scarthgap-5.0.10/test_build/build/tmp/deploy/images/raspberrypi4-64" and run the "ls" command.

9. Look for the file ending in ".wic.bz2", which has a format like this: "core-image-minimal-raspberrypi4-64.rootfs-20251007014732.wic.bz2" and is highlighted in red in some consoles. Copy the full name of the file including its extensions.

10. To flash the image onto the Raspberry, use the command with the following format: "sudo bmaptool copy core-image-minimal-raspberrypi4-64.rootfs-20251007014732.wic.bz2 /dev/sde". The example assumes that the USB with the Raspberry's SD card has the identifier "sde"; if that is not the case for you, then you must change the identifier to the corresponding one. Pay attention that in this command, you must paste the name copied in step 9.

11. Once the process is complete, the image has been successfully mounted on the card. Then place the SD card in the corresponding port on the Raspberry. The image starts automatically when the Raspberry is powered on; it does not require manual installation.

## To install the Wi-Fi Daemon on the Raspberry

1. To access the Raspberry without a Wi-Fi connection, you must use an Ethernet cable. By using nmap on the IP address you are connected to, you can find the IP of the Raspberry. Example of an nmap scan: "nmap -sn 192.168.X.0/24" (illustrative IP), the last number of the IP must be set to zero. The Raspberry's IP is usually labeled as "raspberry pi 4" or similar. If it is not, you can try the IP addresses that appear in the nmap scan one by one (excluding your own) with the command "ssh root@<ip_to_test>". When you find the correct one, the Raspberry will ask if you want to create a fingerprint for your computer at that IP; answer "yes" and you will enter the Raspberry.

2. Once inside the Raspberry, we must configure the Wi-Fi daemon. To do this, first use the following command: "mkdir -p /etc/wpa_supplicant" which will create the directory we will use to configure wpa_supplicant.

3. Create the wpa_supplicant.conf file where you will define which network you want to connect to. This is achieved with the command:
```
cat > /etc/wpa_supplicant/wpa_supplicant.conf <<'EOF'
ctrl_interface=/run/wpa_supplicant
ctrl_interface_group=0
update_config=1

network={
  ssid="Your_Wifi_Name"
  psk="Wifi_Password"
  key_mgmt=WPA-PSK
}
EOF
```
4. Grant permissions to the file with the command: "chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf"

5. To create the startup script, use the command "which udhcpc" to identify the location of the DHCP client. Remember the location it returns.

6. Create the file for the script: touch /etc/init.d/wifi-connect

7. Now edit it with the command: "vi /etc/init.d/wifi-connect" (In vi, to edit you must press the "i" key. Once editing is finished, press the "ESC" key to exit editing mode and then type ":wq" followed by the "ENTER" key to save and exit).

8. In edit mode, add this content (pay attention to the code comments):
```
#!/bin/sh

### BEGIN INIT INFO
# Provides:          wifi-connect
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start WiFi connection at boot
### END INIT INFO

start() {
    echo "Starting Wi-Fi connection..."
    /usr/sbin/wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf -D nl80211,wext
    sleep 2
    
    /sbin/udhcpc -i wlan0 -q -t 5 -T 3 #IMPORTANT, you must use the address from step 5 here instead of "/sbin/udhcpc"
}

stop() {
    echo "Stopping Wi-Fi connection..."
    killall wpa_supplicant
    killall udhcpc
    /usr/sbin/ip addr flush dev wlan0 #IMPORTANT, here instead of "/usr/sbin/ip" use the same path where "udhcpc" is located or locate the correct one with "which ip"
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac

exit 0
```
9. Exit edit mode as explained in step 7.

10. Make the script executable with the command: "chmod +x /etc/init.d/wifi-connect"

11. Enable it as a startup service with the command: "update-rc.d wifi-connect defaults"

12. Start the Daemon with the command "/etc/init.d/wifi-connect start"

13. Check if it returns an IP: "ip addr show wlan0"

14. Test the connection with the command: "ping -c 3 8.8.8.8"

15. With step 13 you can get the IP address assigned to the Raspberry's Wi-Fi service and it can be used to connect remotely to the Raspberry with the command "ssh root@<assigned_ip>"


## To add the GPIO control library into the Raspberrypi 4

1. To cross-compile the library, navigate to the "library" folder and execute the following command: "./scripts/build.sh"

2. To connect to the raspberry, use the command: "ssh root@<assigned_ip>"

3. Inside the raspberry, create the directory where the library will go with the command: "mkdir -p /usr/local/bin/"

4. Add the missing PWM configuration with the command: "echo "dtoverlay=pwm-2chan" >> /boot/config.txt"

5. Exit the raspberry with the "exit" command.

6. To transfer the library to the raspberry, from the library folder, enter this command in the terminal: "scp car_control root@<assigned_ip>:/usr/local/bin/"

7. To test parts of the library from the raspberry, use the command: "/usr/local/bin/car_control light left 30" (the "light left 30" part of the command consists of three components: action (which can be light for the lights or move for the motors), direction (4 possible: front, rear, left, right), and speed (from 0 to 100 for the PWM but it only applies to the "move" command; the light command ignores it, but it is still necessary to add it)).

8. Alternatively, you can test the command from the computer by typing the command "ssh root@<assigned_ip> "/usr/local/bin/car_control light left 30"" in the terminal (Note that the part of the command that corresponds to what would normally be typed inside the raspberry is enclosed in quotes).

## To install and configure the Backend

1. Make sure Node.js (v18 or higher) and npm are installed on your system.
You can check this by running:
```bash
node -v
npm -v
```

2. Inside the repository folder, navigate to the backend directory:
```bash
cd backend
```

3. Install all dependencies defined in package.json using npm:
```bash
npm install
```

4. Open the file server.js. Inside it, you will find the SSH configuration that connects to the Raspberry Pi.
Example:
```
await ssh.connect({
  host: "192.168.7.5",      // Raspberry Pi IP
  username: "root",
  password: "1324"          // Default password (change if necessary)
});
```

5. You can test the SSH connection manually before running the server to verify the command works correctly:
```bash
ssh root@192.168.7.5 "/usr/local/bin/car_control move front 50"
```

6. If the command executes without errors, the Raspberry Pi and backend connection are correctly configured. To start the backend server, run:
```bash
node server.js
```

7. By default, it runs on port 3000, but this can be changed inside server.js.
Once started, the backend will be ready to receive requests from the frontend.
It will handle the commands and send them to the Raspberry Pi via SSH.


## To install and configure the Frontend

1. Make sure you have Node.js and npm installed (as done previously).


2. Navigate to the frontend directory:
```bash
cd frontend
```

3. Install the dependencies:
```bash

npm install
```

4. Check the configuration file where the backend URL is defined (for example, inside .env or directly in the code):
```bash

VITE_API_URL=http://localhost:3000
```

5. If the backend is running on a different machine, replace localhost with the IP address of the server running the backend.

6. Start the development server with:
```bash

npm run dev
```

7. The console will show a message like:
```bash

Local: http://localhost:5173/
Network: http://<your_ip>:5173/
```

8. Open the displayed URL in your browser to access the control interface of the car.
Through this interface, you can select the type of command, direction, and speed.
Each command is sent to the backend, which communicates with the Raspberry Pi via SSH.


## To configure the Camera Stream using Motion

1. Install motion on the machine where the backend is running (not on the Raspberry Pi):
```bash
sudo apt update
sudo apt install motion -y
```

2. Verify that your webcam is detected by the system using:
```bash
ls /dev/video*
```
Typically, it will show something like /dev/video0.


3. Edit the Motion configuration file:
```bash
sudo nano /etc/motion/motion.conf
```

4. Make sure to set the following parameters:
```
daemon on
stream_localhost off
framerate 30
width 640
height 480
video_device /dev/video0
stream_port 8081
output_pictures off
ffmpeg_output_movies off
```

5. Enable and start the motion service:
```bash

sudo systemctl enable motion
sudo systemctl start motion
```

6. To verify that the camera stream is working, open a browser and go to:
```bash

http://<your_server_ip>:8081
```

7. You should see the live video feed from the connected camera.

The frontend can embed this stream using an <img> or <iframe> tag pointing to the same URL, allowing real-time video feedback of the car.



