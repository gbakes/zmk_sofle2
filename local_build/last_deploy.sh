#!/bin/bash

cd /Users/georgebaker/Documents/2.\ Projects/zmk_sofle2/local_build

# Load environment variables from .env file
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "Error: .env file not found"
  exit 1
fi

# Check if GITHUB_TOKEN is set
if [ -z "$TOKEN" ]; then
  echo "Error: GITHUB_TOKEN is not set in .env file"
  exit 1
fi


timestamp=$(curl -s -H "Authorization: Bearer $TOKEN" "https://api.github.com/repos/gbakes/zmk_sofle2/actions/runs?event=push&status=success" | jq -r '.workflow_runs[0].updated_at')

formatted_time_cet=$(date -jf "%Y-%m-%dT%H:%M:%SZ" "$timestamp" +"%Y-%m-%d %H:%M:%S %Z")

# Add an hour to the formatted time
formatted_time_local=$(date -jf "%Y-%m-%d %H:%M:%S %Z" -v +1H "$formatted_time_cet" +"%Y-%m-%d %H:%M:%S %Z +1")


# Calculate minutes since the timestamp
current_time=$(date +"%s")
timestamp_seconds=$(date -jf "%Y-%m-%dT%H:%M:%SZ" "$timestamp" +"%s")
minutes_since=$(( (($current_time - $timestamp_seconds) / 60 )-60))

echo "Formatted Time: $formatted_time_local"
echo "Minutes Since: $minutes_since"