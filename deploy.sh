#!/bin/bash

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration files
apps_to_deploy="./configs/applications.conf"
env_file="configs/conf.env"

# Function to log messages
log_message() {
    local level=$1
    local message=$2
    
    case $level in
        "ERROR")
            echo -e "${RED}[ERROR]${NC} $message"
            ;;
        "SUCCESS")
            echo -e "${GREEN}[SUCCESS]${NC} $message"
            ;;
        "INFO")
            echo -e "${YELLOW}[INFO]${NC} $message"
            ;;
    esac
}

# Check if required files exist
if [ ! -f "$apps_to_deploy" ]; then
    log_message "ERROR" "Applications configuration file not found: $apps_to_deploy"
    exit 1
fi

if [ ! -f "$env_file" ]; then
    log_message "ERROR" "Environment file not found: $env_file"
    exit 1
fi

# Check if docker is installed and running
if ! command -v docker &> /dev/null; then
    log_message "ERROR" "Docker is not installed. Please install Docker first."
    exit 1
fi

if ! docker info &> /dev/null; then
    log_message "ERROR" "Docker daemon is not running. Please start Docker service."
    exit 1
fi

# Counter for successful deployments
success_count=0
failed_apps=()

log_message "INFO" "Starting deployment process..."

# Read applications file line by line
while IFS= read -r line || [ -n "$line" ]; do
    # Skip empty lines and comments
    [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
    
    docker_compose_file="src/docker-compose/$line/docker-compose.yml"
    
    # Check if docker-compose file exists
    if [ ! -f "$docker_compose_file" ]; then
        log_message "ERROR" "Docker compose file not found for $line: $docker_compose_file"
        failed_apps+=("$line")
        continue
    fi
    
    log_message "INFO" "Deploying $line..."
    
    # Deploy the application
    # docker compose -f $docker_compose_file --env-file $env_file up -d
    if eval "docker compose -f $docker_compose_file --env-file $env_file --build"; then
        log_message "SUCCESS" "$line deployed successfully"
        ((success_count++))
    else
        log_message "ERROR" "Failed to deploy $line"
        failed_apps+=("$line")
    fi
    
done < "$apps_to_deploy"

# Summary
echo -e "\n=== Deployment Summary ==="
log_message "INFO" "Successfully deployed: $success_count application(s)"

if [ ${#failed_apps[@]} -gt 0 ]; then
    log_message "ERROR" "Failed to deploy ${#failed_apps[@]} application(s):"
    for app in "${failed_apps[@]}"; do
        echo -e "${RED}- $app${NC}"
    done
    exit 1
fi

log_message "SUCCESS" "All applications deployed successfully!"
exit 0