#!/bin/bash

# LIO-mapping Dependency Checker
# This script helps verify that all required dependencies are available

echo "🔍 LIO-mapping Dependency Checker"
echo "=================================="

# Check ROS installation
echo -n "📦 Checking ROS installation... "
if command -v roscore &> /dev/null; then
    echo "✅ Found"
    echo "   ROS version: $(rosversion -d)"
else
    echo "❌ Not found"
    echo "   Please install ROS following the installation guide"
fi

# Check catkin tools
echo -n "🔧 Checking catkin build tools... "
if command -v catkin &> /dev/null; then
    echo "✅ Found (catkin_tools)"
elif command -v catkin_make &> /dev/null; then
    echo "✅ Found (catkin_make)"
else
    echo "❌ Not found"
    echo "   Install with: sudo apt install python-catkin-tools"
fi

# Check PCL
echo -n "☁️  Checking PCL library... "
if pkg-config --exists pcl_common-1.8 || pkg-config --exists pcl_common-1.9 || pkg-config --exists pcl_common-1.10; then
    echo "✅ Found"
    echo "   Version: $(pkg-config --modversion pcl_common-1.8 2>/dev/null || pkg-config --modversion pcl_common-1.9 2>/dev/null || pkg-config --modversion pcl_common-1.10 2>/dev/null || echo 'Unknown')"
else
    echo "❌ Not found"
    echo "   Install with: sudo apt install libpcl-dev"
fi

# Check OpenCV
echo -n "👁️  Checking OpenCV library... "
if pkg-config --exists opencv; then
    echo "✅ Found"
    echo "   Version: $(pkg-config --modversion opencv)"
else
    echo "❌ Not found"
    echo "   Install with: sudo apt install libopencv-dev"
fi

# Check Ceres Solver
echo -n "🎯 Checking Ceres Solver... "
if pkg-config --exists ceres; then
    echo "✅ Found"
    echo "   Version: $(pkg-config --modversion ceres)"
elif [ -f "/usr/local/include/ceres/ceres.h" ]; then
    echo "✅ Found (installed to /usr/local)"
else
    echo "❌ Not found"
    echo "   Install from source following the guide"
fi

# Check Eigen3
echo -n "📐 Checking Eigen3... "
if pkg-config --exists eigen3; then
    echo "✅ Found"
    echo "   Version: $(pkg-config --modversion eigen3)"
elif [ -d "/usr/include/eigen3" ]; then
    echo "✅ Found (system installation)"
else
    echo "❌ Not found"
    echo "   Install with: sudo apt install libeigen3-dev"
fi

# Check glog
echo -n "📝 Checking Google glog... "
if pkg-config --exists libglog; then
    echo "✅ Found"
else
    echo "❌ Not found"
    echo "   Install with: sudo apt install libgoogle-glog-dev"
fi

# Check gflags  
echo -n "🚩 Checking Google gflags... "
if pkg-config --exists gflags; then
    echo "✅ Found"
else
    echo "❌ Not found"
    echo "   Install with: sudo apt install libgflags-dev"
fi

echo ""
echo "🐳 Docker Alternative:"
echo "If you have issues with dependencies, consider using Docker:"
echo "  cd docker && ./build_docker.sh && ./run_docker.sh"

echo ""
echo "✅ Dependency check complete!"