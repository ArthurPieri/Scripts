import sys 
print sys.stdin.read().replace('\r','').split('\n\n',2)[1]
