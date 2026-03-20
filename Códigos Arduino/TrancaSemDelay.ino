
#include <avr/io.h> 
#include <util/delay.h>

ISR (INT0_vect){
  PORTB ^= (1<<5);
}

int main(){
  
  cli();


DDRB = DDRB | (1 << PB5);
DDRD = DDRD & ~(1 << PD2);
PORTD = PORTD | (1 << PD2);
  
EICRA |= (1<<ISC01);
EICRA &= ~(1<<ISC00);

EIMSK |= (1<<INT0);
  
sei();
  
  while (1) {;;}
  
 return 0;
}