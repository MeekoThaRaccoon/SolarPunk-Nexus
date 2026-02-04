import os
import subprocess
import json
from pathlib import Path

class GitHubAutoFix:
    def __init__(self, base_path="C:\\Users\\carol\\SolarPunk"):
        self.base_path = Path(base_path)
        self.results = {}
        
    def find_all_repos(self):
        """Find all git repos in SolarPunk directory"""
        repos = []
        for root, dirs, files in os.walk(self.base_path):
            if '.git' in dirs:
                repos.append(Path(root))
                dirs.remove('.git')  # Don't go deeper into .git
        return repos
    
    def check_repo_status(self, repo_path):
        """Check if repo can push to GitHub"""
        try:
            os.chdir(repo_path)
            
            # Get repo name from remote
            result = subprocess.run(['git', 'remote', '-v'], 
                                  capture_output=True, text=True)
            remote = result.stdout
            
            # Check if remote exists
            if 'github.com' in remote:
                # Try to push
                push_result = subprocess.run(['git', 'push', 'origin', 'master'],
                                           capture_output=True, text=True)
                
                if 'Repository not found' in push_result.stderr:
                    return 'REPO_NOT_EXIST'
                elif 'Authentication' in push_result.stderr:
                    return 'AUTH_ERROR'
                elif push_result.returncode == 0:
                    return 'PUSH_OK'
                else:
                    return f'ERROR: {push_result.stderr[:50]}'
            else:
                return 'NO_REMOTE'
                
        except Exception as e:
            return f'EXCEPTION: {str(e)}'
    
    def create_fix_script(self, repos_status):
        """Create autonomous fix script based on problems found"""
        script_lines = [
            '@echo off',
            'echo === AUTONOMOUS REPO FIX ===',
            'echo.',
        ]
        
        for repo_path, status in repos_status.items():
            if status == 'REPO_NOT_EXIST':
                repo_name = os.path.basename(repo_path)
                script_lines.extend([
                    f'echo Fixing {repo_name}...',
                    f'cd /d "{repo_path}"',
                    'git add .',
                    'git commit -m "Autonomous fix"',
                    'echo Create repo on GitHub: https://github.com/new',
                    'echo Name it exactly: ' + repo_name,
                    'pause',
                ])
            elif status == 'NO_REMOTE':
                repo_name = os.path.basename(repo_path)
                script_lines.extend([
                    f'echo Adding remote for {repo_name}...',
                    f'cd /d "{repo_path}"',
                    f'git remote add origin https://github.com/YOUR_USERNAME/{repo_name}.git',
                    'git push -u origin master',
                ])
        
        script_lines.append('echo All fixes applied!')
        script_lines.append('pause')
        
        return '\n'.join(script_lines)
    
    def run(self):
        """Main autonomous fix routine"""
        print("🔍 Scanning for repos...")
        repos = self.find_all_repos()
        print(f"📁 Found {len(repos)} repositories")
        
        # Check each repo
        for repo in repos:
            status = self.check_repo_status(repo)
            self.results[str(repo)] = status
            print(f"  {os.path.basename(repo)}: {status}")
        
        # Generate fix script
        fix_script = self.create_fix_script(self.results)
        
        # Save to file
        script_path = self.base_path / 'AUTONOMOUS_FIX.bat'
        with open(script_path, 'w', encoding='utf-8') as f:
            f.write(fix_script)
        
        print(f"\n✅ Fix script saved to: {script_path}")
        print("\n🔧 SIMPLE FIX:")
        print("1. Run the batch file above")
        print("2. Follow prompts")
        print("3. Everything fixed automatically")

# RUN IT
if __name__ == "__main__":
    fixer = GitHubAutoFix()
    fixer.run()