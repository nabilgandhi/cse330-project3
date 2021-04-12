#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[]){

  volatile int SIZE = 40;
  volatile int count = 0;

  if( argc == 2) {
    SIZE = atoi(argv[1]);
  } else {
    printf("Usage:\n");
    printf("%s <size>\n", argv[0]);
    exit(1);
  }
  
  int *array;
  array = (int *) malloc (SIZE*sizeof(int));

  printf("pid: %i\n", getpid());

  while(1){
    int i;
    for(i=0;i<SIZE;i++){
      array[i] = i;
      count += array[i];
    }
    sleep(1);
  }

  return count;
}
