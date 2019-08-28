# Version Control 

The practice of saving successive versions of computer code is known as version control. With this practice, you can securely store past and present versions of your code on a remote computer and share it with others. 
The version control platform that we will use is called GitHub and the reason for this choice is outlined in Paarsch and Golyaev.



## Version Control 1: Opening an account

This exercise can be completed on any device that has access to the internet - including your smartphone.

### Open an account 

Follow the instructions in [Signing up for a new GitHub account](https://help.github.com/en/articles/signing-up-for-a-new-github-account).

### Start a new coding project

If you want to create a new coding project, you should begin by creating a new repository. A repository is a location in your user space that can be used to store youre code. To initialize a new repository (or repo, for short), follow the instructions in [Create a repo](https://help.github.com/en/articles/create-a-repo). 

### Modify an existing project

Several versions of your code can be stored at the same time in units called branches. 
The default storage space for a repository is called the master branch. Often, you will not want to make edits to the master branch when you are developing new code, so you would [create another branch of the repository](https://help.github.com/en/articles/creating-and-deleting-branches-within-your-repository). 
Once you have tested your code, it can be pulled to the master branch by [Creating a pull request](https://help.github.com/en/articles/creating-a-pull-request). 

### Forking: Making your own copy of the repo

For extensive edits, or to create a new, separate project built off an exisiting repository, you may want to [fork an existing repo](https://help.github.com/en/articles/fork-a-repo). 


## Version Control 2: Making edits to your code


To participate in this exercise, you should have installed [Git](https://git-scm.com/) and an associated terminal GitBash. 


### Using GitHub for Version Control

If your code is not yet associated with a repository, then your code base is untracked. To track your software, either initialize a new repo or clone an existing repo and add your code to it. We will follow the second approach today, as you will use it to download the code base for the course and modify it as you need. As for initializing your own repo, we will progress to that stage as you begin to work on your own coding projects. 

Open a unix terminal and navigate to a directory in which you want to work (```cd path/to/your/preferred/workspace```). 

Clone the repo to your workspace:
```
git clone https://github.com/LeeMorinUCF/ECO5445F18
```

To be nice to the repo owner, you should start your own branch of the repo, on which you can make your own changes. 
```
git branch your_new_branch_name
```
Then move into that branch:
```
git checkout your_new_branch_name
```

Then make changes to files and add files to your own local copy. 

When you want to add changes to the local branch, ```add``` the files:
```
git add .
```

When you want to commit those changes to your local repo, you can enter
```
git commit -m 'Description of the changes you made goes here'
```

Finally, if you have the permissions to do so, you can push your changes to the remote repository:
```
git push origin your_new_branch_name
```
You may be asked for login credentials, which will be the credentials for your GitHub profile. 

If all goes well, you can refresh the repo in the browser, change the branch tab to ```your_new_branch_name``` and you should see your changes to the repo. These modifications are now part of the remote repository and are safely stored regardless of what happens to your local computer. Moreover, your teammates on a coding project can view your changes and work them into a larger coding project. 

A helpful tip is to get accustomed to using the ```git status``` command. This will tell you the current status of the changes that you have made. You can use it between the ```git add```, ```git commit``` and ```git push``` commands above to see how the changes progress.
