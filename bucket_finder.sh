#!/bin/bash

# Very simple script for finding opened buckets
# TODO:
#   - check that if any object inside a bucket is public
#   - check if the bucket is publicly writeable
# Make use of xmllint
# Example of how to use this script:  while read p; do ./bucket_finder.sh "$p" ;done< common-names > common-names.log

bucket_name="$1"

status_code=$(curl -o /dev/null -I -s -w "%{http_code}" "http://${bucket_name}.s3.amazonaws.com")

function get_body() {
  curl -s "http://${bucket_name}.$1"
}

function list_content() {
  get_body "$1" | xmllint --format - | grep "<Key>" | sed -r "s/^[^<]+<Key>(.*)<\/Key>$/\1/"
}

function get_endpoint() {
  echo $(get_body "s3.amazonaws.com" | xmllint --format - | grep "<Endpoint>" | sed -r "s/^[^<]+<Endpoint>(.*)<\/Endpoint>$/\1/")
}

echo "Searching for bucket ${bucket_name}..."

case $status_code in
  "200")
    echo "** Public bucket **"
    echo -e "List files..\n"
    list_content "s3.amazonaws.com"
    ;;
  "403")
    echo "Private Bucket"
    ;;
  "301"|"307")
    echo "Public bucket"
    echo "Redirection to another endpoint"
    echo -e "List files..\n"
    list_content $(get_endpoint) 
    ;;
  *)
    echo "Unknown"
    ;;
esac
