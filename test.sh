echo ""
echo ""
echo ""
python3 gen_points.py -N=20 -mindist=2 -rseed=3 > test_generator1.in
# Test generator 1
echo "TEST 1"
diff -u test_generator1.out test_generator1.in > differences.txt

# Check if there are differences and if there are then store the diferences in differences.txt
if [ -s differences.txt ]; then
    echo "Test failed: Files differ. Differences sa ved to differences.txt."
    cat differences.txt
else
    echo "Test 1 passed: Files are identical."
    echo "This is the basic test to check the functionality of the program"
fi



echo ""
echo ""
echo ""
echo "TEST 2"
python3 gen_points.py -N=-1 -mindist=5 -rseed=42 2> test_generator2.in
diff -u test_generator2.out test_generator2.in > differences1.txt
if [ -s differences1.txt ]; then
    echo "Test failed: Files differ. Differences saved to differences1.txt."
    cat differences1.txt
else
    echo "Test 2 passed: Files are identical."
    echo "This is to check if the user gives invalid input for N."
fi



echo ""
echo ""
echo ""
echo "TEST 3"
python3 gen_points.py -N=1 -mindist=20 -rseed=42 2> test_generator3.in
diff -u test_generator3.out test_generator3.in > differences2.txt
if [ -s differences2.txt ]; then
    echo "Test failed: Files differ. Differences saved to differences2.txt."
    cat differences2.txt
else
    echo "Test 3 passed: Files are identical."
    echo "This is to check if the user gives invalid input for mindist."
fi



echo ""
echo ""
echo ""
echo "TEST 4"
python3 gen_points.py -N=10000 -mindist=5 -rseed=42 2> test_generator4.in
diff -u test_generator4.out test_generator4.in > differences3.txt
if [ -s differences3.txt ]; then
    echo "Test failed: Files differ. Differences saved to differences3.txt."
    cat differences3.txt
else
    echo "Test 4 passed: Files are identical."
    echo "This is to check if tN is not greater than the requirement."
fi



echo ""
echo ""
echo ""
echo "TEST 5"
python3 gen_points.py -N=1 -mindist=-1 -rseed=42 2> test_generator5.in
diff -u test_generator5.out test_generator5.in > differences4.txt
if [ -s differences4.txt ]; then
    echo "Test failed: Files differ. Differences saved to differences4.txt."
    cat differences4.txt
else
    echo "Test 5 passed: Files are identical."
    echo "This is to check if mindist is not less than the requirement."
fi



echo ""
echo ""
echo ""
echo "Testing Searcher:"
echo ""
echo ""
echo ""
echo "TEST 1"
gcc smallest_triangle.c -o smallest_triangle
./smallest_triangle > test_searcher1.in
diff -u test_searcher1.out test_searcher1.in > difference1.txt
if [ -s difference1.txt ]; then
    echo "Test failed: Files differ. Differences saved to difference1.txt."
    cat difference1.txt
else
    echo "Test 1 passed."
    echo "This is to check is it is a triangle."
fi



echo ""
echo ""
echo ""
echo "TEST 2"
gcc smallest_triangle.c -o smallest_triangle
./smallest_triangle > test_searcher2.in
diff -u test_searcher2.out test_searcher2.in > difference2.txt
if [ -s difference2.txt ]; then
    echo "Test failed: Files differ. Differences saved to difference2.txt."
    cat difference2.txt
else
    echo "Test 2 passed."
    echo "This is to check if it stores invalid input."
fi




echo ""
echo ""
echo ""
echo "TEST 3"
gcc smallest_triangle.c -o smallest_triangle
./smallest_triangle > test_searcher3.in
diff -u test_searcher3.out test_searcher3.in > difference3.txt
if [ -s difference3.txt ]; then
    echo "Test failed: Files differ. Differences saved to difference3.txt."
    cat difference3.txt
else
    echo "Test 3 passed."
    echo "This is to check for one point."
fi


echo ""
echo ""
echo ""
echo "TEST 4"
gcc smallest_triangle.c -o smallest_triangle
./smallest_triangle > test_searcher4.in
diff -u test_searcher4.out test_searcher4.in > difference4.txt
if [ -s difference4.txt ]; then
    echo "Test failed: Files differ. Differences saved to difference4.txt."
    cat difference4.txt
else
    echo "Test 4 passed."
    echo "This is to check is its not a triangle."
fi



echo ""
echo ""
echo ""
echo "TEST 5"
gcc smallest_triangle.c -o smallest_triangle
./smallest_triangle > test_searcher5.in
diff -u test_searcher5.out test_searcher5.in > difference5.txt
if [ -s difference5.txt ]; then
    echo "Test failed: Files differ. Differences saved to difference5.txt."
    cat difference5.txt
else
    echo "Test 5 passed."
    echo "This is to check if the input is not equal to or more than 3 decimal point."
fi


echo ""
echo ""
echo ""
echo "Testing for piping"
echo "Test 1"
python3 gen_points.py -N=2 -mindist=2 -rseed=3 > test_pipe1.in | gcc smallest_triangle.c -o smallest_triangle
./smallest_triangle < test_pipe1.in > test_pipe1.out

diff -u test_pipe1.expected test_pipe1.out > new.txt
if [ -s new.txt ]; then
    echo "Test failed: Files differ. Differences saved to new.txt."
    cat new.txt
else
    echo "Test passed."
    echo "This is to check if the basic piping works."
fi

echo ""
echo ""
echo ""
echo "Test 2"
gcc smallest_triangle.c -o smallest_triangle
python3 gen_points.py -N=3 -rseed=2 2>&1| ./smallest_triangle
exit_code=$?
if [ $exit_code -eq 1 ]; then
    echo "Test Passed: Missing Argument mindist for Generator"
else
    echo "Test Failed: Missing Argument mindist for Generator"
fi



echo ""
echo ""
echo ""
echo "Test 3"
gcc smallest_triangle.c -o smallest_triangle
python3 gen_points.py -mindist=3 -rseed=2 2>&1| ./smallest_triangle
exit_code=$?
if [ $exit_code -eq 1 ]; then
    echo "Test Passed: Missing Argument N for Generator"
else
    echo "Test Failed: Missing Argument N for Generator"
fi



echo ""
echo""
echo ""
echo "Test 4"
python3 gen_points.py -N=3 -rseed=2 | ./smallest_triangle 
if [ $? -ne 0 ]; then
    echo "Error: The command failed."
    exit 1
fi

echo "The test completed successfully."


echo ""
echo""
echo ""
echo "Test 5"
python3 gen_points.py -N=-5 -mindist=2 -rseed=42 | ./smallest_triangle 
# Capture the exit code of the last command
exit_code=$?
# Check if the exit code indicates the expected error (-1)
if [ $exit_code -ne -1 ]; then
    echo "Test Passed: Invalid Input for Generator"
else
    echo "Test Failed: Invalid Input for Generator"
fi



