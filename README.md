# bucket_finder

Very simple Bash script to find public S3 buckets on the Internet

## How to use it

    while read p; do ./bucket_finder.sh "$p" ;done< common-names > common-names.log
