# Jenkins Pipeline Configuration
![image](https://github.com/user-attachments/assets/af981fe3-ef5b-4c34-8dc7-1ed3b2beafeb)

## Description

This repository contains a Jenkins pipeline configuration designed to automate several tasks related to Python development and Docker image building. The pipeline performs the following stages:

1. **Pre-Build: Install Dependencies**:
   - Updates system packages.
   - Installs essential system dependencies such as `wget`, `curl`, `python3`, `python3-pip`, `python3-venv`, `shellcheck`, and `aspell`.
   - Installs and configures [Poetry](https://python-poetry.org/) for managing Python dependencies.

2. **Spell Check**:
   - Activates the virtual environment created by Poetry.
   - Uses `aspell` to check for spelling mistakes in the `README.md` file.
   - Fails the build if any spelling errors are found.

3. **Shellcheck**:
   - Checks the syntax of shell scripts using `shellcheck`.
   - Currently configured to check `build.sh`.

4. **Test**:
   - Activates the virtual environment.
   - Runs Python tests using `pytest`. (Note: This stage is currently commented out due to non existing pytests in the project.)

5. **Build Docker Image**:
   - Builds a Docker image with the tag `details-app:latest` using a Dockerfile in the repository.

## What It Actually Does

The Jenkins pipeline automates the setup of the development environment, performs code quality checks (spell checking and shell script linting), and builds a Docker image. However, the pipeline faces a permission issue when attempting to build the Docker image.

## Identified Gaps

1. **Docker Permission Issue**:
   - **Error**: `permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock`.
   - **Cause**: The Jenkins user does not have the necessary permissions to access the Docker daemon.
   - **Resolution**: Ensure the Jenkins user is added to the `docker` group and has appropriate permissions. Restart Jenkins and Docker services after making changes.

2. **Pytest Not Executing**:
   - **Issue**: The `pytest` command is commented out in the pipeline configuration.
   - **Resolution**: Add tests to ensure Python tests are executed.

## How to Use

1. **Set Up Jenkins**:
   - Ensure Jenkins is installed and configured.
   - Add Jenkins user to the Docker group: `sudo usermod -aG docker jenkins`.
   - Restart Jenkins: `sudo systemctl restart jenkins`.

2. **Configure Pipeline**:
   - Copy the Jenkins pipeline configuration into a Jenkinsfile and place it in the repository.

3. **Build Docker Image**:
   - Ensure that Docker is running and accessible.
   - Verify that all required system dependencies are installed.

4. **Run Pipeline**:
   - Trigger the Jenkins pipeline to execute the defined stages.

## Installation and Running Instructions

Clone the repository:

   ```sh
   git clone https://github.com/nastyak6/details-app/tree/nastya


Contributors

    Anastasia Kokin
    Charlie Haimov

    No Mamon agreement, so 50-50 it is :)
