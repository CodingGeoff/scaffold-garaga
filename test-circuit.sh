#!/bin/bash

# Test script for Zero Knowledge Proof: x ≠ y²
# This script tests various inputs to verify the circuit logic

set -e

echo "🧪 Testing Zero Knowledge Proof: x ≠ y²"
echo "========================================"

cd circuit

# Test 1: Valid case - x=5, y=2 (5 ≠ 4)
echo "Test 1: x=5, y=2 (should pass)"
echo "x = \"5\"" > Prover.toml
echo "y = \"2\"" >> Prover.toml
echo "Expected: 5 ≠ 2² = 4 ✅"
nargo execute witness
echo "✅ Test 1 passed"

echo ""

# Test 2: Invalid case - x=4, y=2 (4 = 4)
echo "Test 2: x=4, y=2 (should fail)"
echo "x = \"4\"" > Prover.toml
echo "y = \"2\"" >> Prover.toml
echo "Expected: 4 = 2² = 4 ❌"
if nargo execute witness 2>/dev/null; then
    echo "❌ Test 2 should have failed but didn't"
    exit 1
else
    echo "✅ Test 2 correctly failed"
fi

echo ""

# Test 3: Valid case - x=10, y=3 (10 ≠ 9)
echo "Test 3: x=10, y=3 (should pass)"
echo "x = \"10\"" > Prover.toml
echo "y = \"3\"" >> Prover.toml
echo "Expected: 10 ≠ 3² = 9 ✅"
nargo execute witness
echo "✅ Test 3 passed"

echo ""

# Test 4: Valid case - x=0, y=5 (0 ≠ 25)
echo "Test 4: x=0, y=5 (should pass)"
echo "x = \"0\"" > Prover.toml
echo "y = \"5\"" >> Prover.toml
echo "Expected: 0 ≠ 5² = 25 ✅"
nargo execute witness
echo "✅ Test 4 passed"

echo ""

# Test 5: Invalid case - x=16, y=4 (16 = 16)
echo "Test 5: x=16, y=4 (should fail)"
echo "x = \"16\"" > Prover.toml
echo "y = \"4\"" >> Prover.toml
echo "Expected: 16 = 4² = 16 ❌"
if nargo execute witness 2>/dev/null; then
    echo "❌ Test 5 should have failed but didn't"
    exit 1
else
    echo "✅ Test 5 correctly failed"
fi

echo ""
echo "🎉 All tests completed successfully!"
echo "The circuit correctly validates that x ≠ y²" 