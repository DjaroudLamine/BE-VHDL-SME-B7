#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include "system.h"
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"


#define boutons (unsigned int *) BP_BASE
#define leds (unsigned int *) LED_BASE
#define freq (volatile int *) PWM_0_BASE
#define duty (volatile int *) (PWM_0_BASE + 4)
#define control (volatile int *) (PWM_0_BASE +8 )

unsigned char a;


int main()
{ 

	unsigned int b, c, d;
    alt_putstr("Hello from Nios II!\n");
      *freq = 1024;
      *duty = 512;
      *control = 3;
      b=*freq;
      c=*duty;
      d=*control;



  /* Event loop never exits. */
  while (1)
  {
   printf(" while An");
   printf("freg= %d \n",b);
  if (*boutons == 1)
   {
     printf("if if if");
     *leds = 255;
     *freq = 1024;
   }
  else *leds = 152;
  }
  return 0;
}
