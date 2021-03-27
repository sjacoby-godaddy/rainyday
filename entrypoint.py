#!/venv/bin/python

import json
import os
import subprocess
import sys

github_event_path = os.getenv('GITHUB_EVENT_PATH')
github_repository = os.getenv('GITHUB_REPOSITORY')
github_workspace = os.getenv('GITHUB_WORKSPACE')

current_event_only = os.getenv('INPUT_CURRENT_EVENT_ONLY')
options = os.getenv('INPUT_OPTIONS')
github_token = os.getenv('INPUT_GITHUB_TOKEN')
print(f'::add-mask::{github_token}')

if github_token:
    target = f'https://{github_token}@github.com/{github_repository}'
else:
    target = f'https://github.com/{github_repository}'

def push_arguments(github_event):

    if 'ref' in github_event.keys() and 'before' in github_event.keys():
        return ['--branch', github_event['ref'], '--since-commit',  github_event['before']]
    return []

def pr_arguments(github_event):

    if 'pull_request' in github_event.keys():
        return ['--branch', github_event['pull_request']['head']['ref'], '--max-depth',  str(github_event['pull_request']['commits'])]
    return []

os.chdir(github_workspace)

run_arguments = ['/venv/bin/tartufo', 'scan-remote-repo']

if str(current_event_only).lower() == 'true':
    with open(github_event_path) as f:
        github_event = json.load(f)

    additional_arguments = push_arguments(github_event)

    if len(additional_arguments) == 0:
        additional_arguments = pr_arguments(github_event)

    if len(additional_arguments) > 0:
        run_arguments.extend(additional_arguments)

if options:
    run_arguments.extend(options.split())

run_arguments.append(target)

process = subprocess.run(run_arguments)

print(f'Tartufo secret scan completed with exit code {process.returncode}')

sys.exit(process.returncode)
