Usage: 

    get_git_revisions.sh git_directory n

Behavior: checks out n versions (last n commits) of the git repository in git_directory and concatenates all .cpp and .hpp files in a single output file. If n=0, check out all versions. 

creates output file in the directory git_directory/.. . Output file name has the format LAST_n_VERSIONS_repo_name_date.txt
