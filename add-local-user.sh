#!/bin/bash
#
# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" != "0" ]]
then
        echo "please run with root user or sudo previledges"
        exit 1
fi

# Get the username (login).
read -p 'Enter the Username to create: ' USERNAME

# Get the user Departmemt (content for description field)
read -p 'Enter the Department of user: ' COMMENT

# Get the Password of the User
read -s -p 'Enter the password to use for the account: ' PASSWORD

# Check if username is already exit
id ${USERNAME} &> /dev/null

if [[ $? = 0 ]]
then
        echo -e "username is already exist ! \nPlease try with different username."
        exit 1
fi

# Create user
useradd -c "${COMMENT}" -m ${USERNAME}

# Set the One time Password
echo ${PASSWORD} | passwd --stdin ${USERNAME}  &> /dev/null

# Force Password to change after first login
passwd -e ${USERNAME}  &> /dev/null


# Display the username, password, hostname where the user was created

echo -e "\n----------------\nUsername: ${USERNAME} \nPassword: ${PASSWORD} \nHostname: ${HOSTNAME}"
exit 0

