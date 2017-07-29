#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>

#define BUFSIZE 256

const char* test_cases[] = {
  "1234567890",
  "qwertyuiop",
  "admin",
  "adminadmin",
  "the_quick_brown_fox_jumps_over_the_lazy_dog",
  "password",
  "correct horse battery staple",
  "P4$$W0RD",
  NULL
};

static  char buf[BUFSIZE];

int write_and_check(int fd, const char* str) {
  int ret;
  printf("  %s => ", str);

  ret = write(fd, str, strlen(str));
  if (ret < 0) {
    printf("[write fail]\n");
    return ret;
  }

  ret = read(fd, buf, BUFSIZE);      // Read the response from the LKM
  if (ret < 0){
    printf("[read fail]\n");
    return ret;
  }

  printf("%s ", buf);

  if(strncmp(str, buf, strlen(buf))) {
    printf("[fail]\n");
    return -1;
  }

  printf("[ok]\n");
  return 0;
}

int main(){
  int ret, fd, errno;

  srand(time(NULL));
  printf("Starting bkkcrypt-dev unit test\n");
  fd = open("/dev/bkkcrypt", O_RDWR);
  if (fd < 0){
    perror("Failed to open the device.\n");
    return errno;
  }


  printf("First test case group: anticipated passwords\n");

  int i = 0;
  while(test_cases[i] != NULL) {
    ret = write_and_check(fd, test_cases[i]);
    if (ret != 0){
      printf("\n====\nTest failed!\n\n");
      return ret;
    }
    ++i;
  }

  memset(buf, '\0', 255);


  printf("Second test case group: random strings\n");

  for(i = 0; i < 9; ++i) {
    int j;
    for(j = 0; j < 9; ++j) {
      buf[j] = (rand() % (126-32)) + 32;
    }
    buf[j] = '\0';

    ret = write_and_check(fd, buf);
    if (ret != 0){
      printf("\n====\nTest failed!\n\n");
      return ret;
    }
  }


  printf("Third test case group: Write lengths\n");

  for(i = 0; i < 255; ++i){
    buf[i] = 'A';
  }
  printf("  (255 long)");
  ret = write_and_check(fd, buf);

  buf[255] = 'A';
  printf("  (256 long)");
  ret = write_and_check(fd, buf);


  printf("Fourth test case group: Manually clearing\n");

  ret = write_and_check(fd, "test");
  if (ret != 0){
    printf("\n====\nTest failed!\n\n");
    return ret;
  }
  ret = write_and_check(fd, " ");
  if (ret != 0){
    printf("\n====\nTest failed!\n\n");
    return ret;
  }


  printf("\n====\nAll unit tests ran successfully!\n\n");

  return 0;
}
