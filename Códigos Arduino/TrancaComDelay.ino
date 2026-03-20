#include <avr/io.h>
#include <util/delay.h>

int main(void){

    DDRB = DDRB | (1 << PB5);
    DDRD = DDRD & ~(1 << PD2);
    PORTD = PORTD | (1 << PD2);

    while (1) {

        if (!(PIND & (1 << PD2))) {

            _delay_ms(200);

            if (!(PIND & (1 << PD2))) {

                PORTB ^= (1 << PB5);

                while (!(PIND & (1 << PD2)));
            }
        }
    }
}

