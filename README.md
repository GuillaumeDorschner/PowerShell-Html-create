# PowerShell-Html-create
The purpose of this program is to be able to Create a html page of your folder. It's a powershell programme.

🚧 You need to configure the parametre.ini
<br/>
🚧 You need to Allow execution of PowerShell scripts for that execute powershell on SUPER user on type this:

```powershell
Set-ExecutionPolicy RemoteSigned
```
<br/>
To execute the programme in the powershell is this commande

```
./htmlceation.ps1
```

# Parametre.ini
```
[Titre]
Name=Your Title

[Dossiers]
C:\Your path

[Infos]
Name=oui
Date=oui
Taille=oui

[Extensions]
.txt
.jpg
.png

[Exclusions]
All folder you don't want put the path
```
# Example

![image](https://user-images.githubusercontent.com/44686652/98031969-96507800-1e13-11eb-968b-3688a1a86968.png)

# MIT License
Copyright (c) 2020 Guillaume Dorschner

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
