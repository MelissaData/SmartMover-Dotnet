#!/bin/bash

# Builds and runs the Melissa Smart Mover Cloud API .NET sample.
#
# This script builds SmartMoverDotnet with dotnet publish, then runs the resulting
# executable, passing along the license and (if supplied) the lookup fields.
#
# Overall flow:
#   1. Parse the command-line options below.
#   2. Resolve the license (--license, then a prompt, then the MD_LICENSE environment variable).
#   3. Publish SmartMoverDotnet in Release configuration to ./SmartMoverDotnet/Build.
#   4. Run the built executable: one-shot mode if any lookup field was supplied,
#      otherwise interactive mode (the .NET program prompts for each field).
#
# Options (each takes a value):
#   --pafid          PAF ID to send with the request.
#   --company        Company name to test.
#   --fullname       Full name to test.
#   --addressline1   Street address to test.
#   --city           City to test.
#   --state          State to test.
#   --postalcode     Postal code to test.
#   --country        Country to test.
#   --license        License string. If omitted, the script prompts for it; if the prompt
#                    is left blank, it falls back to MD_LICENSE. Running without --license
#                    always prompts, even when MD_LICENSE is set.
#
# Paths are relative to the current directory, so run the script from its own folder.
#
# Examples:
#   ./SmartMoverDotnet.sh --license "your-license"
#   ./SmartMoverDotnet.sh --pafid "your-pafid" --company "Melissa" --addressline1 "22382 Avenida Empresa" --fullname "Ray Melissa" --city "Rancho Santa Margarita" --state "CA" --postalcode "92688" --country "US" --license "your-license"

######################### Constants ##########################

RED='\033[0;31m' #RED
NC='\033[0m' # No Color

######################### Parameters ##########################

pafid=""
company=""
fullname=""
addressline1=""
city=""
state=""
postalcode=""
country=""
license=""

# Read each --flag and its value. A flag with no value, or whose value starts with "-"
# (such as another option), is an error. Unrecognized options are ignored.
while [ $# -gt 0 ] ; do
  case $1 in
    --pafid)  
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'pafid\'.${NC}\n"  
            exit 1
        fi 

        pafid="$2"
        shift
        ;;

    --company)  
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'company\'.${NC}\n"  
            exit 1
        fi 

        company="$2"
        shift
        ;;

    --fullname)  
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'fullname\'.${NC}\n"  
            exit 1
        fi 

        fullname="$2"
        shift
        ;;

    --addressline1) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'addressline1\'.${NC}\n"  
            exit 1
        fi 

        addressline1="$2"
        shift
        ;;
    --city)  
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'city\'.${NC}\n"  
            exit 1
        fi 

        city="$2"
        shift
        ;;
    --state) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'state\'.${NC}\n"  
            exit 1
        fi 

        state="$2"
        shift
        ;;
    --postalcode)         
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'postalcode\'.${NC}\n"  
            exit 1
        fi 
        
        postalcode="$2"
        shift
        ;;
    --country) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'country\'.${NC}\n"  
            exit 1
        fi 

        country="$2"
        shift
        ;;
    --license) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'license\'.${NC}\n"  
            exit 1
        fi 

        license="$2"
        shift 
        ;;
  esac
  shift
done

# Build paths are relative to the current directory (not the script's location)
CurrentPath="$(pwd)"
ProjectPath="$CurrentPath/SmartMoverDotnet"
BuildPath="$ProjectPath/Build"

if [ ! -d "$BuildPath" ];
then
    mkdir "$BuildPath"
fi

########################## Main ############################
printf "\n===================== Melissa Smart Mover Cloud API ========================\n"

# Get license (either from parameters or user input)
if [ -z "$license" ];
then
  printf "Please enter your license string: "
  read license
fi

# Check for License from Environment Variables 
if [ -z "$license" ];
then
  license=`echo $MD_LICENSE` 
fi

if [ -z "$license" ];
then
  printf "\nLicense String is invalid!\n"
  exit 1
fi

# Start program
# Build project
printf "\n=============================== BUILD PROJECT ==============================\n"

dotnet publish -f="net7.0" -c Release -o "$BuildPath" SmartMoverDotnet/SmartMoverDotnet.csproj

# Run project
# No lookup fields supplied -> run interactively; otherwise pass them through for one-shot mode.
# Bash passes empty quoted values as real empty arguments, so unsupplied fields arrive
# empty and the program prompts for them.
if [ -z "$pafid" ] && [ -z "$company" ] && [ -z "$fullname" ] && [ -z "$addressline1" ] && [ -z "$city" ] && [ -z "$state" ] && [ -z "$postalcode" ] && [ -z "$country" ];
then
    dotnet "$BuildPath"/SmartMoverDotnet.dll --license "$license"
else
    dotnet "$BuildPath"/SmartMoverDotnet.dll --license "$license" --pafid "$pafid" --company "$company" --fullname "$fullname" --addressline1 "$addressline1" --city "$city" --state "$state" --postalcode "$postalcode" --country "$country"
fi


