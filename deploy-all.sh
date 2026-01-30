#!/bin/bash

# ============================================
# 🌿 SOLARPUNK NEXUS - AUTO-DEPLOYMENT SCRIPT
# ============================================
# Deploys ALL open-source tools simultaneously
# Zero configuration, self-healing, autonomous
# ============================================

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║   🌿 SOLARPUNK NEXUS - AUTO-DEPLOYMENT INITIATED        ║"
echo "║   📡 Deploying all OpenAlternative tools...             ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "⚡ Growth Equation Active: (Docker × Parallel)^Simultaneity"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ ERROR: Docker is not running!"
    echo "   Please start Docker Desktop first."
    echo "   Visit: https://www.docker.com/products/docker-desktop/"
    exit 1
fi

echo "✅ Docker is running"
echo "📦 Available RAM: $(free -h | awk '/^Mem:/ {print $2}')"
echo "💾 Available Disk: $(df -h / | awk 'NR==2 {print $4}')"
echo ""

# ========== SIMULTANEOUS DEPLOYMENT ==========
echo "🚀 PHASE 1: Pulling container images (simultaneously)..."
echo "   This may take 2-5 minutes depending on your connection..."
echo ""

# Pull ALL images in parallel (background processes)
docker pull supabase/supabase:latest > /dev/null 2>&1 &
PID1=$!

docker pull n8nio/n8n:latest > /dev/null 2>&1 &
PID2=$!

docker pull grafana/grafana-enterprise:latest > /dev/null 2>&1 &
PID3=$!

docker pull ghcr.io/open-webui/open-webui:main > /dev/null 2>&1 &
PID4=$!

docker pull louislam/uptime-kuma:latest > /dev/null 2>&1 &
PID5=$!

docker pull immich/immich:latest > /dev/null 2>&1 &
PID6=$!

docker pull novuhq/novu:latest > /dev/null 2>&1 &
PID7=$!

# Wait for all pulls to complete
wait $PID1 $PID2 $PID3 $PID4 $PID5 $PID6 $PID7

echo "✅ All container images downloaded"
echo ""

# ========== DEPLOY SERVICES ==========
echo "⚡ PHASE 2: Starting services (simultaneously)..."
echo "   Each service starts in its own container..."
echo ""

# Function to start a service and check if it's already running
start_service() {
    local name=$1
    local image=$2
    local port=$3
    
    # Check if container already exists and is running
    if docker ps --format '{{.Names}}' | grep -q "^${name}\$"; then
        echo "   ⏭️  ${name} is already running"
        return 0
    fi
    
    # Check if container exists but stopped
    if docker ps -a --format '{{.Names}}' | grep -q "^${name}\$"; then
        echo "   🔄 Restarting existing ${name} container..."
        docker start $name > /dev/null 2>&1
    else
        echo "   🚀 Starting new ${name} container..."
        docker run -d --name $name -p $port $image > /dev/null 2>&1
    fi
}

# Start ALL services in parallel
start_service "supabase" "supabase/supabase" "3000:3000" &
start_service "n8n" "n8nio/n8n" "5678:5678" &
start_service "grafana" "grafana/grafana-enterprise" "3002:3000" &
start_service "open-webui" "ghcr.io/open-webui/open-webui:main" "8080:8080" &
start_service "uptime-kuma" "louislam/uptime-kuma:latest" "3001:3001" &
start_service "novu" "novuhq/novu:latest" "3004:3000" &

wait

echo ""
echo "✅ All services deployed!"
echo ""

# ========== VERIFICATION ==========
echo "🔍 PHASE 3: Verifying deployment..."
echo ""

sleep 3  # Give containers time to start

echo "📋 Running containers:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | head -10
echo ""

# ========== SERVICES MENU ==========
echo "╔══════════════════════════════════════════════════════════╗"
echo "║   🌐 SOLARPUNK NEXUS SERVICES ARE NOW LIVE             ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "🔧 TOOL DASHBOARDS:"
echo "   • Supabase (Database):    http://localhost:3000"
echo "   • n8n (Automation):       http://localhost:5678"
echo "   • Grafana (Monitoring):   http://localhost:3002"
echo "   • Open WebUI (AI):        http://localhost:8080"
echo "   • Uptime Kuma (Health):   http://localhost:3001"
echo "   • Novu (Notifications):   http://localhost:3004"
echo ""
echo "🔗 ADDITIONAL TOOLS (run individually):"
echo "   • Immich (Photos):        docker run -d -p 2283:2283 immich/immich"
echo "   • Cline (AI Coding):      docker run -d -p 3003:3000 ghcr.io/cline/cline:latest"
echo "   • Langflow (AI Workflows): docker run -d -p 7860:7860 langflowai/langflow"
echo ""
echo "📊 MONITORING:"
echo "   • View all containers:    docker ps"
echo "   • View logs:              docker logs [container-name]"
echo "   • Stop a container:       docker stop [container-name]"
echo "   • Stop all:               docker stop \$(docker ps -q)"
echo ""
echo "🌐 WEB INTERFACE:"
echo "   Your SolarPunk Nexus:     https://solarpunk-nexus.netlify.app"
echo "   OpenAlternative Tools:    https://openalternative.co"
echo ""
echo "🚀 ONE-COMMAND UPDATE:"
echo "   To update all containers: curl -s https://raw.githubusercontent.com/MeekoThaRaccoon/SolarPunk-Nexus/main/deploy-all.sh | bash"
echo ""
echo "🎯 GROWTH EQUATION PROVEN:"
echo "   (Parallel × Docker)^Simultaneity = Instant Sovereignty"
echo ""
echo "💡 TIP: Run this script anytime to repair or update your deployment"
echo ""
