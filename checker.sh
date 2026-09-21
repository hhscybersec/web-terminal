#!/bin/bash
TARGET_DIR="/home/user/club"
TARGET_FILE="$TARGET_DIR/password.txt"
# Using /tmp/flag.txt avoids permission issues with background startup daemons
FLAG_FILE="/tmp/flag.txt"
EXPECTED_PASSWORD="Password123!"

# Run a background loop checking for the password file
while true; do
    if [ -f "$TARGET_FILE" ]; then
        # Read the file, strip whitespace/newlines
        USER_PASS=$(cat "$TARGET_FILE" | tr -d '\r\n')
        
        if [ "$USER_PASS" = "$EXPECTED_PASSWORD" ]; then
            if [ ! -f "$FLAG_FILE" ]; then
                echo "U FOUND THE FLAG! CTF{v3rb0s3_w3bvm_m4st3r}" > "$FLAG_FILE"
                echo "[SYSTEM] Correct password detected! flag.txt created in /tmp/"
                
                # Exit the while loop so it stops running in the background
                break
            fi
        fi
    fi
    sleep 2
done