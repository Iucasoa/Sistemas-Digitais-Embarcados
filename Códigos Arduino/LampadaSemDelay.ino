#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <stdint.h>


volatile uint8_t unlock_request = 0; 

ISR(INT0_vect) {

  unlock_request = 1;
  EIMSK &= ~(1 << INT0); 
}

void setup() {
  cli();

  DDRD &= ~(1 << PD2);

  PORTD |= (1 << PD2);

  DDRB |= (1 << PB5);

  PORTB &= ~(1 << PB5);

  EICRA |= (1 << ISC01);  
  EICRA &= ~(1 << ISC00); 
  EIFR  |= (1 << INTF0); 
  EIMSK |= (1 << INT0); 

  sei();
}

void loop() {
  if (unlock_request) {

    const uint16_t PULSE_MS = 700; 

    PORTB |= (1 << PB5);

    uint16_t t = PULSE_MS;
    while (t >= 100) { _delay_ms(100); t -= 100; }
    while (t > 0) { _delay_ms(1); t -= 1; }

    PORTB &= ~(1 << PB5);

    _delay_ms(60);

    unlock_request = 0;
    EIFR |= (1 << INTF0); 
    EIMSK |= (1 << INT0); 
  }

  // aqui poderia ir outras tarefas não bloqueantes se quiser
}
