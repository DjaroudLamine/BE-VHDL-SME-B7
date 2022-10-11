#include <stdio.h>
#include <stdlib.h>
#include "system.h"
#include "altera_avalon_pio_regs.h"

#define bp (unsigned int *) BUTTON_BASE
#define led (unsigned int *) LED_BASE

void delay(int a){
	volatile int i = 0;
	while (i<*1000){
		i++;
	}
}


int main()
{ 
  alt_putstr("Hello from Nios II!\n");

  /* Event loop never exits. */
  while (1);

  return 0;
}
