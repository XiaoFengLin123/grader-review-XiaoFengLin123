CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f student-submission/ListExamples.java ]]
then
    echo "ListExamples.java file found." 
else 
    echo "ListExamples.java file not found"
    echo "Grade: 0" 
    exit 
fi 

cp TestListExamples.java student-submission/ListExamples.java grading-area
cp -r lib grading-area 

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

cd grading-area 
pwd
javac -cp $CPATH *.java

echo "The exit code for the compile step is $?." 

if [[ $? == 0 ]] 
then 
    #java TestListExamples.java ListExamples.java
    echo "The file compile correctly"  
else
    echo "The file didn't compile correctly"
    exit
fi

java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > test.txt
passed_tests=$(grep -c "OK" test.txt)
failed_tests=$(grep -c "FAILURES" test.txt)

echo "Number of passed tests: $passed_tests"
echo "Number of failed tests: $failed_tests"

if [ "$failed_tests" -eq 0 ]; then
    echo "All tests passed!"
else
    echo "Some tests failed."
fi

