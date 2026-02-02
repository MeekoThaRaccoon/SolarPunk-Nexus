#!/usr/bin/env python3
"""
SolarPunk Nexus - Autonomous Controller
Serves static site + manages self-replication + self-healing
"""
import os
import sys
import time
import json
import hashlib
import subprocess
import threading
from pathlib import Path
import shutil
import signal
import atexit

# Add src to path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from replicate import NexusReplicator
from heal import NexusHealer

class NexusController:
    def __init__(self, port=5000, instance_id=None):
        self.port = port
        self.instance_id = instance_id or self.generate_id()
        self.base_dir = Path(__file__).parent.parent
        self.static_dir = self.base_dir
        self.server_process = None
        self.replicator = NexusReplicator(self.base_dir, self.instance_id)
        self.healer = NexusHealer(self.port, self.base_dir)
        
        # Load ethics
        self.ethics = self.load_ethics()
        
        # State
        self.start_time = time.time()
        self.replication_count = 0
        self.max_replications = self.ethics.get('max_instances_per_host', 3)
        
    def generate_id(self):
        """Generate unique instance ID"""
        seed = f"{time.time()}{os.urandom(16).hex()}"
        return hashlib.sha256(seed.encode()).hexdigest()[:12]
    
    def load_ethics(self):
        """Load immutable ethics rules"""
        ethics_path = Path(__file__).parent / 'ethics.json'
        if ethics_path.exists():
            with open(ethics_path, 'r') as f:
                return json.load(f)
        
        # Default ethics
        return {
            "name": "SolarPunk Nexus Ethics",
            "version": "1.0",
            "rules": {
                "redistribution": True,
                "transparency": True,
                "max_instances_per_host": 3,
                "consent_required": True,
                "self_healing": True,
                "self_replication": True
            }
        }
    
    def start_server(self):
        """Start HTTP server for static site"""
        # Kill any existing server on this port
        try:
            subprocess.run(['fuser', '-k', f'{self.port}/tcp'], 
                         stderr=subprocess.DEVNULL)
        except:
            pass
        
        # Start simple HTTP server
        cmd = ['python3', '-m', 'http.server', str(self.port)]
        self.server_process = subprocess.Popen(
            cmd,
            cwd=self.static_dir,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        print(f"🌐 Nexus server started on port {self.port} (PID: {self.server_process.pid})")
        
        # Log startup
        self.log_event('server_started', {
            'port': self.port,
            'pid': self.server_process.pid,
            'instance_id': self.instance_id
        })
    
    def stop_server(self):
        """Stop HTTP server"""
        if self.server_process:
            self.server_process.terminate()
            self.server_process.wait()
            print(f"🛑 Nexus server stopped")
    
    def log_event(self, event_type, data):
        """Log event to public ledger"""
        log_entry = {
            'timestamp': time.time(),
            'instance_id': self.instance_id,
            'event': event_type,
            'data': data,
            'ethics_hash': hashlib.sha256(json.dumps(self.ethics).encode()).hexdigest()[:16]
        }
        
        log_file = self.base_dir / 'logs' / 'nexus_events.jsonl'
        log_file.parent.mkdir(exist_ok=True)
        
        with open(log_file, 'a') as f:
            f.write(json.dumps(log_entry) + '\n')
    
    def start(self):
        """Start all components"""
        print(f"""
        ⚡ SolarPunk Nexus v2.0 - Autonomous Mode
        Instance: {self.instance_id}
        Port: {self.port}
        Ethics: {self.ethics['name']} v{self.ethics['version']}
        """)
        
        # Start server
        self.start_server()
        
        # Start healer
        self.healer.start()
        
        # Start replication monitor
        self.start_replication_monitor()
        
        # Register shutdown handler
        atexit.register(self.cleanup)
        signal.signal(signal.SIGINT, self.signal_handler)
        signal.signal(signal.SIGTERM, self.signal_handler)
        
        print(f"✅ Nexus {self.instance_id} running autonomously")
        print(f"   Access: http://localhost:{self.port}")
        print(f"   Logs: {self.base_dir}/logs/")
        
        # Keep main thread alive
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            pass
    
    def start_replication_monitor(self):
        """Monitor and trigger replication when needed"""
        def monitor():
            # Wait for initial stability
            time.sleep(300)  # 5 minutes
            
            while True:
                time.sleep(60)  # Check every minute
                
                # Check if we should replicate
                if (self.replication_count < self.max_replications and 
                    self.healer.is_healthy() and
                    self.replicator.should_replicate()):
                    
                    print(f"🌀 Replication conditions met. Attempting to replicate...")
                    child_id = self.replicator.replicate()
                    if child_id:
                        self.replication_count += 1
                        self.log_event('replication_successful', {
                            'child_id': child_id,
                            'total_replications': self.replication_count
                        })
        
        thread = threading.Thread(target=monitor, daemon=True)
        thread.start()
    
    def signal_handler(self, sig, frame):
        """Handle shutdown signals"""
        print(f"\n🛑 Received signal {sig}. Shutting down gracefully...")
        self.cleanup()
        sys.exit(0)
    
    def cleanup(self):
        """Clean shutdown"""
        self.stop_server()
        self.healer.stop()
        print(f"👋 Nexus {self.instance_id} shut down")

if __name__ == '__main__':
    import argparse
    
    parser = argparse.ArgumentParser(description='SolarPunk Nexus - Autonomous Controller')
    parser.add_argument('--port', type=int, default=5000, help='Port to serve Nexus')
    parser.add_argument('--instance-id', type=str, help='Instance ID (auto-generated if not provided)')
    
    args = parser.parse_args()
    
    controller = NexusController(port=args.port, instance_id=args.instance_id)
    controller.start()
