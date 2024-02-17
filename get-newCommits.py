import getpass
import subprocess
import requests

def get_current_commit_sha():
    try:
        # Run the git log command 
        result = subprocess.run(['git', 'log', '-1', '--pretty=format:%H'], stdout=subprocess.PIPE)
        
        # Decode the output from bytes to string
        current_commit_sha = result.stdout.decode().strip()
        return current_commit_sha
    except Exception as e:
        print(f"Error getting current commit SHA: {e}")
        return None
    
def get_latest_commit(username, repository, token):
    url = f'https://api.github.com/repos/{username}/{repository}/commits'
    
    headers = {'Authorization': token}
    
    response = requests.get(url, headers=headers)
    
    if response.status_code == 200:
        commits = response.json()
        if commits:
            latest_commit_sha = commits[0]['sha']
            return latest_commit_sha
        else:
            return None
    else:
        print(f"Error: Unable to fetch commits. Status Code: {response.status_code}")
        return None

def check_for_new_commits(username, repository, current_commit_sha, token):
    latest_commit_sha = get_latest_commit(username, repository, token)
    
    if latest_commit_sha and latest_commit_sha != current_commit_sha:
        print("New commits found!")
        print(f"Latest Commit SHA: {latest_commit_sha}")
    else:
        print("No new commits.")

if __name__ == "__main__":
    # Replace 'your_github_username' and 'your_repository_name' with your GitHub username and repository name
    github_username = 'mahalekiran'
    repository_name = 'CICD-Pipeline'
    
    # Get latest SHA commit
    current_commit_sha = get_current_commit_sha()

    #GitHub personal access token
    token = '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'
    
    check_for_new_commits(github_username, repository_name, current_commit_sha, token)
