# Create R project and integrate Git(Public user account) with RStudio. Please follow below steps.
Step-1: Download git.exe file with the help of below link:
	https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN
Click on git, it will open new tab (https://git-scm.com/). 
Go to new release git software for window and click on it to download.

Step-2: Install git software

Step-3: Go to Window search (GitBash) and open GitBash command 

Step-4: Type your git username and gmail-id:

Arvind@Arvind MINGW64 ~
$ git config --global user.name arvindkumar1230

Arvind@Arvind MINGW64 ~
$ git config --global user.email arvindkumar1230@gmail.com	


Step-5: Open RStudio, 
Go to Tools-> Global Options 
-> click on Git/SVN 
-> If Git executable has path C:/Program Files/Git/bin/git.exe then fine,
   Or, Browse to that location in your computer.


Step-6: Go to new project open Git and paste your clone git url in first box. In second box automatically filled your repo name and in             third box please choose system workspace path to the project. It will pull your git repo files in local folder.


Step-7: Create new file, Save file in your workspace location and write script. 
        Commit this in git (Click on GI+ in Rstudio- below Tools it is there) and push the code (will popup git – enter credential to push the code)
 
