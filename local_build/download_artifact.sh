#!/bin/bash

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

# Get Run ID
RUN_ID=$(curl -s -H "Authorization: Bearer $TOKEN" "https://api.github.com/repos/gbakes/zmk_sofle2/actions/runs?event=push&status=success" | jq -r '.workflow_runs[0].id')

# Get Artifact ID
ARTIFACT_ID=$(curl -s -H "Authorization: Bearer $TOKEN" "https://api.github.com/repos/gbakes/zmk_sofle2/actions/runs/$RUN_ID/artifacts" | jq -r '.artifacts[0].id')

# Download Artifact
zip_file="firmware.zip"
curl -LJO -H "Authorization: Bearer $TOKEN" "https://api.github.com/repos/gbakes/zmk_sofle2/actions/artifacts/$ARTIFACT_ID/zip" && mv "$(ls *.zip)" "$zip_file"

# Unzip firmware

unzip $zip_file && rm $zip_file