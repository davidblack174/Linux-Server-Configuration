## What is a PowerShell Profile?

A PowerShell profile is a script that runs every time you start a new PowerShell session. It allows you to customize your environment by adding aliases, functions, variables, and other settings that you want to use in every session.
## Steps to Create and Edit Your PowerShell Profile

### 1. Open PowerShell

### 2. Check If a Profile Already Exists
	Test-Path $PROFILE
### 3. Create or Open Your Profile in Notepad
	notepad $PROFILE

### 4. Add Default Settings to Your Profile
	Set-Alias c clear
	Set-Alias ll Get-ChildItem

	function ll { Get-ChildItem -Force }	//Add a Custom Function

### 5. Save the Profile File
	ll					/test commands

### 6. Ensuring Your Profile Executes

	Get-ExecutionPolicy				//Check the Current Execution Policy

	Set-ExecutionPolicy RemoteSigned -Scope CurrentUser				//Set a Less Restrictive Policy (If Necessary)










