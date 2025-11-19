#!/bin/bash

# Function to generate random number of commits (1-3) per day
make_commits() {
    start_date=$1
    end_date=$2
    message=$3

    current=$(date -I -d "$start_date")
    end=$(date -I -d "$end_date")

    while [[ "$current" < "$end" || "$current" == "$end" ]]; do
        commits=$(( (RANDOM % 3) + 1 ))  # 1 to 3 commits per day

        for ((i=1; i<=commits; i++)); do
            hour=$((RANDOM % 12 + 8))    # 08:00–20:00
            minute=$((RANDOM % 60))
            second=$((RANDOM % 60))

            export GIT_AUTHOR_DATE="$current $hour:$minute:$second"
            export GIT_COMMITTER_DATE="$current $hour:$minute:$second"

            echo "$message - $current $hour:$minute" >> log.txt
            git add log.txt
            git commit -m "$message"
        done

        current=$(date -I -d "$current + 1 day")
    done
}

echo "Starting commit generation..."

# Jan–Mar 2024 → Linux practice
make_commits "2024-01-01" "2024-03-31" "Linux practice"

# Apr–Jun 2024 → Jenkins + Git
make_commits "2024-04-01" "2024-06-30" "Jenkins and Git learning"

# Jul–Sep 2024 → Docker + Ansible
make_commits "2024-07-01" "2024-09-30" "Docker and Ansible practice"

# Oct–Dec 2024 → Kubernetes learning
make_commits "2024-10-01" "2024-12-31" "Kubernetes learning"

echo "Done! Now push using: git push origin main"

