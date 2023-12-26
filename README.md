# PowerShell HTML Explorer
is a tool designed to generate a web-based file explorer from a PowerShell script. This utility creates an HTML page that represents the structure and details of a specified folder, allowing for an easy and interactive way to browse its contents.

## Preview

![98032218-f810e200-1e13-11eb-9198-e356873dc0e7](https://user-images.githubusercontent.com/44686652/98035057-3a3c2280-1e18-11eb-99a6-6e511b0bb4b3.png)

## Prerequisites
🚧 You need to configure the parametre.ini
🚧 You need to Allow execution of PowerShell scripts for that execute powershell on SUPER user on type this:
```powershell
Set-ExecutionPolicy RemoteSigned
```

## Usage
To execute the programme in the powershell is this commande
```
./htmlceation.ps1
```

## Config
Example of the `parametre.ini`
```
[Title]
Name=Title

[Files]
C:\"Your Path"

[Infos]
Name=yes
Date=yes
Taille=yes

[Extensions]
.txt
.jpg
.png

[Exclusions]
All folder you don't want put the path
```
