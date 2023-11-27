# Set classpath
CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

# Remove existing directories
rm -rf student-submission
rm -rf grading-area

# Create grading-area directory
mkdir grading-area

# Clone the repository of the student submission
git clone "$1" student-submission
echo 'Finished cloning'

# Check if the expected file is present in the student submission
if [ ! -e "student-submission/ListExamples.java" ]; then
    echo "Expected file not found. Please submit the correct file."
    exit 1
fi

# Move necessary files to grading-area directory
cp -r student-submission/*.java grading-area/
cp -r TestListExamples.java grading-area/

# Compile tests and student code
javac -cp "$CPATH:grading-area/" grading-area/*.java

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Compilation failed. Please check your code and try again."
    exit 1
fi

# Run tests and report grade based on JUnit output
java -cp "$CPATH:grading-area/" org.junit.runner.JUnitCore YourTestClassName | grep -E "OK|FAILURES" | grep -v "Time:"




# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests


#1. Clone the repository of the student submission to a well-known directory name (provided in starter code)
#     This is done by the git clone command in the provided script
#2. Check that the student code has the correct file submitted. If they didn’t, detect and give helpful
#     feedback about it. This is not done by the provided code, you should figure out where to add it
#   - Useful tools here are if and -e/-f. You can use the exit command to quit a bash script early.
#     These are summarized in the week 5 Wednesday lecture handout
#3. Get the student code, the .java file with the grading tests, and any other files the script needs into
#     the grading-area directory. The grading-area directory is created for you, but you should move the files
#     there.
#   - Useful tools here might be cp (also look up the -r option to cp)
#4. Compile your tests and the student’s code from the appropriate directory with the appropriate classpath
#     commands (remember that if you’re testing locally on Windows, the classpath is different). If the
#     compilation fails, detect and give helpful feedback about it. You should add this
#   - Aside from the necessary javac, useful tools here are output redirection and error codes ($?) along with
#     if
#   - This might be a time where you need to turn off set -e. Why?
#5. Run the tests and report the grade based on the JUnit output. You should add this
#   - Again output redirection will be useful, and also tools like grep could be helpful here
