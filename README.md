# Melissa - Smart Mover Cloud API Dotnet

## Purpose
This code showcases the Melissa Smart Mover Cloud API using C#.

Please feel free to copy or embed this code to your own project. Happy coding!

For the latest Melissa Smart Mover release notes, please visit: https://releasenotes.melissa.com/cloud-api/smartmover/

For further documentation, please visit: https://www.melissa.com/quickstart-guides/smartmover

The console will ask the user for:

- Pafid
- Company
- Fullname
- AddressLine1
- City
- State
- PostalCode
- Country

And return information of the address such as:

- CASSReportLink
- NCOAReportLink
- Records
- AddressExtras
- AddressKey
- AddressLine1
- AddressLine2
- AddressTypeCode
- BaseMelissaAddressKey
- CarrierRoute
- City
- CityAbbreviation
- CompanyName
- CountryCode
- CountryName
- DeliveryIndicator
- DeliveryPointCheckDigit
- DeliveryPointCode
- MelissaAddressKey
- MoveEffectiveDate
- MoveTypeCode
- PostalCode
- RecordID
- Results
- State
- StateName
- Urbanization
- TotalRecords
- TransmissionReference
- TransmissionResults
- Version

## Tested Environments
- Windows 10 64-bit .NET 7.0, Powershell 5.1
- Ubuntu Linux 20.04.04 LTS 64-bit .NET 7.0
- Smart Mover Cloud API Version 8.4.1.4214

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Download this project
```
$ git clone https://github.com/MelissaData/SmartMover-Dotnet
$ cd SmartMover-Dotnet
```

## Windows

#### Install the Dotnet Core SDK
Before starting, make sure that the .NET 7.0 SDK has been correctly installed on your machine (If you have Visual Studio installed, you most likely have it already). If you are unsure, you can check by opening a command prompt window and typing the following:

`dotnet --list-sdks`

If the .NET 7.0 SDK is already installed, you should see it in the following list:

![alt text](/screenshots/dotnet_output.png)

As long as the above list contains version `7.0.xxx` (underlined in red), then you can skip to the next step. If your list does not contain version 7.0, or you get any kind of error message, then you will need to download and install the .NET 7.0 SDK from the Microsoft website.

To download, follow this link: https://dotnet.microsoft.com/en-us/download/dotnet

Select `.NET 7.0` and you will be navigated to the download page.

Click and download the `x64` SDK installer for your operating system.

(IMPORTANT: Make sure you download the SDK, NOT the runtime. the SDK contains both the runtime as well as the tools needed to build the project.)

![alt text](/screenshots/net7.png)

Once clicked, your web browser will begin downloading an installer for the SDK. Run the installer and follow all of the prompts to complete the installation (your computer may ask you to restart before you can continue). Once all of that is done, you should be able to verify that the SDK is installed with the `dotnet --list-sdks` command.

#### Run Powershell Script
Parameters:
- -pafid: an input pafid
- -company: an input company name
- -fullname: an input full name
- -addressline1: an input addressline1
- -city: an input city
- -state: an input state
- -postalcode: an input postal code
- -country: an input country

  This is convenient when you want to get results for a specific request in one run instead of testing multiple records in interactive mode.  

- -license (optional): a license string to test the Cloud API

There are two modes:

- Interactive 

	The script will prompt the user for input(s), then use the provided input(s) to call the Cloud API. For example:
	```
	$ .\SmartMoverDotnet.ps1
	```

- Command Line 
	
	You will neeed to pass in an address and name that has a move to display a successful response.

	You can pass a pafid, company, fullname, addressline1, city, state, postal code, country and a license string into `-pafid`, `-company`, `-fullname`, `-addressline1`, `-city`, `-state`, `-postalcode`, `-country` and `-license` parameters respectively to test the Cloud API. For example:
	```
    $ .\SmartMoverDotnet.ps1 -pafid "<pafid>" -company "Melissa" -fullname "Ray Melissa" -addressline1 "22382 Avenida Empresa" -city "Rancho Santa Margarita" -state "CA" -postalcode "92688" -country "US" -license "<your_license_string>"
    $ .\SmartMoverDotnet.ps1 -license "<your_license_string>"
    ```

This is the sample output from a successful setup for interactive mode:

![alt text](/screenshots/output.png)

## Linux

#### Install the Dotnet Core SDK
Before starting, check to see if you already have the .NET 7.0 SDK already installed by entering this command:

`dotnet --list-sdks`

If the .NET 7.0 SDK is already installed, you should see it in the following list:

![alt text](/screenshots/dotnet_output2.png)

As long as the above list contains version `7.0.xxx` (underlined in red), then you can skip to the next step. If your list does not contain version 7.0, or you get any kind of error message, then you will need to download and install the .NET 7.0 SDK.

To download, run the following commands to add the Microsoft package signing key to your list of trusted keys and add the package repository.

```
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
```

Next, you can now run this command to install the .NET 7.0 SDK:

```
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-7.0
```

Once all of this is done, you should be able to verify that the SDK is installed with the `dotnet --list-sdks` command.

#### Run Bash Script
Parameters:
- --pafid: an input pafid
- --company: an input company name
- --fullname: an input fullname
- --addressline1: an input addressline1
- --city: an input city
- --state: an input state
- --postalcode: an input postal code
- --country: an input country

  This is convenient when you want to get results for a specific request in one run instead of testing multiple records in interactive mode.    

- --license (optional): a license string to test the Cloud API

There are two modes:

- Interactive 

	The script will prompt the user for input(s), then use the provided input(s) to call the Cloud API. For example:
	```
	$ ./SmartMoverDotnet.sh
	```

- Command Line 

	You will neeed to pass in an address and name that has a move to display a successful response.

	You can pass a pafid, company, full name, address line 1, city, state, postal code, country, and a license string into `--pafid`, `--company`, `--fullname`, `--addressline1`, `--city`, `--state`, `--postal`, `--country` and `--license` parameters respectively to test the Cloud API. For example:
	```
    $ ./SmartMoverDotnet.sh --pafid "<pafid>" --company "Melissa" --addressline1 "22382 Avenida Empresa" --fullname "Ray Melissa" --city "Rancho Santa Margita" --state "CA" --postalcode "92688" --country "US" --license "<your_license_string>"
    $ ./SmartMoverDotnet.sh --license "<your_license_string>"
    ```

This is the sample output from a successful setup for interactive mode:

![alt text](/screenshots/output2.png)

## Result Codes
For details about the result codes please refer to https://wiki.melissadata.com/index.php?title=Result_Code_Details#SmartMover_V3

## Contact Us
For free technical support, please call us at 800-MELISSA ext. 4 (800-635-4772 ext. 4) or email us at tech@melissa.com.

To purchase this product, contact the Melissa sales department at 800-MELISSA ext. 3 (800-635-4772 ext. 3).
