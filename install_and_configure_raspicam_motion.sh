#!/bin/sh

# INSTALL MOTION

if [ "$(dpkg -l | grep motion | head -c2)" != "ii" ]
then
    echo "Installing motion..."
    aptitude update
    aptitude install motion
fi

# CONFIGURE MOTION

# Allow the daemon to start automatically
cat > /etc/default/motion << EOF
# set to 'yes' to enable the motion daemon, 'no' to disable it.
start_motion_daemon=yes
EOF

# Configure Motion
cp /etc/motion/motion.conf /etc/motion/motion.conf.bak

sed -i "s/^daemon off$/daemon on/" /etc/motion/motion.conf
sed -i "s/^webcam_localhost on$/webcam_localhost off/" /etc/motion/motion.conf
sed -i "s/^webcam_quality 50$/webcam_quality 90/" /etc/motion/motion.conf
# Webcam Logitech C525
sed -i "s/^width 320$/width 1280/" /etc/motion/motion.conf
sed -i "s/^height 240$/height 720/" /etc/motion/motion.conf
# Disable saving files
sed -i "s/^output_normal on$/output_normal off/" /etc/motion/motion.conf
sed -i "s/^ffmpeg_cap_new on$/ffmpeg_cap_new off/" /etc/motion/motion.conf

# Start the motion software
service motion start

echo "DON'T FORGET TO CONFIGURE THE NETWORK AND IPTABLES."

# TODO
# rem: serveur -> base commune + script dédié comme celui là
# ip fixe -> 192.168.1.150
# iptables
