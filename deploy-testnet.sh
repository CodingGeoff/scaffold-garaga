#!/bin/bash

# Deploy Zero Knowledge Proof: x ≠ y² to Starknet Sepolia Testnet
# This script helps deploy the verifier contract to Starknet testnet

set -e

echo "🚀 Deploying Zero Knowledge Proof: x ≠ y² to Starknet Sepolia Testnet"
echo "================================================================"

# Check if we're in the right directory
if [ ! -f "Makefile" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

# Check if virtual environment exists
if [ ! -d "garaga-venv" ]; then
    echo "❌ Error: Garaga virtual environment not found. Run 'make install-garaga' first"
    exit 1
fi

# Check if circuit is built
if [ ! -f "circuit/target/circuit.json" ]; then
    echo "🔨 Building circuit..."
    make build-circuit
fi

# Check if witness is generated
if [ ! -f "circuit/target/witness.gz" ]; then
    echo "📝 Generating witness..."
    make exec-circuit
fi

# Check if verification key exists
if [ ! -f "circuit/target/vk" ]; then
    echo "🔑 Generating verification key..."
    make gen-vk
fi

# Check if verifier is generated
if [ ! -d "contracts/verifier" ]; then
    echo "🏗️  Generating verifier contract..."
    make gen-verifier
fi

# Check if verifier is built
if [ ! -f "contracts/target/release/verifier_UltraStarknetHonkVerifier.contract_class.json" ]; then
    echo "🔨 Building verifier..."
    make build-verifier
fi

echo "✅ All prerequisites are ready!"
echo ""
echo "📋 Prerequisites for testnet deployment:"
echo "1. Make sure you have a funded account on Starknet Sepolia testnet"
echo "2. Get testnet tokens from: https://sepolia.starknet.io/"
echo "3. Configure your account in contracts/accounts.json"
echo ""
echo "🔧 Next steps:"
echo "1. Run: make declare-verifier-testnet"
echo "2. Copy the class hash from the output"
echo "3. Update the class hash in Makefile (deploy-verifier-testnet command)"
echo "4. Run: make deploy-verifier-testnet"
echo "5. Copy the deployed contract address"
echo "6. Update the contract address in app/src/App.tsx"
echo ""
echo "🌐 After deployment, you can access the app at: http://localhost:5173"
echo "   (Make sure to run 'make run-app' in another terminal)"

echo ""
echo "🎯 Ready to deploy! Run the commands above to continue." 