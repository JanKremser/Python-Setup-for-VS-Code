#!/bin/bash

PROJECT_NAME="${1}"
AUTHOR="${2}"

ROOT_PATH="."
SRC_PATH="${ROOT_PATH}/src/${PROJECT_NAME}"


# create project folders

mkdir -p $SRC_PATH
mkdir -p "${SRC_PATH}/tests"

cat > "${SRC_PATH}/__init__.py" << EOL
__version__ = '0.14.0'
__author__ = '${AUTHOR}'
EOL
touch "${SRC_PATH}/main.py"
touch "${SRC_PATH}/standalone.py"

touch "${ROOT_PATH}/.env.dev"
touch "${ROOT_PATH}/requirements.txt"


# create python venv

python -m venv "${ROOT_PATH}/venv"


# config vs-code

mkdir -p "${ROOT_PATH}/.vscode"
cat > "${ROOT_PATH}/.vscode/settings.json" << EOL
{
    "python.pythonPath": "\${workspaceFolder}/venv/bin/python",
    "python.envFile": "\${workspaceFolder}/.env.dev",
    "files.exclude": {
        "**/__pycache__": true
    }
}
EOL

cat > "${ROOT_PATH}/.vscode/launch.json" << EOL
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Modul",
            "type": "python",
            "request": "launch",
            "module": "${PROJECT_NAME}.main",
            "env": {
                "PYTHONPATH": "\${workspaceFolder}/src"
            }
        },
    ]
}
EOL


# set gitignore

cat >> "${ROOT_PATH}/.gitignore" << EOL
/venv
/.vscode
__pycache__
EOL


# set readme

cat > "${ROOT_PATH}/README.md" << EOL
# ${PROJECT_NAME}
EOL

