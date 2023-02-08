#!/bin/bash  
#READ ME
# 1. Get the commit hash that you want to push the changes for. Do that with $ git rev-list <branch> command , to view more info on a hash, run git show <hash>
# 2. Make sure the directory to which you want to output the files exists. i.e C:/wamp64/www/DischemDashboard/_deploy/. 
#		PLEASE NOTE: Use _deploy as this folder is in the gitignore if on the same worktree as your git project
# 3. RUN ./_deploy.sh with terminal to generate files
# 4. All files for the commit hash would be generated in the _deploy folder (or other folder specified)
#END READ ME
#Get the commit hash that you want to move the file of.
COMMIT_HASH="647c909d25d7c9323fea03b30e72c542fb19bf07"
#Directory to write all the files too.
DEPLOY_DIR="C:/wamp64/www/DischemDashboard/_deploy/"
echo "Checking Commit "$COMMIT_HASH
if [ -d "$DEPLOY_DIR" ]; then
	for commit in $COMMIT_HASH
	do
		for FILE_NAME in $(git show --pretty="format:" --name-only $commit)
		do
			DIR_NAME=$DEPLOY_DIR 
			DIR_NAME+=$FILE_NAME
			mkdir -p $DEPLOY_DIR"$(dirname "$FILE_NAME")"
			echo "Adding "$DEPLOY_DIR$FILE_NAME
			git show --pretty="format:" --name-only $commit:$FILE_NAME > $DIR_NAME
		done
	done
	echo "Done"
else
	echo "_deploy directory does not exist"
fi
echo "Exiting"