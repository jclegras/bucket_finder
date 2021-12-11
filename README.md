# bucket_finder

Very simple Bash script to find public S3 buckets on the Internet

Public means here without the need to have an AWS account, http://acs.amazonaws.com/groups/global/AllUsers Amazon S3 predefined group authorized

## How to use it

    while read p; do ./bucket_finder.sh "$p" ;done< common-names > common-names.log
    
## References

* https://github.com/FishermansEnemy/bucket_finder
* https://digi.ninja/projects/bucket_finder.php
