# get_git_revisions.sh <git directory> <n>
# check out n versions (first n commits) of the git repository in <git directory>
# and concatenate all .cpp and .hpp files in a single output file.
# if n=0, check out all revisions

#creates output file in the directory <git directory>/..
#output file name has the format FIRST_<n>_VERSIONS_<repo name>_<date>.txt

git_dir=$1
n=$2 #number of versions to checkout. If 0, check out all versions

cd $git_dir

dat=`date | cut -d' ' -f 2,3,4 | tr -d ' ,'`

commits_file=../FIRST_$n_COMMITS_`basename $git_dir`_${dat}.txt
versions_file=../FIRST_${n}_VERSIONS_`basename $git_dir`_${dat}.txt

git rev-list --all --pretty=oneline | cut -f 1 -d' ' > $commits_file

rm $versions_file

while read p; do
  
	git checkout $p #get version
	
	for file in `find . -name \*.cpp -or -name \*.hpp`; do 

		cat $file >> $versions_file

	done

	#if n>0, decrement it (never enter here uif we start with n=0)
	if [ $n -gt 0 ]
	then
		n=$((n-1))

		#if now n=0, exit			
		if [ $n -eq 0 ]
		then
			git checkout origin/master
			rm $commits_file
			exit 0
		fi	
	fi

done < $commits_file

#restore status to origin/master
git checkout origin/master
rm $commits_file
