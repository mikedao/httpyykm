# HTTP_yeah_you_know_me

### TESTING
#### Rakefile
The rakefile in this project creates a new thread which itself begins a server loop, then it runs the ruby test file, then it kills the open thread.
I kept running into problems with creating individual threads within indidual tests, but when I implemented it into the rake file it seemed to work.

#### Threading
Threading appears to me to be using the same memory to alternatively run multiple processes. 
At first I intended to use forking, which I understand to be the use of different memory running different processes, but I wasn't able to get it to work.
