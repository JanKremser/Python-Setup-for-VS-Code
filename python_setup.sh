#!/bin/bash

PROJECT_NAME="${1}"

ROOT_PATH="."
SRC_PATH="${ROOT_PATH}/src/${PROJECT_NAME}"


# create project folders

mkdir -p $SRC_PATH
mkdir -p "${SRC_PATH}/tests"

cat > "${SRC_PATH}/__init__.py" << EOL
__version__ = '0.0.0'
__author__ = 'AUTHOR'
EOL
touch "${SRC_PATH}/main.py"

touch "${ROOT_PATH}/.env.dev"
touch "${ROOT_PATH}/requirements.txt"


# create python venv

#python -m venv "${ROOT_PATH}/.venv"


# config vs-code

mkdir -p "${ROOT_PATH}/.vscode"
cat > "${ROOT_PATH}/.vscode/settings.json" << EOL
{
    "files.exclude": {
        "**/__pycache__": true
    },
    "pylint.args": [
        "--rcfile=${workspaceFolder}/.pylintrc.toml"
    ],
    "pylint.severity": {
        "convention": "Warning",
        "error": "Error",
        "fatal": "Error",
        "refactor": "Error",
        "warning": "Error",
        "info": "Warning"
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
            },
            "envFile": "\${workspaceFolder}/.env"
        },
    ]
}
EOL


# set gitignore

cat >> "${ROOT_PATH}/.gitignore" << EOL
/.devcontainer
/.venv
/.vscode
/.env.dev
/.git
__pycache__
EOL


# set readme

cat > "${ROOT_PATH}/README.md" << EOL
# ${PROJECT_NAME}
EOL

