#! /bin/bash

# to delete previous data of repos.
rm -rf repos
rm log 2>output
# urls of new repository of new repos directory.
urlFile=$1;

mkdir repos 2>output
cd repos 
urls=`cat ../$urlFile`

for url in $urls; do
   git clone $url 2>../output
done
rm ../output

repoNames=`ls`
serialNumber=1
for name in $repoNames; do
  cd $name
  mocha --recursive 1>output
  passingTests=`grep "passing" output | cut -d' ' -f3`
  failingTests=`grep "^Reference" output | wc -l`
  nyc mocha --recursive>output
  coverage=`grep "^All files" output | cut -d"|" -f5 `;
  commits=`git log --oneline | wc -l`
  lastCommitTime=`git log | grep "Date" | head -n1 | cut -d " " -f4-8`
  totalTests=$[passingTests+failingTests]
  log="$serialNumber, $name, $commits, $lastCommitTime, $coverage, $failingTests, $passingTests/$totalTests" 
  echo $log >> ../../log
  serialNumber=$[serialNumber+1]
  rm output
  cd ..
done 
cd ..
