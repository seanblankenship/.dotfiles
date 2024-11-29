#!/bin/bash   

HTDOCS="/Applications/MAMP/htdocs/_sites"
echo "Setting up a new project."
read -p "Enter the domain name of your project (ie domain.com): " folder
if [ -d $folder ]; then
    echo "$folder already exists. Exiting."
    exit
fi
read -p "Would you like to fill out some details? y or n " details
if [ "$details" = "y" ]; then
    read -p "Company Name: " company
    read -p "Address Line 1: " add1
    read -p "Address Line 2: " add2
    read -p "City: " city
    read -p "State (ie NC or SC): " state
    read -p "Zip: " zip
    read -p "Local Phone: " plocal
    read -p "Toll Free Phone: " ptollfree
    read -p "Fax: " pfax
fi
echo "Creating $HTDOCS/$folder"
git clone git@github.com:seanblankenship/appnet-bp.git
mv appnet-bp $HTDOCS/$folder
if [ "$details" = "y" ]; then
    echo "Modifying _config.php..."
    echo "Updating myDomain..."
    sed "s/something.com/$folder/g" $HTDOCS/$folder/_config.php > $HTDOCS/$folder/_config.new && mv $HTDOCS/$folder/_config.new $HTDOCS/$folder/_config.php
    echo "Updating myCompany..."
    sed "s/COMPANY NAME/$company/g" $HTDOCS/$folder/_config.php > $HTDOCS/$folder/_config.new && mv $HTDOCS/$folder/_config.new $HTDOCS/$folder/_config.php
    echo "Updating myAddressOne..."
    sed "s/ADDRESS ONE/$add1/g" $HTDOCS/$folder/_config.php > $HTDOCS/$folder/_config.new && mv $HTDOCS/$folder/_config.new $HTDOCS/$folder/_config.php
    echo "Updating myAddressTwo..."
    sed "s/ADDRESS TWO/$add2/g" $HTDOCS/$folder/_config.php > $HTDOCS/$folder/_config.new && mv $HTDOCS/$folder/_config.new $HTDOCS/$folder/_config.php
    echo "Updating myCity..."
    sed "s/CITY/$city/g" $HTDOCS/$folder/_config.php > $HTDOCS/$folder/_config.new && mv $HTDOCS/$folder/_config.new $HTDOCS/$folder/_config.php
    echo "Updating myState..."
    sed "s/STATE/$state/g" $HTDOCS/$folder/_config.php > $HTDOCS/$folder/_config.new && mv $HTDOCS/$folder/_config.new $HTDOCS/$folder/_config.php
    echo "Updating myZip..."
    sed "s/ZIP/$zip/g" $HTDOCS/$folder/_config.php > $HTDOCS/$folder/_config.new && mv $HTDOCS/$folder/_config.new $HTDOCS/$folder/_config.php
    echo "Updating myPhoneLocal..."
    sed "s/555-555-5555/$plocal/g" $HTDOCS/$folder/_config.php > $HTDOCS/$folder/_config.new && mv $HTDOCS/$folder/_config.new $HTDOCS/$folder/_config.php
    echo "Updating myPhoneTollFree..."
    sed "s/444-444-4444/$ptollfree/g" $HTDOCS/$folder/_config.php > $HTDOCS/$folder/_config.new && mv $HTDOCS/$folder/_config.new $HTDOCS/$folder/_config.php
    echo "Updating myFax..."
    sed "s/333-333-3333/$pfax/g" $HTDOCS/$folder/_config.php > $HTDOCS/$folder/_config.new && mv $HTDOCS/$folder/_config.new $HTDOCS/$folder/_config.php
fi
echo "Finished."
